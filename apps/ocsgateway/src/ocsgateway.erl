%% -------------------------------------------------------------------
%%
%% dccaserver: Erlang OTP Diameter Credit Control Application
%%
%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc gen_server
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

-module(ocsgateway).

-behaviour(gen_server).

-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, start/0]).
-export([ocs_charge/1]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start() ->
    start_link().

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

ocs_charge(Request) ->
    gen_server:call(?SERVER, {intm, Request}).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init(Args) ->
    {ok, Args}.

handle_call({intm, {Event, SessionData, EventData}}, _From, State) ->
    {APN, IMSI, MSISDN, Location, SessionId, EventTimestamp} = SessionData,
    {ConsumedResources, ServiceID, RatingGroup} = EventData,
    StartTime = timestamp(EventTimestamp),
    case Event of
        initial ->
            lager:info(
                "[{7,\"OtherParty\",[{5,\"APN\",\"~s\"}]},{3,\"MessageType\",2},{7,\""
                "ServedParty\",[{5,\"IMSI\",\"~s\"},{5,\"MSISDN\",\"~s\"},{5,\"Locati"
                "on\",\"~s\"}]},{5,\"Version\",\"5.00.0\"},{5,\"SessionId\",\"~s\"},{"
                "7,\"Resources\",[{7,\"R_1\",[{5,\"StartTime\",\"~s\"},{1,\"ConsumedR"
                "esources\",~B},{5,\"SubServiceType\",\"~2..0B/~3..0B\"},{3,\"Reporti"
                "ngReason\",50},{1,\"RequestedResources\",-1},{5,\"ServiceType\",\"GP"
                "RS:0:~2..0B:~3..0B\"},{3,\"QuotaType\",0},{3,\"Id\",~B~3..0B}]}]}]~n"
                "",
                [
                    APN,
                    IMSI,
                    MSISDN,
                    Location,
                    SessionId,
                    StartTime,
                    ConsumedResources,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup
                ]
            );
        update ->
            lager:info(
                "[{7,\"OtherParty\",[{5,\"APN\",\"~s\"}]},{3,\"MessageType\",2},{7,\""
                "ServedParty\",[{5,\"IMSI\",\"~s\"},{5,\"MSISDN\",\"~s\"},{5,\"Locati"
                "on\",\"~s\"}]},{5,\"Version\",\"5.00.0\"},{5,\"SessionId\",\"~s\"},{"
                "7,\"Resources\",[{7,\"R_1\",[{5,\"StartTime\",\"~s\"},{1,\"ConsumedR"
                "esources\",~B},{5,\"SubServiceType\",\"~2..0B/~3..0B\"},{3,\"Reporti"
                "ngReason\",3},{1,\"RequestedResources\",-1},{5,\"ServiceType\",\"GPR"
                "S:0:~2..0B:~3..0B\"},{3,\"QuotaType\",3},{3,\"Id\",~B~3..0B}]}]}]~n",
                [
                    APN,
                    IMSI,
                    MSISDN,
                    Location,
                    SessionId,
                    StartTime,
                    ConsumedResources,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup
                ]
            );
        terminate ->
            lager:info(
                "[{7,\"OtherParty\",[{5,\"APN\",\"~s\"}]},{3,\"MessageType\",2},{7,\""
                "ServedParty\",[{5,\"IMSI\",\"~s\"},{5,\"MSISDN\",\"~s\"},{5,\"Locati"
                "on\",\"~s\"}]},{5,\"Version\",\"5.00.0\"},{5,\"SessionId\",\"~s\"},{"
                "7,\"Resources\",[{7,\"R_1\",[{5,\"StartTime\",\"~s\"},{1,\"ConsumedR"
                "esources\",~B},{5,\"SubServiceType\",\"~2..0B/~3..0B\"},{3,\"Reporti"
                "ngReason\",2},{1,\"RequestedResources\",-1},{5,\"ServiceType\",\"GPR"
                "S:0:~2..0B:~3..0B\"},{3,\"QuotaType\",3},{3,\"Id\",~B~3..0B}]}]}]~n",
                [
                    APN,
                    IMSI,
                    MSISDN,
                    Location,
                    SessionId,
                    StartTime,
                    ConsumedResources,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup,
                    ServiceID,
                    RatingGroup
                ]
            )
    end,
    GrantedQuota = 300000,
    ResultCode = 1,
    {reply, {ResultCode, GrantedQuota}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

timestamp([{{YY, MM, DD}, {Hour, Min, Sec}}]) ->
    io_lib:format("~4..0w~2..0w~2..0w~2..0w~2..0w~2..0w", [YY, MM, DD, Hour, Min, Sec]);
timestamp([]) ->
    {YY, MM, DD} = date(),
    {Hour, Min, Sec} = time(),
    io_lib:format("~4..0w~2..0w~2..0w~2..0w~2..0w~2..0w", [YY, MM, DD, Hour, Min, Sec]).
