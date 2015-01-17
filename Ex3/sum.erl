-module(sum).
-export([sum/1, sum/2]).


%% special case of sum/2
sum(N) -> sum(0, N).

%% Call tail recursive helper
sum(N, M) -> sum(N, M, 0).

%% Tail recursive summation
sum(N, M, Acc) when N ==M -> M+Acc;
sum(N, M, Acc) when N < M -> sum(N+1, M, N+Acc).

