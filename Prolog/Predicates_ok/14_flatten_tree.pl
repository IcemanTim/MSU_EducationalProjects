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