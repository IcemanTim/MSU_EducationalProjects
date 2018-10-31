/*sort (L1, L2): L2 - отсортированный по неубыванию список чисел из L1.*/ 

input(X,[],[X]). 
input(X,[H|T],[H|T1]):-H=<X,!,input(X,T,T1).
input(X,T,[X|T]).

sortt([],[]). 
sortt([H|T],L):-sortt(T,T1),input(H,T1,L).

/*  sortt([1,5,2,32,4,1],L). */