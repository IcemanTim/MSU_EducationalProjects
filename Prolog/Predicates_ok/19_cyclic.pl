/* 19. cyclic : проверка на то, что граф является циклическим (= не является деревом)*/

edge(a,b,4).
edge(b,c,5).
edge(c,i,6).
edge(i,k,7).
edge(k,a,8).

ee(A,B):-edge(A,B,_);edge(B,A,_).

p(Start,[Start|L1],[Start|L1]).
p(Start,[Y|L1],L):-ee(X,Y),dif(X,Y),not(member(X,L1)),p(Start,[X,Y|L1],L).

path(Start,Final,L):- p(Start,[Final],L).

cyclic:-setof(L,path(_,_,L),W),length(W,N),dif(N,1).
