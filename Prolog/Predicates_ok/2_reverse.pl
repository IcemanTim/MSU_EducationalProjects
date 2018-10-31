/* reverse (L1, L2): L2 - перевернутый список L1; */

conc([],L,L). 
conc([H|T],L,[H|T1]):-conc(T,L,T1).

reversee([],[]).
reversee([X|T],Z):-reversee(T,S),conc(S,[X],Z).

/* reversee([1,2,3,4],L). = [4,3,2,1] - io */
/* reversee(L,[1,2,3,4]). = [4,3,2,1] - oi */
/* reversee([1,2,3,4],[4,3,2,1]). = true - ii */