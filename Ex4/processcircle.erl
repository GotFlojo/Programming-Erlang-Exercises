-module(processcircle).
-export([start/3]).

start(N, M, Message) ->
    Pid = spawn(processcircle, init, [N-1, self()]),
    Pid ! {self(), Message, M},
    loop(Pid).

init(1, Pid) ->
    loop(Pid);
init(N, Pid) ->
    Child = spawn(processcircle, init, [N-1, Pid]),
    loop(Child).

loop(Pid) ->
    receive
        {_, _, 0} -> 
            %io:format("Final from ~p~n", [From]), 
            loop(Pid);
        {From, Message, Counter} ->
            io:format("From ~p ~p~n", [From, Message]),
            Pid ! {self(), Message, Counter-1},
            loop(Pid);
        quit -> 
            Pid ! quit,
            io:format("Quitting ~p~n", [self()]), 
            true
    end.
