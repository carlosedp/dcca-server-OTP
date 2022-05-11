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

-module(dccaserver).

-behaviour(gen_server).

-include_lib("diameter_settings.hrl").

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------
-export([start_link/0]).
-export([start/0, stop/0, terminate/2]).
%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).
-export([code_change/3]).

-define(SERVER, ?MODULE).

%%%.
%%%'   Diameter Application Definitions

%% Diameter stats
-define(DIA_STATS_TAB, dcca_stats).
-define(DIA_STATS_COUNTERS, [event_OK, event_ERR]).
%% Server parameters
-define(SVC_NAME, ?MODULE).
-define(APP_ALIAS, ?MODULE).
-define(CALLBACK_MOD, server_cb).
-define(DIAMETER_DICT_CCRA, rfc4006_cc_Gy).
%% The service configuration. In a server supporting multiple Diameter
%% applications each application may have its own, although they could all
%% be configured with a common callback module.
-define(SERVICE(Name),
        [{'Origin-Host', application:get_env(?SERVER, origin_host, "example.com")},
         {'Origin-Realm', application:get_env(?SERVER, origin_realm, "realm.example.com")},
         {'Vendor-Id', application:get_env(?SERVER, vendor_id, 0)},
         {'Product-Name', "DCCA Server"},
         {'Auth-Application-Id', [?DCCA_APPLICATION_ID]},
         {application,
          [{alias, ?APP_ALIAS}, {dictionary, ?DIAMETER_DICT_CCRA}, {module, ?CALLBACK_MOD}]}]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

%% @doc starts gen_server implementation and caller links to the process too.
-spec start_link() -> {ok, Pid} | ignore | {error, Error}
    when Pid :: pid(),
         Error :: {already_started, Pid} | term().
start_link() ->
    % TODO: decide whether to name gen_server callback implementation or not.
    % gen_server:start_link(?MODULE, [], []). % for unnamed gen_server
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% @doc starts gen_server implementation process
-spec start() -> ok | {error, term()}.
start() ->
    application:ensure_all_started(?MODULE),
    start_link().

%% @doc stops gen_server implementation process
-spec stop() -> ok.
stop() ->
    gen_server:cast(?SERVER, stop).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------
init(State) ->
    SvcName = ?MODULE,
    diameter:start_service(SvcName, ?SERVICE(SvcName)),
    Ip = application:get_env(?SERVER, server_ip, "127.0.0.1"),
    Port = application:get_env(?SERVER, diameter_port, 3868),
    Proto = application:get_env(?SERVER, diameter_proto, tcp),
    listen({address, Proto, Ip, Port}),
    lager:info("Diameter DCCA Server ~s started on ~p IP ~s, port ~p~n",
               [?SERVER, Proto, Ip, Port]),
    {ok, State}.

%% @callback gen_server
handle_call(_Req, _From, State) ->
    {noreply, State}.

%% @callback gen_server
handle_cast(stop, State) ->
    {stop, normal, State};
handle_cast(_Req, State) ->
    {noreply, State}.

%% @callback gen_server
handle_info(_Info, State) ->
    {noreply, State}.

%% @callback gen_server
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% @callback gen_server
terminate(normal, _State) ->
    diameter:stop_service(?SVC_NAME),
    lager:info("Diameter DCCA Application stopped.~n"),
    ok;
terminate(shutdown, _State) ->
    ok;
terminate({shutdown, _Reason}, _State) ->
    ok;
terminate(_Reason, _State) ->
    ok.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

%% listen/2
listen(Name, {address, Protocol, IPAddr, Port}) ->
    {ok, IP} = inet_parse:address(IPAddr),
    TransportOpts =
        [{transport_module, tmod(Protocol)},
         {transport_config, [{reuseaddr, true}, {ip, IP}, {port, Port}]}],
    diameter:add_transport(Name, {listen, TransportOpts}).

listen(Address) ->
    listen(?SVC_NAME, Address).

%% Convert connection type
tmod(tcp) ->
    diameter_tcp;
tmod(sctp) ->
    diameter_sctp.
