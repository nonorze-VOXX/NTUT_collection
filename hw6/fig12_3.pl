% fig12_3.pl
:- dynamic count/1.
:- dynamic goal/1.

% Initial state
start([2,8,3,1,6,4,7,0,5]).

% Goal state
goal([1,2,3,8,0,4,7,6,5]).

% Reset counter
reset_node_count :- retractall(count(_)), assert(count(0)).

% Increment counter
increment_node_count :-
    retract(count(N)),
    N1 is N + 1,
    assert(count(N1)).

% Read counter
node_count(N) :- count(N).

% Swap elements I and J in a list
swap(List, I, J, Swapped) :-
    same_length(List, Swapped),
    nth0(I, List, ElemI),
    nth0(J, List, ElemJ),
    nth0(I, Swapped, ElemJ),
    nth0(J, Swapped, ElemI),
    forall((nth0(K, List, X), K \= I, K \= J), nth0(K, Swapped, X)).

% Legal moves for 8-puzzle (0 is the blank)
move(State, NewState) :-
    nth0(Idx0, State, 0),
    move_index(Idx0, Idx1),
    swap(State, Idx0, Idx1, NewState),
    increment_node_count.

% All valid 8-puzzle moves
move_index(0,1). move_index(0,3).
move_index(1,0). move_index(1,2). move_index(1,4).
move_index(2,1). move_index(2,5).
move_index(3,0). move_index(3,4). move_index(3,6).
move_index(4,1). move_index(4,3). move_index(4,5). move_index(4,7).
move_index(5,2). move_index(5,4). move_index(5,8).
move_index(6,3). move_index(6,7).
move_index(7,4). move_index(7,6). move_index(7,8).
move_index(8,5). move_index(8,7).

% Heuristic: misplaced tiles
h(State, H) :-
    goal(Goal),
    h_misplaced(State, Goal, H).

h_misplaced([], [], 0).
h_misplaced([0|T1], [_|T2], H) :-
    h_misplaced(T1, T2, H).
h_misplaced([X|T1], [X|T2], H) :-
    X \= 0,
    h_misplaced(T1, T2, H).
h_misplaced([X1|T1], [X2|T2], H) :-
    X1 \= X2, X1 \= 0,
    h_misplaced(T1, T2, H1),
    H is H1 + 1.

% Best-first search
bestfirst(Start, Solution) :-
    reset_node_count,
    h(Start, H),
    expand([[Start]/H], Solution).

expand([Path/ _|_], Path) :-
    Path = [Node|_],
    goal(Node).
expand([Path/H|Paths], Solution) :-
    Path = [Node|_],
    findall([NewNode,Node|Path]/H1,
        (move(Node, NewNode),
         \+ member(NewNode, Path),
         h(NewNode, H1)),
        NewPaths),
    append(Paths, NewPaths, AllPaths),
    sort(2, @=<, AllPaths, Sorted),
    expand(Sorted, Solution).
