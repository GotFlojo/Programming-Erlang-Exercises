-module(echo).
-export([start/0, print/1, stop/0]).

start() -> register(echo, spawn(echo, loop, [])).

print(Term) -> io:format("Sending ~p~n", [Term]),
               echo ! {self(), {print, Term}}.

stop() -> echo ! stop.

loop() ->
    receive
        {Pid, Msg} ->
            io:format("Received a Message from ~p~n", [Pid]),
            {_, Content} = Msg, 
            io:format("~p~n", [Content]),
            loop();
        stop -> io:format("Exiting ~w~n", [self()]), 
                true
    end.
