/* min_path (Х, У, L): L - путь между в. Х и У, имеющий минимальную стоимость = сумма стоимостей входящих в него ребер); */

edge(a,b,4).
edge(a,d,4).
edge(a,e,1).
edge(b,e,3).
edge(d,e,3).
edge(c,e,2).
edge(b,c,1).
edge(d,c,1).
edge(b,f,15).
edge(d,f,7).

ee(X,Y,M):-edge(X,Y,M);edge(Y,X,M).
 
find_way([H|T],[New,H|T],Cost):-ee(H,New,Cost),not(member(New,[H|T])).
 
way1([Finish|T],Finish,[Finish|T],WayCost,WayCost).
way1(L,Finish,Way,WayCost,PartCost):-find_way(L,NewWay,Cost),PartCost1 is PartCost+Cost,way1(NewWay,Finish,Way,WayCost,PartCost1).
way(L,Finish,Way,WayCost):-way1(L,Finish,Way,WayCost,0).

search_ways(Start,Finish,Way,WayCost):-way([Start],Finish,Way,WayCost).

minn(X,Y,X):-Y>=X,!.
minn(X,Y,Y):-Y<X.

min_cost([WayCost/_],WayCost):-!. 
min_cost([WayCost1/_ |Tail],MinCost):-min_cost(Tail,MinCost1),minn(WayCost1,MinCost1,MinCost).

min_path(Start,Finish,MinWay):-findall(WayCost1/Way1,search_ways(Start,Finish,Way1,WayCost1),AllWays),
							min_cost(AllWays,MinCost),
							member(MinCost/WW,AllWays),
							reverse(WW,MinWay).
