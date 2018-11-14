#!/usr/bin/env swipl

polindrom([], R) :- 	
	reverse(R, R), 
	atom_string(R,R1), 
	write(R1).

polindrom([X|T], R) :- 	
	append(R, [X], L), 
	polindrom(T, L).

check_args([]).
check_args([L|T]) :- 	
	atom_chars(L, L1), 
	polindrom(L1,[]), nl, 
	check_args(T).

args :-	
	current_prolog_flag(argv, Argv), 
	check_args(Argv), 
	halt.

:-   initialization args.