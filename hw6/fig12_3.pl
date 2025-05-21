
% fig12_3.pl
% Best-first search with node counting

:- dynamic node_count/1.

% bestfirst(Start, Solution): Solution is a path from Start to a goal
bestfirst(Start, Solution) :-
    reset_node_count,
    expand([], l(Start, 0/0), 9999, _, yes, Solution),
    node_count(N),
    format('Total number of nodes generated: ~w~n', [N]).

% expand(Path, Tree, Bound, Tree1, Solved, Solution)
expand(P, l(N, _), _, _, yes, [N|P]) :-
    goal(N).
expand(P, l(N,F/G), Bound, Tree1, Solved, Sol) :-
    F =< Bound,
    (   bagof(M/C, (s(N,M,C), \+ member(M,P)), Succ)
    ->  increment_node_count_list(Succ),
        succlist(G, Succ, Ts),
        bestf(Ts, F1),
        expand(P, t(N,F1/G,Ts), Bound, Tree1, Solved, Sol)
    ;   Solved = never
    ).
expand(P, t(N,F/G,[T|Ts]), Bound, Tree1, Solved, Sol) :-
    F =< Bound,
    bestf(Ts, BF), min(Bound, BF, Bound1),
    expand([N|P], T, Bound1, T1, Solved1, Sol),
    continue(P, t(N,F/G,[T1|Ts]), Bound, Tree1, Solved1, Solved, Sol).
expand(_, t(_,_,[]), _, _, never, _) :- !.
expand(_, Tree, Bound, Tree, no, _) :-
    f(Tree, F), F > Bound.

continue(_, _, _, _, yes, yes, Sol).
continue(P, t(N,F/G,[T1|Ts]), Bound, Tree1, no, Solved, Sol) :-
    insert(T1, Ts, NTs),
    bestf(NTs, F1),
    expand(P, t(N,F1/G,NTs), Bound, Tree1, Solved, Sol).
continue(P, t(N,F/G,[_|Ts]), Bound, Tree1, never, Solved, Sol) :-
    bestf(Ts, F1),
    expand(P, t(N,F1/G,Ts), Bound, Tree1, Solved, Sol).

succlist(_, [], []).
succlist(G0, [N/C | NCs], Ts) :-
    G is G0 + C,
    h(N, H),
    F is G + H,
    succlist(G0, NCs, Ts1),
    insert(l(N,F/G), Ts1, Ts).

insert(T, Ts, [T | Ts]) :-
    f(T, F), bestf(Ts, F1),
    F =< F1, !.
insert(T, [T1 | Ts], [T1 | Ts1]) :-
    insert(T, Ts, Ts1).

f(l(_,F/_), F).
f(t(_,F/_,_), F).
bestf([T|_], F) :- f(T, F).
bestf([], 9999).

min(X, Y, X) :- X =< Y, !.
min(_, Y, Y).

% Node counting
reset_node_count :-
    (retractall(node_count(_)); true),
    assert(node_count(1)).

increment_node_count_list([]).
increment_node_count_list([_|T]) :-
    increment_node_count,
    increment_node_count_list(T).

increment_node_count :-
    retract(node_count(N)),
    N1 is N + 1,
    assert(node_count(N1)).
