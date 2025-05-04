
% Write source code here
% Define concrete subclasses of lane
concrete(stage).
concrete(swimlane).

% stage and swimlane are concrete subclasses of lane
subclass(stage, lane).
subclass(swimlane, lane).

% Instances and hierarchy
:- dynamic instance/2.
:- dynamic child/2.

% Create new instance if the class is concrete
new_instance(ID, Class) :-
    concrete(Class),
    \+ instance(ID, _),
    assertz(instance(ID, Class)).

new_instance(_, Class) :-
    \+ concrete(Class),
    format('Cannot instantiate abstract class ~w~n', [Class]),
    fail.

add_child(Child, Parent) :-
    instance(Parent, _),
    instance(Child, CClass),
    Parent \= Child,
    \+ descendant(Parent, Child), % no cycles
    \+ child(Child, _),           % only one parent
    (
        children(Parent, []) ->
            true
        ;
        children(Parent, Children),
        forall(member(C, Children), instance(C, CClass))  
    ),
    assertz(child(Child, Parent)).

% same_concrete(X,Y): X and Y share the same concrete subclass
same_concrete(X, Y) :-
    concrete(C),
    subclass(X, lane),
    subclass(Y, lane),
    X = C, Y = C.

% Get direct children
children(Parent, Children) :-
    findall(C, child(C, Parent), Children).

% Get all descendants recursively
descendants(Parent, Descendants) :-
    descendants_helper(Parent, [], Descendants).

descendants_helper(Parent, Visited, Descendants) :-
    findall(C, (child(C, Parent), \+ member(C, Visited)), Direct),
    foldl(descendants_helper, Direct, [Parent|Visited], DescList),
    append(Direct, DescList, All0),
    list_to_set(All0, All),
    subtract(All, [Parent], Descendants). 

% Check if one instance is a descendant of another
descendant(Desc, Ancestor) :-
    child(Desc, Ancestor).
descendant(Desc, Ancestor) :-
    child(Desc, Mid),
    descendant(Mid, Ancestor).
