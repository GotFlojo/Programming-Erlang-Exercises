-module(db_tests).
-include_lib("eunit/include/eunit.hrl").

new_test() -> ?assertMatch([], db:new()).

destroy_test() -> 
   Db = db:new(), 
   ?assertEqual(ok, db:destroy(Db)).

write_test() -> Db=db:new(), 
                Db1=db:write(francesco, london, Db), 
                ?assertEqual([{francesco,london}], Db1), 
                ?assertEqual([{lelle, stockholm}, {francesco,london}], 
                             db:write(lelle, stockholm, Db1)).
%delete_test()

%read_test()

%match_test()
