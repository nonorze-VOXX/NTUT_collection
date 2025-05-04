:- use_module(library(plunit)).
:- use_module(hw5).

:- begin_tests(lane_hierarchy).

test(new_instance_stage, true) :-
    new_instance(i, stage).

test(new_instance_lane, fail) :-
    new_instance(_, lane).

test(add_children_and_query) :-
    new_instance(s1, stage),
    new_instance(s2, stage),
    new_instance(l3, swimlane),
    new_instance(l4, swimlane),
    new_instance(l5, swimlane),

    add_child(l3, s1),
    children(s1, L),
    assertion(L == [l3]),

    descendants(s1, L1),
    assertion(L1 == [l3]).

    % add_child(s2, s1), % mismatched class
    % children(s1, L),

    % add_child(l4, s1),
    % add_child(s2, l3),

    % children(s1, L2),
    % assertion(L2 == [l3, l4]),

    % descendants(s1, D2),
    % list_to_set(D2, DSet),
    % list_to_set([l3, l4, s2], Expected),
    % assertion(DSet == Expected).

:- end_tests(lane_hierarchy).


