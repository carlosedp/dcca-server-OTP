-module(startapp).

%% Allow for erl -s invocation
-export([start/0]).

start() ->
    application:start(diameter),
    application:start(dccaserver).
