:- use_module(library(plunit)).
:- use_module(word_freq).

:- begin_tests(word_freq_test).

% Write test code here
test(read_stop_words) :-
    read_stop_words('tmp_stop_words.txt', StopWords),
    StopWords = ["a","is","the","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"].


test(filter_chars_and_normalize) :-
    filter_chars_and_normalize("This is a test, only a test.", FilteredText),
    Normalized ="this is a test only a test ".

test(scan) :- 
    scan("this is a test only a test ", WordList),
    assertion(WordList \= []),
    assertion(WordList == ["this", "is", "a", "test", "only", "a", "test"]).


test(remove_stop_words) :-
    remove_stop_words(["this","is","a","test","only","a","test"], ["a","is","the"], FilteredWordList),
    assertion(FilteredWordList \= []),
    assertion(FilteredWordList == ["this", "test", "only", "test"]).

test(frequencies) :-
    frequencies(["this","is","a","test","only","a","test"], WordFreq),
    assertion(WordFreq \= []),
    assertion(WordFreq == ["this"-1, "is"-1, "a"-2, "test"-2, "only"-1]).

test(sorted) :-
    sorted([ "only"-1,"test"-2], SortedWordList),
    assertion(SortedWordList \= []),
    assertion(SortedWordList == ["test"-2,"only"-1 ]).


:- end_tests(word_freq_test).