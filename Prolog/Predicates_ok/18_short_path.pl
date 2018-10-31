/* short_path (Х, У, L): L - кратчайший путь между Х и У (длина пути = количество ребер, входящих в него) */ 
edge(a,b,4).
edge(b,d,4).
edge(a,c,1).
edge(c,e,3).
edge(c,d,9).
edge(e,d,3).
edge(e,g,3).
edge(g,a,9).
edge(d,k,3).

ee(A,B):-edge(A,B,_);edge(B,A,_). 
  
find_way(X,T,[Y,X|T]):-ee(X,Y),not(member(Y,T)).

len([],L,Length):-reverse(L,Length).
len([H|T],L,Length):-length(H,LL),len(T,[[LL|H]|L],Length).

find_needful(_,[],Way,Way).
find_needful(Z,[[N,Z|PassedVer]|LeftVer],L,[[N,Z|PassedVer]| Way]):-!,find_needful(Z,LeftVer,L,Way).
find_needful(Z,[[_,X|_]|LeftVer],L,Way):-dif(Z,X),find_needful(Z,LeftVer,L,Way).

check(Z,ActualWay,Way):-len(ActualWay,[],Length),find_needful(Z,Length,[],Way),!.

path(Z,[[Z|PassedVer]|L],Way):-!,check(Z,[[Z|PassedVer]|L],Way).
path(Z,[[X|PassedVer]|NotPassedVer_in_Queue],Way):-findall(Y,find_way(X,PassedVer,Y),NotPassedVer_not_in_Queue),
										  append(NotPassedVer_in_Queue,NotPassedVer_not_in_Queue,NotPassedVer),
  										  path(Z,NotPassedVer,Way). 

pp(X,Z,Way):-path(Z,[[X]],Way).

alt(N,[[N|M]|_],M).
alt(N,[_|L],M):-alt(N,L,M).

alternWrite([[_|M]|_],M).
alternWrite([[N|_]|L],M):-alt(N,L,M).

short_path(X,Z,RW):-pp(X,Z,Way),alternWrite(Way,W),reverse(W,RW).