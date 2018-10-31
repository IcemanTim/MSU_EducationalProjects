num_five(empty,0).
num_five(tree(L,R,5),N):-num_five(L,N1),num_five(R,N2),N is N1+N2+1,!.
num_five(tree(L,R,_),N):-num_five(L,N1),num_five(R,N2),N is N1+N2.