%-*- mode: erlang -*-
%%%'   HEADER
%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc gen_server callback module implementation:
%%
%% @end
-module(dccaserver_sup).

-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

-define(SERVER, ?MODULE).
%%%.
%%%'   PUBLIC API
start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%.
%%%'   CALLBACKS
init([]) ->
        DiaServer = {dccaserver,{diameter_srv,start_link,[]},
                     permanent,
                     5000,
                     worker,
                     [server_cb]},
        {ok, { {one_for_one, 5, 10}, [DiaServer]} }.

%%%.
% vim: set filetype=erlang tabstop=2 foldmarker=%%%',%%%. foldmethod=marker:
