%% -------------------------------------------------------------------
%%
%% dccaserver: Erlang OTP Diameter Credit Control Application
%%
%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc Diameter callback module
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License. You may obtain
%% a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied. See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(server_cb).

-include_lib("diameter/include/diameter.hrl").
-include_lib("diameter_settings.hrl").
-include_lib("rfc4006_cc_Gy.hrl").

%% diameter callbacks
-export([
    peer_up/3,
    peer_down/3,
    pick_peer/4,
    prepare_request/3,
    prepare_retransmit/3,
    handle_answer/4,
    handle_error/4,
    handle_request/3
]).

-define(UNEXPECTED, erlang:error({unexpected, ?MODULE, ?LINE})).

peer_up(_SvcName, {PeerRef, Caps}, State) ->
    lager:info("Peer up: ~p - ~p~n", [PeerRef, lager:pr(Caps, ?MODULE)]),
    State.

peer_down(_SvcName, {PeerRef, Caps}, State) ->
    lager:info("Peer down: ~p - ~p~n", [PeerRef, lager:pr(Caps, ?MODULE)]),
    State.

pick_peer(_, _, _SvcName, _State) ->
    ?UNEXPECTED.

prepare_request(_, _SvcName, _Peer) ->
    ?UNEXPECTED.

prepare_retransmit(_Packet, _SvcName, _Peer) ->
    ?UNEXPECTED.

handle_answer(_Packet, _Request, _SvcName, _Peer) ->
    ?UNEXPECTED.

handle_error(_Reason, _Request, _SvcName, _Peer) ->
    lager:error("Request error: ~p~n", [_Reason]),
    ?UNEXPECTED.

%% A request whose decode was successful ...
handle_request(#diameter_packet{msg = Req, errors = []}, _SvcName, {_, Caps}) when
    is_record(Req, 'CCR')
->
    #diameter_caps{origin_host = {OH, _}, origin_realm = {OR, _}} = Caps,
    #'CCR'{
        'Session-Id' = SessionId,
        'Auth-Application-Id' = ?DCCA_APPLICATION_ID,
        'CC-Request-Type' = ReqType,
        'Framed-IP-Address' = FramedIP,
        'CC-Request-Number' = ReqNum,
        % 'Service-Context-Id' = ServiceContextId,
        'Event-Timestamp' = EventTimestamp,
        'Subscription-Id' = Subscription,
        'Multiple-Services-Credit-Control' = MSCC,
        % 'Service-Information' = [ServiceInformation]
        'Called-Station-Id' = APN
    } = Req,
    MSISDN = getSubscriptionId(?MSISDN, Subscription),
    IMSI = getSubscriptionId(?IMSI, Subscription),
    lager:info(
        "{RequestType, ~p}:{RequestNumber, ~p}:{Framed-IP-Adress, ~p}:{CCR, ~p}:{MSCC, ~p}",
        [ReqType, ReqNum, FramedIP, lager:pr(Req, ?MODULE), lager:pr(MSCC, ?MODULE)]
    ),
    MSCC_Data =
        process_mscc(ReqType, MSCC, {APN, IMSI, MSISDN, "10.0.0.1", SessionId, EventTimestamp}),
    {reply, answer(ok, ReqType, ReqNum, SessionId, OH, OR, MSCC_Data)};
%% ... or one that wasn't. 3xxx errors are answered by diameter itself
%% but these are 5xxx errors for which we must contruct a reply.
%% diameter will set Result-Code and Failed-AVP's.
handle_request(#diameter_packet{msg = Req, errors = Err}, _SvcName, {_, Caps}) when
    is_record(Req, 'CCR')
->
    #diameter_caps{origin_host = {OH, _}, origin_realm = {OR, _}} = Caps,
    #'CCR'{
        'Session-Id' = SessionId,
        'CC-Request-Type' = ReqType,
        'Framed-IP-Address' = FramedIP,
        'CC-Request-Number' = ReqNum,
        'Multiple-Services-Credit-Control' = MSCC
    } = Req,
    lager:info(
        "{RequestType, ~p}:{RequestNumber, ~p}:{Framed-IP-Adress, ~p}:{Error, ~p}:{CCR, ~p}:{MSCC, "
        "~p}",
        [ReqType, ReqNum, FramedIP, Err, lager:pr(Req, ?MODULE), lager:pr(MSCC, ?MODULE)]
    ),
    {reply, answer(err, ReqType, ReqNum, SessionId, OH, OR, [])};
%% Should really reply to other base messages that we don't support
%% but simply discard them instead.
handle_request(#diameter_packet{}, _SvcName, {_, _}) ->
    lager:error("Unsupported message.~n"),
    discard.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

%% Get Subscription Type from Subs list
getSubscriptionId(Type, [Subs = #'Subscription-Id'{'Subscription-Id-Type' = Type} | _]) ->
    Subs#'Subscription-Id'.'Subscription-Id-Data';
getSubscriptionId(Type, [_ | T]) ->
    getSubscriptionId(Type, T);
getSubscriptionId(_, []) ->
    subscription_not_found.

%% Process MSCC
process_mscc(ReqType, [MSCC | T], SessionData) ->
    lager:debug("Process_MSCC ~p~n", [MSCC]),
    lager:debug("Process_MSCC T ~p~n", [T]),
    #'Multiple-Services-Credit-Control'{
        'Used-Service-Unit' = USU,
        'Requested-Service-Unit' = RSU,
        'Service-Identifier' = [ServiceId],
        'Rating-Group' = [RatingGroup]
    } = MSCC,
    lager:debug("USU: ~w~n", [USU]),
    lager:debug("RSU: ~w~n", [RSU]),
    case {RSU, USU} of
        {[_], []} ->
            % Have RSU. No USU (First interrogation)
            lager:info("Have RSU. No USU (First interrogation)"),
            prometheus_counter:inc(dcca_mscc_interrogation, [dccaserver, first]),
            {ResultCode, GrantedUnits} =
                ocsgateway:ocs_charge({initial, SessionData, {0, ServiceId, RatingGroup}});
        {[_], [_]} ->
            % Have RSU. Have USU (Next interrogation)
            lager:info("Have RSU. Have USU (Next interrogation)"),
            prometheus_counter:inc(dcca_mscc_interrogation, [dccaserver, next]),
            [#'Used-Service-Unit'{'CC-Total-Octets' = [UsedUnits]}] = USU,
            {ResultCode, GrantedUnits} =
                ocsgateway:ocs_charge({update, SessionData, {UsedUnits, ServiceId, RatingGroup}});
        {[], [_]} ->
            % No RSU. Have USU (Last interrogation)
            lager:info("No RSU. Have USU (Last interrogation)"),
            prometheus_counter:inc(dcca_mscc_interrogation, [dccaserver, last]),
            [#'Used-Service-Unit'{'CC-Total-Octets' = [UsedUnits]}] = USU,
            {ResultCode, GrantedUnits} =
                ocsgateway:ocs_charge({terminate, SessionData, {UsedUnits, ServiceId, RatingGroup}})
    end,
    % receive
    %     {ResultCode, GrantedUnits} -> {ResultCode, GrantedUnits}
    % end,
    [
        {ServiceId, RatingGroup, GrantedUnits, ResultCode}
        | process_mscc(
            ReqType,
            T,
            SessionData
        )
    ];
process_mscc(_, [], _) ->
    [].

%% ---------------------------------------------------------------------------

%% Answer using the record or list encoding depending on
%% Re-Auth-Request-Type. This is just as an example. You would
%% typically just choose one, and this has nothing to do with the how
%% client.erl sends.

answer(ok, ReqType, ReqNum, SessionId, OH, OR, MSCC) ->
    %% DIAMETER_SUCCESS
    #'CCA'{
        'Result-Code' = 2001,
        'Origin-Host' = OH,
        'Origin-Realm' = OR,
        'Session-Id' = SessionId,
        'Auth-Application-Id' = ?DCCA_APPLICATION_ID,
        'CC-Request-Type' = ReqType,
        'CC-Request-Number' = ReqNum,
        %'Termination-Cause' = [] %% Only used on TERMINATE
        'Multiple-Services-Credit-Control' = mscc_answer(MSCC)
    };
answer(err, ReqType, ReqNum, SessionId, OH, OR, []) ->
    %% DIAMETER_UNABLE_TO_COMPLY
    #'CCA'{
        'Result-Code' = 5012,
        'Origin-Host' = OH,
        'Origin-Realm' = OR,
        'Session-Id' = SessionId,
        'Auth-Application-Id' = ?DCCA_APPLICATION_ID,
        'CC-Request-Type' = ReqType,
        'CC-Request-Number' = ReqNum
    }.

mscc_answer([MSCC | T]) ->
    lager:debug("mscc_answer:~n"),
    lager:debug("MSCC: ~p~n", [MSCC]),
    % lager:debug("T: ~w~n",[T]),
    {ServiceId, RatingGroup, GrantedUnits, _ResultCode} = MSCC,
    [
        #'Multiple-Services-Credit-Control'{
            'Granted-Service-Unit' =
                [
                    #'Granted-Service-Unit'{
                        'CC-Total-Octets' =
                            [GrantedUnits],
                        'CC-Input-Octets' = [],
                        'CC-Output-Octets' = [],
                        'CC-Service-Specific-Units' =
                            [],
                        'AVP' = []
                    }
                ],
            'Service-Identifier' = [ServiceId],
            'Rating-Group' = [RatingGroup],
            'Validity-Time' = [3600],
            'Result-Code' = [2001]
        }
        %'Final-Unit-Indication' = [],
        | mscc_answer(T)
    ];
mscc_answer([]) ->
    [].
