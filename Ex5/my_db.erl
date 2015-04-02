-module(my_db).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1]).

start() -> 
    register(my_db, spawn(?MODULE, loop , [db:new()])),
    ok.

stop() ->
    my_db ! {self(), stop},
    ok.

write(Key, Value) ->
    my_db ! {request, self(), write, {Key, Value}}.
    ok.

delete(Key) ->
    my_db ! {request, self(), delete, Key}.
    ok.

read(Key) ->
    my_db ! {request, self(), read, Key},
    receive {reply, Reply} -> Reply
    after 1000 -> {error, timeout}
    end. 

match(Value) ->
    my_db ! {request, self(), match, Value},
    receive {reply, Reply} -> Reply
    after 1000 -> {error, timeout}
    end.

loop(Db) ->
    receive
        {request, _PID, write, {Key, Element}} ->
            loop(db:write(Key, Element, Db));
        {request, _PID, delete, Key} ->
            loop(db:delete(Key, Db));
        {request, PID, read, Key} ->
            PID ! {reply, db:read(Key, Db)},
            loop(Db);
        {request, PID, match, Element} ->
            PID ! {reply, db:match(Element, Db)},
            loop(Db);
        {PID, stop} -> db:destroy(Db),
                  PID ! ok
    end.
