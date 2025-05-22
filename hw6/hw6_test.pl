% hw6_test.pl
:- use_module(fig12_3).

:- begin_tests(bestfirst).

test(bestfirst_solution_and_node_count) :-
    start(S),
    bestfirst(S, Solution),
    node_count(Count),
    assertion(Solution \= []),
    assertion(integer(Count)),
    format("Solution: ~w~n", [Solution]),
    format("Nodes generated: ~w~n", [Count]).

:- end_tests(bestfirst).

test :- run_tests(bestfirst).
