#!/usr/bin/swipl

% Predicate for getting the cards number

card_number(Card, Number) :-
    split_string(Card, ':', ' ', SplitOne),
    nth0(0, SplitOne, StringOne),
    split_string(StringOne, ' ', ' ', SplitTwo),
    nth0(1, SplitTwo, Number).

% This predicate is needed to generate a list of cards won based on the card number/points

% Base cases (highest number card or no more points to use)
cards_from_points(220, _, []).

cards_from_points(_, 0, []).

% Recurcive case
cards_from_points(CardNumber, Points, [NextCardNumber|Rest]) :-
    CardNumber < 220,
    NextCardNumber is CardNumber + 1,
    NextPoints is Points - 1,
    card_from_points(NextCardNumber, NextPoints, Rest).

% Predicate for finding cards won from a card

cards_won_from_card(Card, WonCards) :-
    card_value(Card, Value),
    card_number(Card, Number),
    cards_from_points(Number, Value, WonCards).

%%%%%%%%%%%%
%%% MAIN %%%
%%%%%%%%%%%%

:- consult(part_one).
:- initialization(main, main).
:- use_module(library(lists)).

main(_) :-
    get_lines_from_file(Lines, "input.txt"),
    total_cards_value(Lines, Value),
    format('~d ~n', Value).