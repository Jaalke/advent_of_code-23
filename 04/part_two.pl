#!/usr/bin/swipl

% Predicate for getting the cards number

card_number(Card, Number) :-
    split_string(Card, ':', ' ', SplitOne),
    nth0(0, SplitOne, StringOne),
    split_string(StringOne, ' ', ' ', SplitTwo),
    nth0(1, SplitTwo, NumberString),
    atom_number(NumberString, Number).

% This predicate is needed to generate a list of cards won based on the card number/points

% Base cases (highest number card or no more points to use)
cards_from_points(220, _, []).

cards_from_points(_, 0, []).

% Recurcive case
cards_from_points(CardNumber, Points, [NextCardNumber|Rest]) :-
    CardNumber < 220,
    NextCardNumber is CardNumber + 1,
    NextPoints is Points - 1,
    cards_from_points(NextCardNumber, NextPoints, Rest).

% Predicate for finding cards won from a card

numbers_won_from_card(Card, WonNumbers) :-
    card_value(Card, Value),
    card_number(Card, Number),
    cards_from_points(Number, Value, WonNumbers).

get_card_by_number(Card, Cards, Number) :- 
    member(Card, Cards),
    card_number(Card, Number).

numbers_from_cards([], []).

numbers_from_cards([CurrentCard|RestCards], [CurrentNumber|RestNumbers]) :-
    numbers_from_cards(RestCards, RestNumbers),
    card_number(CurrentCard, CurrentNumber).

numbers_won_from_number(Cards, Number, WonNumbers) :-
    get_card_by_number(Card, Cards, Number),
    numbers_won_from_card(Card, WonNumbers).

numbers_won_from_numbers(_, [], []).

numbers_won_from_numbers(Cards, [CurrentNumber|Rest], [CurrentWon|RestWon]) :-
    numbers_won_from_numbers(Cards, Rest, RestWon),
    numbers_won_from_number(Cards, CurrentNumber, CurrentWon).

% Recursively getting all the scratchcards won

scratchcards_won_from_numbers(0, [], _).

scratchcards_won_from_numbers(NScratchcards, Numbers, Cards) :-
    numbers_won_from_numbers(Cards, Numbers, WonNumbers),
    scratchcards_won_from_numbers(NRest, WonNumbers, Cards),
    length(WonNumbers, NCurrent),
    NScratchcards is NCurrent + NRest.

all_won_scratchcards(NTotal, Cards) :-
    numbers_from_cards(Cards, Numbers),
    scratchcards_won_from_numbers(N, Numbers, Cards),
    NTotal is N + 220.


%%%%%%%%%%%%
%%% MAIN %%%
%%%%%%%%%%%%

:- consult(part_one).
:- initialization(main, main).
:- use_module(library(lists)).

main(_) :-
    get_lines_from_file(Lines, "input.txt"),
    all_won_scratchcards(Value, Lines),
    format('~s ~n', [Value]).