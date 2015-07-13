%% Author: ezonghu
%% Created: 2012-7-26
%% Description: Functions for handling statistic counters
-module(common_stats).

%%-----------------------------------------------------------------
%% Application internal exports
%%-----------------------------------------------------------------

-export([init/1, init/2, terminate/1]).

-export([inc/2, inc/3, inc/4]).
-export([dec/2, dec/3, dec/4]).
-export([get_stats/1, get_stats/2, get_stats/3,
     reset_stats/1, reset_stats/2]).


terminate(Name) ->
    ets:delete(Name).
%%-----------------------------------------------------------------
%% Func: init/1, init/2
%% Description: Initiate the statistics. Creates the stats table
%%              and the global counters.
%%-----------------------------------------------------------------
init(Name) ->
    init(Name, []).

init(Name, GlobalCounters) ->
    ets:new(Name, [public, named_table, {keypos, 1}]),
    ets:insert(Name, {global_counters, GlobalCounters}),
    create_global_counters(Name, GlobalCounters).


create_global_counters(_Name, []) ->
    ok;
create_global_counters(Name, [Counter|Counters]) ->
    ets:insert(Name, {Counter, 0}),
    create_global_counters(Name, Counters).


%%-----------------------------------------------------------------
%% Func: inc/2, inc/3, inc/4
%% Description: Increment counter value. Default increment is one
%%              (1).
%%              if the counter doesn't exist, it will be created
%%              but it will be added into "global_counters"
%%-----------------------------------------------------------------
inc(Tab, GlobalCnt) when is_atom(GlobalCnt) ->
    inc(Tab, GlobalCnt, 1).

inc(Tab, GlobalCnt, Incr)
  when is_atom(GlobalCnt) andalso (is_integer(Incr) andalso (Incr > 0)) ->
    do_inc(Tab, GlobalCnt, Incr);
inc(Tab, Handle, Cnt)
  when is_atom(Cnt) ->
    inc(Tab, Handle, Cnt, 1).

inc(Tab, Handle, Cnt, Incr)
  when is_atom(Cnt) andalso (is_integer(Incr) andalso (Incr > 0)) ->
    Key = {Handle, Cnt},
    do_inc(Tab, Key, Incr).

dec(Tab, GlobalCnt) when is_atom(GlobalCnt) ->
    dec(Tab, GlobalCnt, -1).

dec(Tab, GlobalCnt, Decr)
    when is_atom(GlobalCnt) andalso (is_integer(Decr) andalso (Decr < 0)) ->
        do_inc(Tab, GlobalCnt, Decr);
dec(Tab, Handle, Cnt) when is_atom(Cnt) ->
    dec(Tab, Handle, Cnt, -1).
dec(Tab, Handle, Cnt, Decr)
  when is_atom(Cnt) andalso (is_integer(Decr) andalso (Decr < 0)) ->
    Key = {Handle, Cnt},
    do_inc(Tab, Key, Decr).

do_inc(Tab, Key, Incr) ->
    try ets:update_counter(Tab, Key, Incr)
    catch
        error:badarg ->
            [{global_counters, Counters}] = ets:lookup(Tab, global_counters),
            ets:insert(Tab, {global_counters, [Key|Counters]}),
            ets:insert(Tab, {Key, Incr}),
            Incr
    end.



%%-----------------------------------------------------------------
%% Func: get_stats/1, get_stats/2, get_stats/3
%% Description: Get statistics
%%-----------------------------------------------------------------
get_stats(Ets) ->
    Handles = get_handles_and_global_counters(Ets),
    try do_get_stats(Ets, Handles, [])
    catch
        X:Y -> {error, {X, Y}}
    end.

do_get_stats(_Ets, [], Acc) ->
    {ok, lists:reverse(Acc)};
do_get_stats(Ets, [Handle|Handles], Acc) ->
    case get_stats(Ets, Handle) of
    {ok, Stats} ->
        do_get_stats(Ets, Handles, [{Handle, Stats}|Acc]);
    {error, Reason} ->
        throw({error, Reason})
    end.

get_stats(Ets, GlobalCounter) when is_atom(GlobalCounter) ->
    try ets:lookup(Ets, GlobalCounter) of
        [{GlobalCounter, Val}] ->
            {ok, Val};
        [] ->
            {error, {no_such_counter, GlobalCounter}}
    catch
        X:Y ->
            {error, {X, Y}}
    end;

get_stats(Ets, Handle) ->
    try ets:match(Ets, {{Handle, '$1'}, '$2'}) of
        CounterVals when is_list(CounterVals) ->
            {ok, [{Counter, Val}||[Counter, Val]<-CounterVals]}
    catch
        X:Y ->
            {error, {X, Y}}
    end.


get_stats(Ets, Handle, Counter) when is_atom(Counter) ->
    Key = {Handle, Counter},
    try ets:lookup(Ets, Key) of
        [{Key, Val}] -> {ok, Val};
        _Other -> {error, {undefined_counter, Counter}}
    catch
        X:Y -> {error, {X, Y}}
    end.



%%-----------------------------------------------------------------
%% Funcs: reset_stats/1, reset_stats/2
%% Description: Reset statistics
%%-----------------------------------------------------------------
reset_stats(Ets) ->
    Handles = get_handles_and_global_counters(Ets),
    try do_reset_stats(Ets, Handles, [])
    catch
        X:Y -> {error, {X, Y}}
    end.

do_reset_stats(_Ets, [], Acc) ->
    {ok, lists:reverse(Acc)};
do_reset_stats(Ets, [Handle|Handles], Acc) ->
    case reset_stats(Ets, Handle) of
    {ok, OldStats} ->
        do_reset_stats(Ets, Handles, [{Handle, OldStats}|Acc]);
    {error, Reason} ->
        throw({error, Reason})
    end.

reset_stats(Ets, GlobalCounter) when is_atom(GlobalCounter) ->
    %% First get the current value of the counter
    try ets:lookup(Ets, GlobalCounter) of
        [{GlobalCounter, Val}] ->
            ets:insert(Ets, {GlobalCounter, 0}),
            {ok, Val};
        [] ->
            {error, {no_such_counter, GlobalCounter}}
    catch
        X:Y ->
            {error, {X, Y}}
    end;

reset_stats(Ets, Handle) ->
    try ets:match(Ets, {{Handle, '$1'}, '$2'}) of
        CounterVals when is_list(CounterVals) ->
            CVs = [{Counter, Val}||[Counter, Val] <- CounterVals],
            reset_stats(Ets, Handle, CVs),
            {ok, CVs}
    catch
        X:Y ->
            {error, {X, Y}}
    end.

reset_stats(_Ets, _Handle, []) ->
    ok;
reset_stats(Ets, Handle, [{Counter, _}|CVs]) ->
    ets:insert(Ets, {{Handle, Counter}, 0}),
    reset_stats(Ets, Handle, CVs).



%%-----------------------------------------------------------------
%% Internal functions
%%-----------------------------------------------------------------
get_handles_and_global_counters(Ets) ->
    GlobalCounters =
    case ets:lookup(Ets, global_counters) of
        [{global_counters, GC}] ->
        GC;
        [] ->
        []
    end,
    L1 = ets:match(Ets, {{'$1', '_'}, '_'}),
    GlobalCounters ++
    lists:sort([Handle || [Handle] <- remove_duplicates(L1, [])]).

remove_duplicates([], L) ->
    L;
remove_duplicates([H|T], L) ->
    case lists:member(H,T) of
        true ->
            remove_duplicates(T, L);
        false ->
            remove_duplicates(T, [H|L])
    end.

