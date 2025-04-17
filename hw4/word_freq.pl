
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