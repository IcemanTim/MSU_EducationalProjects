status(олимпийский).

season(летний).
season(зимний).

place(уличный).
place(внутренний).

gender(мужчина).
gender(женщина).

skill(скорость, [have(длинные_ноги), can(быстрая_реакция), like(спринт)]).
skill(координация, [have(хорошая_растяжка), can(сделать_сальто), like(публика)]).
skill(выносливость, [have(тренированное_сердце), can(усердная_работа), like(марафон)]).
skill(сила, [have(сильные_руки), can(поднимать_веса), like(тренажерный_зал)]).

category(велоспорт, [skill(выносливость), skill(скорость)]).
category(скоростно-силовой_вид, [skill(скорость), skill(сила)]).
category(координационный_вид, [skill(координация), skill(сила)]).
category(единоборство, [skill(координация), skill(сила)]).
category(спорт_игра, [skill(координация), skill(скорость)]).

seastype(летний, [status(олимпийский), season(летний)]).
seastype(зимний, [status(олимпийский), season(зимний)]).

sport_type(водный_вид, [seastype(летний), like(водный), place(внутренний)]).
sport_type(гимнастика, [category(координационный_вид), seastype(летний), place(внутренний)]).
sport_type(атлетика, [seastype(летний), like(физическая_культура)]).
sport_type(лыжи, [seastype(зимний), place(уличный), like(снег)]).
sport_type(командный_вид, [like(командный)]).

%-----------------------------------------------------------------------------

put_general_info :- nl,write('               База знаний "Спорт"         '),nl,nl,
                    write(' Уже содержатся следующие виды спорта:'),nl,
                    write('        фигурное_катание, синхронное_плавание, художественная_гимнастика,'),nl,
                    write('        спортивная_гимнастика, велоспорт, биатлон, лыжные гонки, горные_лыжи'),nl,
                    write('        плавание, прыжки_в_длину, прыжки_с_шестом, бег, тяжелая_атлетика,'),nl,
                    write('        карате, бокс, дзюдо, баскетбол, теннис, футбол, хоккей, гольф.'),nl,nl,
                    write(' Каждый объект обладает следующими свойствами:'),nl,
                    write('        * category - категория вида спорта : единоборство, спорт_игра,'),nl,
                    write('               велоспорт, скоростно-силовой_вид, координационный_вид,'),nl,
                    write('        * seastype - спорт с точки зрения официальности и времени проведения:'), nl,
                    write('               олимпийский и зимний/летний'),nl,
                    write('        * sport_type - тип спорта в целом : водный_вид, гимнастика, лыжи'),nl,
                    write('               атлетика, командный_вид'),nl,
                    write('        * like - с чем ассоциируется данный вид спорта, например:'),nl,
                    write('               марафон, спринт, тренажерный_зал и т.д.'),nl,
                    write('        * have - что приобретает человек от данного вида спорта:'),nl,
                    write('               тренированное сердце, сильные_ноги и т.д.'),nl,
                    write('        * can - на что способен человек, занимаясь этим видом : '),nl,
                    write('               поднятие_тяжестей, броски_людей'),nl,
                    write('        * gender - кто преимущественно задействован в спорте : '),nl,
                    write('                женщина или мужчина'),nl,nl.

%-----------------------------------------------------------------------------
%            --- Добавить объект в базу знаний ---

nth_element(1,[A|_],A) :- !.
nth_element(N,[_|L],A) :- N1 is N-1, nth_element(N1,L,A).

put_back([],E,[E]).
put_back([L1|H1],E,[L1|H2]) :- put_back(H1,E,H2).

add_obj :- write('Вы решили добавить новый объект в базу знаний.'),nl,
           put_general_info,
           write('Для того, чтобы добавить новый объект, отвечайте на вопросы системы.'),nl
           ,
           write('Пример ввода : олимпийский. '),nl,nl,
           write('Введите название Вашего вида спорта:'),nl,read(In)
           ,
           write('Введите category Вашего вида спорта:'),nl,read(In1),put_back([],In1,L1)
           ,
           write('Введите seastype Вашего вида спорта:'),nl,read(In2),put_back(L1,In2,L2)
           , 
           write('Введите sport_type Вашего вида спорта:'),nl,read(In3),put_back(L2,In3,L3)
           , 
           write('Введите like Вашего вида спорта:'),nl,read(In4),put_back(L3,In4,L4)
           ,
           write('Введите have Вашего вида спорта:'),nl,read(In5),put_back(L4,In5,L5)
           , 
           write('Введите can Вашего вида спорта:'),nl,read(In6),put_back(L5,In6,L6)
           ,
           write('Введите gender Вашего вида спорта:'),nl,read(In7),put_back(L6,In7,L)
           ,
           nth_element(1,L,El1),nth_element(2,L,El2), nth_element(3,L,El3), nth_element(4,L,El4),
           nth_element(5,L,El5), nth_element(6,L,El6), nth_element(7,L,El7),
           assert(like(El4)), tell('like.txt'),listing(like),told,
           assert(have(El5)), tell('have.txt'),listing(have),told,
           assert(can(El6)),  tell('can.txt'), listing(can),told,
           assert(fact(In, [category(El1), seastype(El2), sport_type(El3), like(El4), have(El5), can(El6), gender(El7)])),
           tell('q_db.txt'),listing(fact),told.

%-----------------------------------------------------------------------------
%            --- Исправить объект в базе знаний ---

replace([], _, _, []):- !.
replace([O|T], O, N, [N|RT]):- !, replace(T, O, N, RT).
replace([H|T], O, N, [H|RT]):- replace(T, O, N, RT).

fix(Name, L, category, Old, New)   :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, category(Old,_), category(New,_), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, seastype, Old, New)   :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, seastype(Old,_), seastype(New,_), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, sport_type, Old, New) :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, sport_type(Old,_), sport_type(New,_), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, skill, Old, New)      :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, skill(Old,_), skill(New,_), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, place, Old, New)      :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, place(Old), place(New), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, gender, Old, New)     :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, gender(Old), gender(New), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, have, Old, New)       :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, have(Old), have(New), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, like, Old, New)       :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, like(Old), like(New), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.
fix(Name, L, can, Old, New)        :- ['q_db.txt'],retract(fact(Name,_)), tell('q_db.txt'),listing(fact),told,
                                      replace(L, can(Old), can(New), X), assert(fact(Name, X)), tell('q_db.txt'),listing(fact),told.

check_for_name_or_atrr(Name, L) :- write('Теперь введите свойства объекта, которые хотите исправить'),nl,
                                   write('Пример ввода : have. и затем oldValue. newValue.'),nl,nl,
                                   read(Atr),nl,read(Old),nl,read(New),nl,
                                   fix(Name, L, Atr, Old, New),
                                   write('Cвойства объекта "'),write(Name), write('" успешно изменены.').

look_at_b('d', Name) :- ['q_db.txt'],retract(fact(Name,_)),
                        tell('q_db.txt'),listing(fact),told.
look_at_b('c', Name) :- write('Посмотрите на уже имеющиеся свойства объекта:'),nl,
                        findall(L,fact(Name,L),X), nth_element(1,X,LL),print_list(LL,1),nl,
                        write('Помните, Вы можете менять свойства только с 1ым уровнем доступа!'),nl,nl,
                        check_for_name_or_atrr(Name, LL),nl.

fix_obj :- write('Вы решили исправить свойства объекта в базе знаний,'),nl,
           write('возможно, даже удалить.'),nl,
           put_general_info,
           write('Введите сначала имя объекта, который хотите исправить или удалить'),nl,
           write('Пример ввода : бокс. '),nl,nl, read(Elem),nl,
           write('Желаете удалить объект - d. или исправить c. ?'),nl,nl,
           read(M),nl,look_at_b(M,Elem).

%-----------------------------------------------------------------------------
%            --- Показать свойста объекта в базе знаний ---

check(category(X),N)   :- write(N), write(' - category - '),   write(X) , nl, N1 is N+1, category(X,L), print_list(L,N1).
check(seastype(X),N)   :- write(N), write(' - seastype - '),   write(X) , nl, N1 is N+1, seastype(X,L), print_list(L,N1).
check(sport_type(X),N) :- write(N), write(' - sport_type - '), write(X) , nl, N1 is N+1, sport_type(X,L), print_list(L,N1).
check(skill(X),N)      :- write(N), write(' - skill - '),      write(X) , nl, N1 is N+1, skill(X,L), print_list(L,N1).
check(place(X),N)      :- write(N), write(' - place - '),      write(X) , nl.
check(gender(X),N)     :- write(N), write(' - gender - '),     write(X) , nl.
check(season(X),N)     :- write(N), write(' - season - '),     write(X) , nl.
check(status(X),N)     :- write(N), write(' - status - '),     write(X) , nl.
check(have(X),N)       :- write(N), write(' - have - '),       write(X) , nl.
check(like(X),N)       :- write(N), write(' - like - '),       write(X) , nl.
check(can(X),N)        :- write(N), write(' - can - '),        write(X) , nl.

print_list([],_).
print_list([H|T],N):- check(H,N), print_list(T,N).

look_attr_obj :- write('Вы решили посмотреть свойства объекта в базе знаний.'),nl,
                 put_general_info,
                 write('Введите имя объекта, свойства которого хотите посмотреть:'),nl,
                 write('Пример ввода : бокс. '),nl,nl,
                 read(Name),nl,
                 findall(L,fact(Name,L),X), nth_element(1,X,LL),print_list(LL,1).

%-----------------------------------------------------------------------------
%            --- Показать свойста класса в базе знаний ---

atr([]).
atr([skill(_)|T],N)        :- write(N), write(' - skill - '), findall(X,skill(X,_),L), write(L), attr_class(skill,N),atr(T,N).
atr([seastype(_)|T],N)     :- write(N), write(' - seastype - '), findall(X,seastype(X,_),L), write(L), attr_class(seastype,N),atr(T,N).
atr([sport_type(_)|T],N)   :- write(N), write(' - sport_type - '), findall(X,sport_type(X,_),L), write(L), attr_class(sport_type,N),atr(T,N).
atr([place(X)|T],N)        :- write(N), write(' - place - '), write(X), attr_class(place,N),atr(T,N).
atr([gender(X)|T],N)       :- write(N), write(' - gender - '), write(X), attr_class(gender,N),atr(T,N).
atr([season(X)|T],N)       :- write(N), write(' - season - '), write(X), attr_class(season,N),atr(T,N).
atr([status(X)|T],N)       :- write(N), write(' - status - '), write(X), attr_class(status,N),atr(T,N).
atr([have(X)|T],N)         :- write(N), write(' - have - '), write(X), attr_class(have,N),atr(T,N).
atr([like(X)|T],N)         :- write(N), write(' - like - '), write(X), attr_class(like,N),atr(T,N).
atr([can(X)|T],N)          :- write(N), write(' - can - '), write(X), attr_class(can,N),atr(T,N).

attr_class(category,N)   :- findall(X, category(_, X), M),append(M, L),list_to_set(L, S), N1 is N+1, atr(S,N1),nl .
attr_class(seastype,N)   :- nl, findall(X, seastype(_, X), M),append(M, L),list_to_set(L, S), N1 is N+1, atr(S,N1),nl .
attr_class(sport_type,N) :- nl, findall(X, sport_type(_, X), M),append(M, L),list_to_set(L, S), N1 is N+1, atr(S,N1),nl .
attr_class(skill,N)      :- nl, findall(X, skill(_, X), M),append(M, L),list_to_set(L, S), N1 is N+1, atr(S,N1),nl .
attr_class(place,_)      :- nl.
attr_class(gender,_)     :- nl.
attr_class(season,_)     :- nl.
attr_class(status,_)     :- nl.
attr_class(have,_)       :- nl.
attr_class(like,_)       :- nl.
attr_class(can,_)        :- nl.

look_attr_class :- write('Вы решили посмотреть свойства объекта в базе знаний.'),nl,
                   put_general_info,
                   write('Введите имя класса, свойства которого хотите посмотреть:'),nl,
                   write('Пример ввода : category.  '),nl,nl,
                   read(Name),nl,
                   attr_class(Name,1).

%-----------------------------------------------------------------------------
%            --- Просмотр различий между объектами  ---

intersect([], _B, []):-!.
intersect([HeadA|TailA], B, [HeadA|AInterB]):- member(HeadA, B), !, intersect(TailA, B, AInterB).
intersect([_HeadA|TailA], B, AInterB):- intersect(TailA, B, AInterB).

find_it(Head, [Head|_]) :- !.
find_it(Head, [_|Tail]) :- find_it(Head, Tail).

prn([]).
prn([X|L]) :- write(X), nl, prn(L).

prnn([],_,_).
prnn([X|L],L1,L2) :- find_it(X,L1),write(' 1 - '), write(X), nl, prnn(L,L1,L2).
prnn([X|L],L1,L2) :- find_it(X,L2),write(' 2 - '), write(X), nl, prnn(L,L1,L2).
 
del1(_,[],[]).
del1(El,[El|T],T1):-del1(El,T,T1).
del1(El,[X|T],[X|T1]):-not(El=X),del1(El,T,T1).

del([],L,L).
del([H|Tail],L,Ans):-del1(H,L,Temp),del(Tail,Temp,Ans).

show_dis(Name1,Name2) :- findall(L,fact(Name1,L),X1), nth_element(1,X1,LL1),
                         findall(L,fact(Name2,L),X2), nth_element(1,X2,LL2),
                         append(LL1,LL2,Lo), intersect(LL1,LL2,Li),
                         del(Li,Lo,Res), prnn(Res,LL1,LL2).

disprop_obj :- write('Вы решили узнать различия между объектами.'),nl,
               put_general_info,
               write('Введите имена объектов, которые хотите сравнить:'),nl,
               write('Пример ввода : хоккей.  '),nl,nl,
               read(Name1),nl,read(Name2),nl,
               show_dis(Name1, Name2).

%-----------------------------------------------------------------------------
%            --- Просмотр различий между классами  ---

show_dis_cl(skill,Name1,Name2) :- findall(X, skill(Name1, X), M1),append(M1, L1),list_to_set(L1, S1),
                                  findall(X, skill(Name2, X), M2),append(M2, L2),list_to_set(L2, S2),
                                  append(S1,S2,Lo), intersect(S1,S2,Li),
                                  del(Li,Lo,Res), prnn(Res,S1,S2).
show_dis_cl(category,Name1,Name2) :- findall(X, category(Name1, X), M1),append(M1, L1),list_to_set(L1, S1),
                                     findall(X, category(Name2, X), M2),append(M2, L2),list_to_set(L2, S2),
                                     append(S1,S2,Lo), intersect(S1,S2,Li),
                                     del(Li,Lo,Res), prnn(Res,S1,S2).
show_dis_cl(seastype,Name1,Name2) :- findall(X, seastype(Name1, X), M1),append(M1, L1),list_to_set(L1, S1),
                                     findall(X, seastype(Name2, X), M2),append(M2, L2),list_to_set(L2, S2),
                                     append(S1,S2,Lo), intersect(S1,S2,Li),
                                     del(Li,Lo,Res), prnn(Res,S1,S2).
