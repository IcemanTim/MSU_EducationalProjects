#chmod +x t.pl ; ./t.pl - в терминале

#!/usr/bin/env swipl

/* чтение со стандарного потока и вывод : -> affafad.  -> affafad */

:- prompt(_,''). 
:- read(X), write(X), nl, halt.

/* Считывание без . : -> sdf  -> sdf */
/* X это набор кодов, во втором варианте он преобразуется в string */

:- prompt(_, '').
:- read_line_to_codes(user_input, X), format("~s", [X]), nl, halt.

:- prompt(_, '').
:- read_line_to_codes(user_input, X), string_codes(L, X), write(L), nl, halt.

#----------------------------------------------------------------

/* программа вывода будь своих аргументов - подобие echo */

print_args([]) :- nl.
print_args([L | Tail]) :- write(L), write(' '), nl, print_args(Tail).

args :- current_prolog_flag(argv, Argv), print_args(Argv), halt.

:- args.

#----------------------------------------------------------------
/* программа проверки аргумента на полиндром */

merge([], RES) :- reverse(RES, RES), write('YES'); write('NO').
merge([L | Tail], RES) :- atom_chars(L, X), append(RES, X, T), merge(Tail, T).

main :- current_prolog_flag(argv, Argv), merge(Argv, []), nl, halt. 

:- main.

#----------------------------------------------------------------
/* калькулятор : */
/* -> 4+10 (вводится как аргумент : t.pl 4+10) -> 14 */

:- initialization(main, main).

main(Argv) :-
        concat_atom(Argv, ' ', SingleArg),
        term_to_atom(Term, SingleArg),
        Val is Term,
        format('~w~n', [Val]).

#----------------------------------------------------------------

/* reverse (L1, L2): L2 - перевернутый список L1; */

conc([],L,L). 
conc([H|T],L,[H|T1]):-conc(T,L,T1).

reversee([],[]).
reversee([X|T],Z):-reversee(T,S),conc(S,[X],Z).

/* reversee([1,2,3,4],L). = [4,3,2,1] - io */
/* reversee(L,[1,2,3,4]). = [4,3,2,1] - oi */
/* reversee([1,2,3,4],[4,3,2,1]). = true - ii */

#----------------------------------------------------------------

/*sort (L1, L2): L2 - отсортированный по неубыванию список чисел из L1.*/ 

input(X,[],[X]). 
input(X,[H|T],[H|T1]):-H=<X,!,input(X,T,T1).
input(X,T,[X|T]).

sortt([],[]). 
sortt([H|T],L):-sortt(T,T1),input(H,T1,L).

/*  sortt([1,5,2,32,4,1],L). */

#----------------------------------------------------------------

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

#----------------------------------------------------------------

/* sub_tree (Т2, Т1): дерево Т1 является непустым поддеревом дерева Т2 */

sub_tree(tree(L,R,M),tree(L,R,M)).
sub_tree(tree(L,R,_),T):-sub_tree(L,T);sub_tree(R,T).

/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),nil). = false */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(tree(nil,nil,4),tree(nil,nil,1),3)). =true */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(nil,tree(nil,nil,1),3)). = false */
/* sub_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),tree(nil,nil,2)). = false */

#----------------------------------------------------------------

/*flatten_tree (Т, L): L - список меток всех узлов дерева Т («выровненное» дерево)*/
/*append([],L,L).*/
/*append([X|T],L2,[X|L3]):-append(T,L2,L3).*/
/*flatten_tree(nil,[]).*/
/*flatten_tree(tree(L,R,M),L1):-flatten_tree(L,ML),flatten_tree(R,MR),append(ML,[M|MR],L1).*/

flatten(nil,X,X).
flatten(tree(L,R,M),Li,X):-flatten(R,L1,X),flatten(L,Li,[M|L1]).

flatten_tree(T,L):-flatten(T,L,[]).

/* flatten_tree(tree(tree(nil,nil,7),tree(tree(nil,nil,4),tree(nil,nil,1),3),4),X). */
/* flatten_tree(nil,X). */

#----------------------------------------------------------------

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

#----------------------------------------------------------------

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

#----------------------------------------------------------------

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

#----------------------------------------------------------------

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

#----------------------------------------------------------------

/* is_connected : граф явл. связным = для любых двух его верш. существует связывающий их путь */

edge(a,b,4).
edge(b,c,1).
edge(c,a,6).
edge(b,e,4).
edge(e,e,2).
edge(e,d,1).
edge(k,k,9).

ee(A,B):-edge(A,B,_);edge(B,A,_).

p(Start,[Start|L1],[Start|L1]).
p(Start,[Y|L1],L):-ee(X,Y),dif(X,Y),not(member(X,L1)),p(Start,[X,Y|L1],L).

path(Start,Final,L):- p(Start,[Final],L).

not_connected:-ee(A,_),ee(B,_),A\=B,not(path(A,B,_)).

is_connected:-not(not_connected).

#----------------------------------------------------------------

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

#----------------------------------------------------------------

num_five(empty,0).
num_five(tree(L,R,5),N):-num_five(L,N1),num_five(R,N2),N is N1+N2+1,!.
num_five(tree(L,R,_),N):-num_five(L,N1),num_five(R,N2),N is N1+N2.

#----------------------------------------------------------------

similar([],[]).
similar([X|T1],[X|T2]):-write(T1),write(" + "),write(T2),nl,similar(T1,T2).
similar([[_|_]|T1],[[]|T2]):-write(T1),write(" - "),write(T2),nl,similar(T1,T2).

#----------------------------------------------------------------

/* считывание в цикле построчное */

:- prompt(_, '').

get_strings_for_list(List) :- 
							writeln('Enter string:'),
							/*read(String),*/
							/*write("String = "),*/
							/*write(String),*/
							read_line_to_codes(user_input, X),
							string_codes(String,X),
							/*write("String = "),*/
							/*write(String),*/
							dif(String,"stop"),
							get_strings_for_list(List).
get_strings_for_list([]).

:- get_strings_for_list(L), write(L), nl, halt.

#----------------------------------------------------------------

/* Считывание в цикле построчное из файла */

args:-see('db_test.pl'),get_strings_for_list_from_file(L),write(L),nl,halt.
get_strings_for_list_from_file(List):-
/*writeln('Enter string:'),*/
prompt(_, ''),
/*read(String),*/

/*write("String = "),*/
/*write(String),*/
read(String),
/*write("String = "),*/
/*write(String),*/
/*write("String = "),*/
/*write(String),*/
dif(String,end_of_file),
get_strings_for_list_from_file(List).

get_strings_for_list_from_file([]).
