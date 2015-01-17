-module(create).
-export([create/1, reverse_create/1]).

create(N) when is_integer(N) -> create_tail(N, []).

%% Tail recursive List creation
create_tail(0, List) -> List;
create_tail(N, List) -> create_tail(N-1, [N|List]).

%% First try on reverse create with reversing helper function
reverse_create(0) -> [];
reverse_create(N) -> reverse(create(N)).

reverse(L) when is_list(L) -> reverse(L, []).
reverse([], List) -> List;
reverse([H|T], List) -> reverse(T, [H|List]).

%% Second try simple recursive function, not tail recursive
reverse_create2(0) -> [];
reverse_create2(N) when is_integer(N) ->
    [N|reverse_create2(N-1)].

%% Tail recursive variant of reverse_create
%% Using a counter to keep track of when to stop
reverse_create3(N) when is_integer(N) -> 
    reverse_create_tail(N, 0, []).
reverse_create_tail(N, Count, AccList) when Count < N -> 
    reverse_create_tail(N, Count+1,  [Count+1|AccList]);
reverse_create_tail(_, _, AccList) -> AccList.

