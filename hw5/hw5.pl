
% Write source code here
% --- Class hierarchy and instantiation ---

% lane is abstract
abstract_class(lane).

% stage and swimlane are concrete subclasses of lane
concrete_class(stage).
concrete_class(swimlane).

% subclass relationships
subclass(stage, lane).
subclass(swimlane, lane).

% new_instance(Instance, Class) creates a new instance of a concrete class
% Only concrete classes can have instances
new_instance(_, Class) :-
    abstract_class(Class),
    !,
    fail.
new_instance(Instance, Class) :-
    concrete_class(Class),
    \+ instance(Instance, _),
    assertz(instance(Instance, Class)).

% instance(Instance, Class) facts store created instances
% initially empty; will be asserted by new_instance/2

% --- Children relationships ---

% child(Child, Parent)
% Stores children of instances
% Initially empty; will be asserted by add_child/2

% add_child(Child, Parent) adds Child as a child of Parent if all constraints hold
add_child(Child, Parent) :-
    % Both Child and Parent must be instances
    instance(Child, ChildClass),
    instance(Parent, ParentClass),

    % Child and Parent are not the same instance
    Child \= Parent,

    % Parent is not a descendant of Child (to avoid cycles)
    \+ descendant(Parent, Child),

    % Child is not already a child of another parent
    \+ child(Child, OtherParent),
    OtherParent \= Parent,

    % Check children of Parent: if no children, any concrete class allowed
    % If children exist, they must be of the same concrete class as Child
    findall(C, child(C, Parent), Children),
    ( Children = [] ->
        true
    ; Children = [FirstChild|_],
      instance(FirstChild, FirstChildClass),
      ChildClass == FirstChildClass
    ),

    % Add the child
    assertz(child(Child, Parent)),
    !.

% If add_child fails due to constraints, print appropriate message and succeed
add_child(Child, Parent) :-
    instance(Child, ChildClass),
    instance(Parent, ParentClass),

    % Check if Child is already a child of another parent
    ( child(Child, OtherParent), OtherParent \= Parent ->
        writeln('Child not added: cannot add a child that is already a child of another parent')
    ; % Check if trying to add ancestor as child
      descendant(Child, Parent) ->
        writeln('Child not added: cannot add an ancestor as a new child')
    ; % Check if trying to add descendant as child
      descendant(Parent, Child) ->
        writeln('Child not added: cannot add a descendant as a new child')
    ; % Check if classes differ
      findall(C, child(C, Parent), Children),
      ( Children = [] ->
          % no children, so no class conflict
          true
      ; Children = [FirstChild|_],
        instance(FirstChild, FirstChildClass),
        instance(Child, ChildClass),
        ChildClass \= FirstChildClass ->
          writeln('Child not added: cannot add a child with different class')
      ; % Otherwise, generic failure
        writeln('Child not added: unknown reason')
      )
    ),
    !.

% --- Queries about children and descendants ---

% children(Instance, ListOfChildren)
children(Instance, Children) :-
    findall(C, child(C, Instance), Children).

% descendant(Descendant, Ancestor) true if Descendant is child or indirect child of Ancestor
descendant(Descendant, Ancestor) :-
    child(Descendant, Ancestor).
descendant(Descendant, Ancestor) :-
    child(Descendant, Parent),
    descendant(Parent, Ancestor).

% descendants(Instance, ListOfDescendants)
descendants(Instance, Descendants) :-
    setof(D, descendant(D, Instance), Descendants), !.
descendants(_, []).

% --- valid_children(Instance) checks if all children of Instance are of the same concrete class ---

valid_children(Instance) :-
    children(Instance, Children),
    ( Children = [] -> true
    ; Children = [FirstChild|_],
      instance(FirstChild, ChildClass),
      concrete_class(ChildClass),
      forall(member(C, Children), instance(C, ChildClass))
    ).

% --- Example initial data for testing ---

% You can assert these facts to test the example scenario:

% Instances:
% s1, s2 are stages
% l3, l4, l5 are swimlanes

% To create these instances, run:
% ?- new_instance(s1, stage).
% ?- new_instance(s2, stage).
% ?- new_instance(l3, swimlane).
% ?- new_instance(l4, swimlane).
% ?- new_instance(l5, swimlane).

% Then you can test add_child and other queries as described.

