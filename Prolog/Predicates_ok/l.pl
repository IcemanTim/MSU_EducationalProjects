shrin([],[]).
shrin([X],[X]).
shrin([X,Y|T],LL):-delete_one([X,Y|T],L1),delete_one(L1,LL).

shrink(L,W):-findall(L1,shrin(L,L1),List),unique(List,[],LL),alternWrite(LL,W).

alternWrite([M|_],M).
alternWrite([_|L],M):-alternWrite(L,M).

unique([],L1,L1).
unique([X|T],L,L1):-not(member(X,L)),unique(T,[X|L],L1).
unique([X|T],L,L1):-member(X,L),unique(T,L,L1).

delete_one([X|T],T).
delete_one([X|T],[X|T1]):-delete_one(T,T1).