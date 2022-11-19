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
-export([trace/0, trace/1, timestamp/0]).
%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).
-export([code_change/3]).

-define(SERVER, ?MODULE).

%%%.
%%%'   Diameter Application Definitions

%% Server parameters
-define(SVC_NAME, ?MODULE).
-define(APP_ALIAS, ?MODULE).
-define(CALLBACK_MOD, server_cb).
-define(DIAMETER_DICT_CCRA, rfc4006_cc_Gy).
%% @doc Service Definition
%% The service configuration. In a server supporting multiple Diameter
%% applications each application may have its own, although they could all
%% be configured with a common callback module.
-define(SERVICE(Name), [
    {'Origin-Host', application:get_env(?SERVER, origin_host, "example.com")},
    {'Origin-Realm', application:get_env(?SERVER, origin_realm, "realm.example.com")},
    {'Vendor-Id', application:get_env(?SERVER, vendor_id, 0)},
    {'Product-Name', "DCCA Server"},
    {'Auth-Application-Id', [?DCCA_APPLICATION_ID]},
    {application, [{alias, ?APP_ALIAS}, {dictionary, ?DIAMETER_DICT_CCRA}, {module, ?CALLBACK_MOD}]}
]).

%% Application Prometheus Metrics
init_metrics() ->
    prometheus_httpd:start(),
    {_, Port} =
        lists:keyfind(port, 1, application:get_env(prometheus, prometheus_http, 1234)),
    lager:notice(
        "Initializing Prometheus Metrics on http://0.0.0.0:~p/metrics~n",
        [Port]
    ),
    prometheus_counter:new([
        {name, dcca_mscc_interrogation},
        {help, "MSCC Interrogation counter by type"},
        {labels, [svc, type]}
    ]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

%% @doc starts gen_server implementation and caller links to the process too.
-spec start_link() -> {ok, Pid} | ignore | {error, Error} when
    Pid :: pid(),
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
    Port = application:get_env(?SERVER, diameter_port, 3868),
    Proto = application:get_env(?SERVER, diameter_proto, tcp),
    listen({address, Proto, Port}),
    init_metrics(),
    lager:notice("Diameter DCCA Server ~s started on ~p IPs ~s, port ~p~n", [
        ?SERVER, Proto, ip_string(), Port
    ]),
    {ok, State}.

%% callback gen_server
handle_call(_Req, _From, State) ->
    {noreply, State}.

%% callback gen_server
handle_cast(stop, State) ->
    {stop, normal, State};
handle_cast(_Req, State) ->
    {noreply, State}.

%% callback gen_server
handle_info(_Info, State) ->
    {noreply, State}.

%% callback gen_server
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% callback gen_server
terminate(normal, _State) ->
    diameter:stop_service(?SVC_NAME),
    lager:notice("Diameter DCCA Application stopped.~n"),
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
listen(Name, {address, Protocol, Port}) ->
    % Listen on all interfaces
    {ok, IP} = inet_parse:address("0.0.0.0"),
    TransportOpts =
        [
            {transport_module, tmod(Protocol)},
            {transport_config, [{reuseaddr, true}, {ip, IP}, {port, Port}]}
        ],
    diameter:add_transport(Name, {listen, TransportOpts}).

listen(Address) ->
    listen(?SVC_NAME, Address).

%% @doc Collects the list of IP addresses current node has.
get_ips() ->
    {ok, Interfaces} = inet:getif(),
    [IP || {IP, _, _} <- Interfaces].

ip_string() ->
    string:join([inet:ntoa(IP) || IP <- get_ips()], ",").

%% @doc Convert connection type
tmod(tcp) ->
    diameter_tcp;
tmod(sctp) ->
    diameter_sctp.

%% @doc shortcut to trace the server execution for 10 seconds
trace() ->
    trace(10).

%% @doc traces the server execution for specific time in seconds
%% @param Seconds :: integer()
trace(Seconds) ->
    lager:notice("Tracing started...~n"),
    File = "flame-" ++ timestamp() ++ ".trace",
    eflame2:write_trace(global_calls_plus_new_procs, File, all, Seconds * 1000),
    eflame2:format_trace(File, File ++ ".out"),
    file:delete(File),
    lager:notice("Tracing finished!~n").

%% @doc generate a timestamp in the format YYYY-MM-DDTHH:MM:SS
timestamp() ->
    {{Year, Month, Day}, {Hour, Minute, Second}} = calendar:now_to_datetime(erlang:timestamp()),
    lists:flatten(
        io_lib:format("~4..0w-~2..0w-~2..0wT~2..0w:~2..0w:~2..0w", [
            Year, Month, Day, Hour, Minute, Second
        ])
    ).
