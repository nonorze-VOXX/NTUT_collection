% hw6_test.pl
:- use_module(library(plunit)).
:- use_module(fig12_3, fig12_6).

:- begin_tests(lane_hierarchy).

test(bestfirst_solution_and_node_count) :-
    start1(Pos),
    bestfirst(Pos, Sol),
    node_count(N). % i really dont know how to write this hw

test(heuristic_comparison) :-
    start2(Pos),
    bestfirst(Pos, _),
    node_count(N). % i really don't know how to test this

:- end_tests(lane_hierarchy).

test :- run_tests(lane_hierarchy).
