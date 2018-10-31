/* union (М1, М2, М3): М3 - объединение  М1 и М2 */

delete_all(_,[],[]). 
delete_all(X,[X|L],L1):-delete_all(X,L,L1). 
delete_all(X,[Y|L],[Y|L1]):-Y=\=X,delete_all(X,L,L1).

make_list([],[]).
make_list([H|T],[H|T1]):-delete_all(H,T,T2),make_list(T2,T1).

conc([],L,L). 
conc([H|T],L,[H|T1]):-conc(T,L,T1).

ins(X,L,[X|L]).
ins(X,[Y|L],[Y|L1]):-ins(X,L,L1).

per([],[]).
per([X|T],T2):-per(T,T1),ins(X,T1,T2).

union(M1,[],M1):-!.
union([],M2,M2):-!.
union(M1,M2,X):-conc(M1,M2,M),make_list(M,X1),per(X1,X),!.

/* union([1,2,4],[1,2],X). */
/* union([],[5,6],X). */
/* union([1,3,4],[],X). */
/* union([],[],X). */
