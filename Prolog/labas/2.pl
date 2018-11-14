#!/usr/local/Cellar/swi-prolog/7.6.4/libexec/bin/swipl -s

check_l([], 0).
check_l([X|T],N) :- X =:= '(', !, N is N + 1, check_l(T, N).
check_l([X|T],N) :- X =:= '{', !, N is N + 1, check_l(T, N).
check_l([X|T],N) :- X =:= '[', !, N is N + 1, check_l(T, N).
check_l([_,T],N) :- check_l(T, N).

check_r([],0).
check_r([X|T],N) :- X =:= ')', !, N is N + 1, check_r(T, N).
check_r([X|T],N) :- X =:= '}', !, N is N + 1, check_r(T, N).
check_r([X|T],N) :- X =:= ']', !, N is N + 1, check_r(T, N).
check_r([_|T],N) :- check_r(T, N).

check_all(L) :- 
	check_l(L, N), check_r(L, M), 
	K is N - M, K =/= 0, !, 
	write("No").
check_all(_) :- 
	write("Yes").

check_balance([]).
check_balance(L) :- 	
	atom_chars(L, L1), 
	check_all(L1), nl.

get_strings(L) :-
	read_line_to_codes(user_input, X), 
	string_codes(S,X),
	dif(S,end_of_file),
	check_balance(S),
	get_strings(L).
get_strings([]).

main :-  
	get_strings(L),
	write(L),nl,
	halt.

:-	initialization main.
