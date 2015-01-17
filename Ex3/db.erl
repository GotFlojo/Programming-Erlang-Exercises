-module(db).
-export([new/0, destroy/1, write/3, delete/2,
        read/2, match/2]).

%% new() -> Db
%% destroy(Db) -> ok
%% write(Key, Element, Db) -> NewDb
%% delete(Key, Db) -> NewDb
%% read(Key, Db) -> {ok, Element} | {error, instance}
%% match(Element, Db) -> [Key1, Key2, ... KeyN]


new() -> [].
destroy(_Db) -> ok.

%% Delete the entry if it exists already and add new
write(Key, Element, Db) -> [{Key, Element}|delete(Key, Db)].

delete(_, []) -> [];
delete(Key, [{Key, _}|T]) -> T;
delete(Key, [H|T]) -> [H|delete(Key, T)].

read(_, []) -> {error, instance};
read(Key, [{Key, Element}|_]) -> {ok, Element};
read(Key, [_|T]) -> read(Key, T).

match(_, []) -> [];
match(Element, [{Key, Element}| T]) -> [Key|match(Element, T)];
match(Element, [_|T]) -> match(Element, T).

