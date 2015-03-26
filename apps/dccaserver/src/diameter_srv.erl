%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc gen_server callback module implementation:
%%
%% @end
-module(diameter_srv).
-author('Carlos Eduardo de Paula <carlosedp@gmail.com>').

-behaviour(gen_server).

-include_lib("diameter/include/diameter.hrl").
-include_lib("diameter/include/diameter_gen_base_rfc3588.hrl").
-include_lib("diameter_settings.hrl").

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).
-export([code_change/3]).
-export([stop/0, terminate/2]).

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
-define(SERVICE(Name), [{'Origin-Host', ?ORIGIN_HOST},
                        {'Origin-Realm', ?ORIGIN_REALM},
                        {'Vendor-Id', ?VENDOR_ID},
                        {'Product-Name', "Server"},
                        {'Auth-Application-Id', [?DCCA_APPLICATION_ID]},
                        {application,
                            [{alias, ?APP_ALIAS},
                            {dictionary, ?DIAMETER_DICT_CCRA},
                            {module, ?CALLBACK_MOD}]
                        }]).



%% @doc starts gen_server implementation and caller links to the process too.
-spec start_link() -> {ok, Pid} | ignore | {error, Error}
  when
      Pid :: pid(),
      Error :: {already_started, Pid} | term().
start_link() ->
  % TODO: decide whether to name gen_server callback implementation or not.
  % gen_server:start_link(?MODULE, [], []). % for unnamed gen_server
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% @doc stops gen_server implementation process
-spec stop() -> ok.
stop() ->
  gen_server:cast(?SERVER, stop).

% TODO: add more public API here...

%%%.
%%%'   CALLBACKS
%% @callback gen_server
init(State) ->
  SvcName = ?MODULE,
  OCS = ocs:start(ocs_intm),
  register(ocs, OCS),
  common_stats:init(?DIA_STATS_TAB, ?DIA_STATS_COUNTERS),
  diameter:start_service(SvcName, ?SERVICE(SvcName)),
  listen({address, ?DIAMETER_PROTO, ?DIAMETER_IP, ?DIAMETER_PORT}),
  error_logger:info_msg("Diameter DCCA Application Listening on port ~p~n", [?DIAMETER_PORT]),
  {ok, State}.

%% @callback gen_server
handle_call(_Req, _From, State) ->
  {reply, State}.
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
    common_stats:terminate(?DIA_STATS_TAB),
    diameter:stop_service(?SVC_NAME),
    error_logger:info_msg("Diameter DCCA Application stopped.~n"),
    ok;
terminate(shutdown, _State) ->
  ok;
terminate({shutdown, _Reason}, _State) ->
  ok;
terminate(_Reason, _State) ->
  ok.
%%%.
%%%'   PRIVATE FUNCTIONS

%% listen/2

listen(Name, {address, Protocol, IPAddr, Port}) ->
    {ok, IP} = inet_parse:address(IPAddr),
    TransportOpts =  [{transport_module, tmod(Protocol)},
                      {transport_config, [{reuseaddr, true},
                      {ip, IP}, {port, Port}]}],
    diameter:add_transport(Name, {listen, TransportOpts}).

listen(Address) ->
    listen(?SVC_NAME, Address).

%% Convert connection type
tmod(tcp)  -> diameter_tcp;
tmod(sctp) -> diameter_sctp.


%%%.
%%% vim: set filetype=erlang tabstop=2 foldmarker=%%%',%%%. foldmethod=marker:

