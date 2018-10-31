similar([],[]).
similar([X|T1],[X|T2]):-write(T1),write(" + "),write(T2),nl,similar(T1,T2).
similar([[_|_]|T1],[[]|T2]):-write(T1),write(" - "),write(T2),nl,similar(T1,T2).