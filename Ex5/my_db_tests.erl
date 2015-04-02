-module(my_db_tests).
-include_lib("eunit/include/eunit.hrl").

start_test() -> ?assertEqual(ok, my_db:start()).

write_test() -> ?assertEqual(ok, my_db:write(foo, bar)).

