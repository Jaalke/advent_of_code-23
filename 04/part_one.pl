#!/usr/bin/swipl

% Predicates for reading the input

get_lines_from_file(Lines, Filename) :-
    open(Filename, read, Stream),
    read_line_to_string(Stream, Line),
    read_lines_recursively(Stream, Line, Lines).  

read_lines_recursively(_, end_of_file, []).

read_lines_recursively(Stream, Line, [Line|NextLines]) :-
    read_line_to_string(Stream, NextLine),
    read_lines_recursively(Stream, NextLine, NextLines).

% Helper predicate for printing the input out

print_lines([end_of_file]).

print_lines([Current|Rest]) :-
    print_lines(Rest),
    format("~s ~n", [Current]).

% Predicates for checking points of a card

card_numbers(Card, Numbers) :- 
    split_string(Card, ':', ' ', SplitString),
    nth0(1, SplitString, Numbers).

card_winning_numbers(Card, WinningNumbersList) :-
    card_numbers(Card, Numbers),
    split_string(Numbers, '|', ' ', SplitString),
    nth0(0, SplitString, WinningNumbers),
    split_string(WinningNumbers, ' ', ' ', WinningNumbersList).

card_chosen_numbers(Card, WinningNumbersList) :-
    card_numbers(Card, Numbers),
    split_string(Numbers, '|', ' ', SplitString),
    nth0(1, SplitString, WinningNumbers),
    split_string(WinningNumbers, ' ', ' ', WinningNumbersList).

% Printing out the winning numbers per card

print_card_winning_numbers([]). 

print_card_winning_numbers([Current|Rest]) :-
    print_card_winning_numbers(Rest),
    card_winning_numbers(Current, WinningNumbers),
    format("~s ~n", [WinningNumbers]).   

% Predicates for calculating value of a card

card_value(Card, Value) :-
    card_winning_numbers(Card, WinningNumbers),
    card_chosen_numbers(Card, ChosenNumbers),
    points_in_card(ChosenNumbers, WinningNumbers, Value).

points_in_card([], _, 0).

points_in_card([Current|Rest], WinningNumbers, 1) :-
    member(Current, WinningNumbers),
    points_in_card(Rest, WinningNumbers, 0).

points_in_card([Current|Rest], WinningNumbers, Points) :-
    member(Current, WinningNumbers),
    points_in_card(Rest, WinningNumbers, OtherPoints),
    \+ OtherPoints is 0,
    Points is OtherPoints * 2.

points_in_card([Current|Rest], WinningNumbers, OtherPoints) :-
    \+ member(Current, WinningNumbers),
    points_in_card(Rest, WinningNumbers, OtherPoints).

% Predicate for summing value of all cards

total_cards_value([], 0).

total_cards_value([Current|Rest], Value) :- 
    total_cards_value(Rest, OthersValue),
    card_value(Current, CurentValue),
    Value is OthersValue + CurentValue.

%%%%%%%%%%%%
%%% MAIN %%%
%%%%%%%%%%%%

:- initialization(main, main).
:- use_module(library(lists)).

main(_) :-
    get_lines_from_file(Lines, "input.txt"),
    total_cards_value(Lines, Value),
    format('~d ~n', Value).