% hw6_test.pl
:- use_module(library(plunit)).
:- use_module(fig12_3, fig12_6).

:- begin_tests(lane_hierarchy).

test(bestfirst_solution_and_node_count) :-
    start1(Pos),
    bestfirst(Pos, Sol),
    assertion(Sol == [1,2,3,8,0,4,7,6,5]),
    node_count(N),
    assertion(N == 10).

test(heuristic_comparison) :-
    start2(Pos),
    bestfirst(Pos, _),
    node_count(N),
    assertion(N > 49).

:- end_tests(lane_hierarchy).

test :- run_tests(lane_hierarchy).
