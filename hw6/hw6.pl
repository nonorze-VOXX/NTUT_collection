:- dynamic node_count/1.
:- dynamic generated_node/1.

init_node_count :- retractall(node_count(_)), assert(node_count(0)).
init_generated_nodes :- retractall(generated_node(_)).

increment_node_count(Node) :-
    retract(node_count(N)),
    N1 is N + 1,
    assert(node_count(N1)),
    assert(generated_node(Node)).

succlist(_, [], []).
succlist(G0, [N/C | NCs], Ts) :-
    G is G0 + C,
    h(N, H),
    F is G + H,
    increment_node_count(N),
    succlist(G0, NCs, Ts1),
    insert(l(N, F/G), Ts1, Ts).

run_bestfirst(Start, Solution) :-
    init_node_count,
    init_generated_nodes,
    assert(node_count(1)),
    assert(generated_node(Start)),
    bestfirst(Start, Solution),
    node_count(Total),
    format('Total number of nodes generated: ~w~n', [Total]),
    findall(N, generated_node(N), Nodes),
    format('Total nodes generated: ~w~n', [Nodes]).
