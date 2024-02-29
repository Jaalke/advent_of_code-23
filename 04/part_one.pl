#!/usr/bin/swipl

% Predicates for reading the input

get_lines_from_file(Lines, Filename) :-
    open(Filename, read, Stream),
    read_line_to_codes(Stream, Line),
    read_lines_recursively(Stream, Line, Lines).  

read_lines_recursively(_, end_of_file, []).

read_lines_recursively(Stream, Line, [Line|NextLines]) :-
    read_line_to_codes(Stream, NextLine),
    read_lines_recursively(Stream, NextLine, NextLines).

% Helper predicate for printing the input out

print_lines([end_of_file]).

print_lines([Current|Rest]) :-
    format("~s ~n", [Current]),
    print_lines(Rest).

%%%%%%%%%%%%
%%% MAIN %%%
%%%%%%%%%%%%

:- initialization(main, main).

main(_) :-
    get_lines_from_file(Lines, "test_input.txt"),
    print_lines(Lines).