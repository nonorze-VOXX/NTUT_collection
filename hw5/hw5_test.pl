:- use_module(library(plunit)).
:- use_module(hw5).

:- begin_tests(lane_hierarchy).

% Clear any previous dynamic facts before each test
setup :-
    retractall(instance(_, _)),
    retractall(child(_, _)).

% Test creating instances: only concrete classes allowed
test(new_instance_stage, [setup(setup), true]) :-
    new_instance(i_stage, stage),
    instance(i_stage, stage).

test(new_instance_swimlane, [setup(setup), true]) :-
    new_instance(i_swimlane, swimlane),
    instance(i_swimlane, swimlane).

test(new_instance_lane_fails, [setup(setup), fail]) :-
    new_instance(i_lane, lane).

% Test adding children of the same concrete class
test(add_child_same_class, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    new_instance(l4, swimlane),
    add_child(l3, s1),
    add_child(l4, s1),
    children(s1, Children),
    Children == [l3, l4].

% Test children are returned correctly
test(children_list, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    add_child(l3, s1),
    children(s1, Children),
    Children == [l3].

% Test descendants include indirect children
test(descendants_recursive, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    new_instance(s2, stage),
    add_child(l3, s1),
    add_child(s2, l3),
    descendants(s1, Descendants),
    % Descendants should include l3 and s2
    sort(Descendants, Sorted),
    sort([l3, s2], Sorted).

% Test adding child with different class fails with message
test(add_child_different_class, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(s2, stage),
    new_instance(l3, swimlane),
    add_child(l3, s1),
    % Try to add s2 (stage) as child of s1 which already has swimlane children
    % This should fail and print message
    add_child(s2, s1),
    children(s1, Children),
    Children == [l3].

% Test cannot add ancestor as child
test(add_child_ancestor_fails, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    add_child(l3, s1),
    % Try to add s1 as child of l3 (its own child)
    add_child(s1, l3),
    children(l3, Children),
    Children == [].

% Test cannot add descendant as child
test(add_child_descendant_fails, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    add_child(l3, s1),
    % Try to add l3 as child of s1 again (should be allowed)
    % But try to add s1 as child of l3 (descendant as child) should fail
    add_child(s1, l3),
    children(l3, Children),
    Children == [].

% Test cannot add child that already has a different parent
test(add_child_already_has_parent_fails, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(s2, stage),
    new_instance(l3, swimlane),
    add_child(l3, s1),
    add_child(l3, s2),
    children(s1, C1),
    children(s2, C2),
    C1 == [l3],
    C2 == [].

% Test valid_children true for instance with children of same concrete class
test(valid_children_true, [setup(setup), true]) :-
    new_instance(s1, stage),
    new_instance(l3, swimlane),
    new_instance(l4, swimlane),
    add_child(l3, s1),
    add_child(l4, s1),
    valid_children(s1).

% Test valid_children true for instance with no children
test(valid_children_no_children, [setup(setup), true]) :-
    new_instance(s1, stage),
    valid_children(s1).

:- end_tests(lane_hierarchy).

