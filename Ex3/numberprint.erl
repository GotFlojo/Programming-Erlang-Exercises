-module(numberprint).
-export([print/1, print_even/1]).


print(N) when is_integer(N) andalso N > 0 ->
    print(N, 1).

print(N, Count) when Count > N -> ok;
print(N, Count) when Count =< N ->
    io:format("Number ~p~n", [Count]), 
    print(N, Count+1).


print_even(N) when is_integer(N) andalso N > 0 ->
    print_even(N, 1).

print_even(N, Count) when Count > N -> ok;
print_even(N, Count) when Count =< N andalso Count rem 2 =:= 0 ->
    io:format("Number:~p~n", [Count]), 
    print_even(N, Count+1);
print_even(N, Count) when Count =< N ->
    print_even(N, Count+1).

