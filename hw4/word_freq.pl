
% Write source code here
read_stop_words(File, StopWords) :-
    open(File, read, Stream),
    read_lines(Stream, StopWords),
    close(Stream).
read_lines(Stream, []) :-
    at_end_of_stream(Stream).
    
read_lines(Stream, [Word|Words]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, Line),
    split_string(Line, " ", "", Words1),
    maplist(string_lower, Words1, Words2),
    exclude(=(Word), Words2, Words3),
    read_lines(Stream, Words3).
inner_filter_chars_and_normalize([], []). % Base case: empty list
filter_chars_and_normalize(String, Result):-
    string_chars(String, Chars),
    inner_filter_chars_and_normalize(Chars, FilteredChars),
    string_chars(Result, FilteredChars).
inner_filter_chars_and_normalize([Char|Rest], [LowerChar|FilteredRest]) :-
    char_type(Char, alnum), % Check if the character is alphanumeric
    char_type(LowerChar, to_lower(Char)), % Convert to lowercase
    inner_filter_chars_and_normalize(Rest, FilteredRest). % Recurse for the rest
inner_filter_chars_and_normalize([_|Rest], [' '|FilteredRest]) :-
    inner_filter_chars_and_normalize(Rest, FilteredRest). % Replace non-alphanumeric with a space

scan(FilteredString, WordList) :-
    split_string(FilteredString, " ", "", WL),
    exclude(=(""), WL, WordList).


remove_stop_words([], _, []).
remove_stop_words([Word|Words], StopWords, FilteredWords) :-
    (member(Word, StopWords) ->
        remove_stop_words(Words, StopWords, FilteredWords)
    ;
        FilteredWords = [Word|FilteredRest],
        remove_stop_words(Words, StopWords, FilteredRest)
    ).


count(_, [], 1, []).
count(_, [], Count, RemainingWords).
count(Word, [Word|Words], Count, RemainingWords) :-
    count(Word, Words, Count1, RemainingWords),
    Count is Count1 + 1.
count(Word, [Word1|Words], Count, [Word1|Rest]) :-
    count(Word, Words, Count1, Rest),
    Count is Count1 .

frequencies([], []).
frequencies([Word|Words], [Word-Count|Rest]) :-
    count(Word, Words, Count, RemainingWords),
    frequencies(RemainingWords, Rest).


sorted([], []).
sorted(List, Sorted) :- 
    merge_sort(List, Sorted).

merge_sort([], []).
merge_sort([X], [X]).
merge_sort([W-C], [W-C]).
merge_sort(List, Sorted) :-
    divide(List, Left, Right),
    merge_sort(Left, SortedLeft),
    merge_sort(Right, SortedRight),
    merge(SortedLeft, SortedRight, Sorted).

merge([], List, List).
merge(List, [], List).
merge([WordX-CountX|T1],[WordY-CountY|T2], [WordX-CountX|T]) :- 
    CountX>CountY,
    merge(T1,[WordY-CountY|T2],T).
merge([WordX-CountX|T1],[WordY-CountY|T2], [WordY-CountY|T]) :- 
    CountX=<CountY,
    merge([WordX-CountX|T1],T2,T).


divide([],[],[]).
divide([],L1,L2).
divide([H|L],L1,[H|L2]):-
    length([H|L], N),
    N mod 2 =:= 0,
    divide(L,L1,L2).

divide([H|L],[H|L1],L2):-
    length([H|L], N),
    N mod 2 =:= 1,
    divide(L,L1,L2).

