:- use_module(library(plunit)).
:- use_module(word_freq).

:- begin_tests(word_freq_test).

% Write test code here
test(read_stop_words) :-
    read_stop_words('stop_words.txt', StopWords),
    assertion(StopWords \= []),
    assertion(member('the', StopWords)),
    assertion(member('wants', StopWords)).

test(filter_chars_and_normalize) :-
    filter_chars_and_normalize("This is a test, only a test.", FilteredText),
    Normalized ="this is a test only a test ".

test(scan) :- 
    scan("this is a test only a test ", WordList),
    assertion(WordList \= []),
    assertion(WordList == ["this", "is", "a", "test", "only", "a", "test"]).

:- end_tests(word_freq_test).