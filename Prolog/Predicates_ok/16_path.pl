/* path (Х, У, L): L - путь без петель между вершинами Х и У = список вершин между этими вершинами */

edge(a,b,4).
edge(b,c,1).
edge(c,a,6).
edge(b,e,4).
edge(e,e,2).
edge(e,d,1).

ee(A,B):-edge(A,B,_);edge(B,A,_).

p(Start,[Start|L1],[Start|L1]).
p(Start,[Y|L1],L):-ee(X,Y),dif(X,Y),not(member(X,L1)),p(Start,[X,Y|L1],L).

path(Start,Final,L):- p(Start,[Final],L).