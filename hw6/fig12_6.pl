% fig12_6.pl
% 8-puzzle domain and heuristic

goal([1,2,3,8,0,4,7,6,5]).

start1([2,8,3,1,6,4,7,0,5]).
start2([2,3,0,1,8,4,7,6,5]).

s(P1, P2, 1) :- move(P1, P2).
    
move(P1, P2) :-
    nth0(I, P1, 0),
    neighbor(I, J),
    nth0(J, P1, X),
    X \= 0,
    swap(P1, I, J, P2).

neighbor(0,1). neighbor(0,3).
neighbor(1,0). neighbor(1,2). neighbor(1,4).
neighbor(2,1). neighbor(2,5).
neighbor(3,0). neighbor(3,4). neighbor(3,6).
neighbor(4,1). neighbor(4,3). neighbor(4,5). neighbor(4,7).
neighbor(5,2). neighbor(5,4). neighbor(5,8).
neighbor(6,3). neighbor(6,7).
neighbor(7,4). neighbor(7,6). neighbor(7,8).
neighbor(8,5). neighbor(8,7).

swap(List, I, J, Result) :-
    nth0(I, List, Xi),
    nth0(J, List, Xj),
    set_nth0(List, I, Xj, T1),
    set_nth0(T1, J, Xi, Result).

set_nth0(List, Index, Elem, Result) :-
    same_length(List, Result),
    append(Prefix, [_|Suffix], List),
    length(Prefix, Index),
    append(Prefix, [Elem|Suffix], Result).


% Heuristic: H = D + 3*S
h(P, H) :-
    misplaced(P, D),
    seq(P, S),
    H is D + 3*S.

misplaced(P, D) :-
    goal(G),
    misplaced(P, G, D).

misplaced([], [], 0).
misplaced([0|T1], [_|T2], D) :-
    misplaced(T1, T2, D).
misplaced([X|T1], [X|T2], D) :-
    X \= 0,
    misplaced(T1, T2, D).
misplaced([X|T1], [Y|T2], D) :-
    X \= 0, X \= Y,
    misplaced(T1, T2, D1),
    D is D1 + 1.

seq(P, S) :-
    goal(G),
    seq_pairs(P, G, S).

seq_pairs([], [], 0).
seq_pairs([_], [_], 0).
seq_pairs([0|T1], [_|T2], S) :-
    seq_pairs(T1, T2, S).
seq_pairs([X,Y|T1], [GX,GY|T2], S) :-
    ( X = 0 ; Y = 0 ; GX = 0 ; GY = 0 ), !,
    seq_pairs([Y|T1], [GY|T2], S).
seq_pairs([X,Y|T1], [GX,GY|T2], S) :-
    (Y =:= X+1, GY =:= GX+1 ->
        seq_pairs([Y|T1], [GY|T2], S)
    ;
        seq_pairs([Y|T1], [GY|T2], S1),
        S is S1 + 1
    ).