show_dis_cl(sport_type,Name1,Name2) :- findall(X, sport_type(Name1, X), M1),append(M1, L1),list_to_set(L1, S1),
                                       findall(X, sport_type(Name2, X), M2),append(M2, L2),list_to_set(L2, S2),
                                       append(S1,S2,Lo), intersect(S1,S2,Li),
                                       del(Li,Lo,Res), prnn(Res,S1,S2).

disprop_cl :- write('Вы решили узнать различия между классами.'),nl,
              put_general_info,
              write('Введите класс и имена, которые хотите сравнить:'),nl,
              write('Пример ввода : skill.  скорость. выносливость. '),nl,nl,
              read(Cl),nl,read(Name1),nl,read(Name2),nl,
              show_dis_cl(Cl,Name1,Name2).

%-----------------------------------------------------------------------------
%            --- Найти по свойству все объекты  ---

add([],E,[E]).
add([L1|H1],E,[L1|H2]):-add(H1,E,H2).

f(_,[],[],Res,Res).
f(M,[X|T],[Xn|Tn],K,Res) :- find_it(M,X),add(K,Xn,K1),f(M,T,Tn,K1,Res).
f(M,[_|T],[_|Tn],K,Res)  :- f(M,T,Tn,K,Res).

test([],E,[E]).
test([L1|H1],E,[L1|H2]):-test(H1,E,H2).

find_o(category,N,L,X)   :- findall(R,f(category(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(seastype,N,L,X)   :- findall(R,f(seastype(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(sport_type,N,L,X) :- findall(R,f(sport_type(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).           
find_o(skill,N,L,X)      :- findall(R,f(skill(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).                
find_o(place,N,L,X)      :- findall(R,f(place(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).                
find_o(gender,N,L,X)     :- findall(R,f(gender(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(season,N,L,X)     :- findall(R,f(season(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(status,N,L,X)     :- findall(R,f(status(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res). 
find_o(have,N,L,X)       :- findall(R,f(have(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(like,N,L,X)       :- findall(R,f(like(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).
find_o(can,N,L,X)        :- findall(R,f(can(N),L,X,[],R),RR),nth_element(1,RR,Res), prn(Res).

find_obj :- write('Вы решили найти по свойству все объекты.'),nl,
            put_general_info,
            write('Введите класс и имя свойства, которые Вы знаете:'),nl,
            write('Пример ввода : skill.  скорость. '),nl,nl,
            read(Cl),nl,read(Name),nl,
            findall(L,fact(_,L),Ll),findall(X,fact(X,_),Xx),
            find_o(Cl,Name,Ll,Xx).

%-----------------------------------------------------------------------------

check_mode('exit') :- !.
check_mode('a')    :- add_obj,nl,fail.
check_mode('b')    :- fix_obj,nl,fail.
check_mode('c')    :- look_attr_obj,nl,fail.
check_mode('d')    :- look_attr_class,nl,fail.
check_mode('e')    :- disprop_obj,nl,fail.
check_mode('f')    :- disprop_cl,nl,fail.
check_mode('g')    :- find_obj,nl,fail.
check_mode('h')    :- find_cl,nl,fail.

main:- repeat,
       ['can.txt'], ['have.txt'], ['like.txt'], ['q_db.txt'],
       write('------------------------------------------------------------'),nl,
       write('Вас приветствует система по распознаванию видов спорта!'),nl,
       write('Что я могу помочь?'),nl,
       write('  1) a. - добавить в базу знаний новый объект'),nl,
       write('  2) b. - исправить ошибочные признаки объекта в базе знаний'),nl,
       write('  3) c. - посмотреть свойства объекта'),nl,
       write('  4) d. - посмотреть свойства класса'),nl,
       write('  5) e. - узнать различия между объектами'),nl,
       write('  6) f. - узнать различия между классами'),nl,
       write('  7) g. - найти все объекты с заданным свойством'),nl,
       write('  8) exit. - завершить работу с системой'),nl,
       read(C),nl,
       check_mode(C),!.





















