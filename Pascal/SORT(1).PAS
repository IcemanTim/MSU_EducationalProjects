{Author:Galkov A.V.,
  Group:115
   Task:Сортировка методом простого перебора по убыванию}
program prog(input,output);
const   n=10;

type    vector=array [1..n] of integer;

var     sp,ss:integer;
        A:vector;

{Процедура ввода вектора}
procedure vvod_vector(var A:vector);
var i:integer;
begin
 writeln('Введите вектор');
 for i:=1 to n do
                 begin
                  write('A[',i,']=');
                  readln(A[i]);
                 end;
end;

{Процедура вывода вектора}
procedure print_vector(var A:vector);
var i:integer;
begin
{ for i:=1 to n do write(i:5);
 writeln;
 for i:=1 to 30 do write('X');
 writeln;}
 for i:=1 to n do write(A[i]:5);
end;

{Процедура перестановки местами значений двух элементов}
procedure perestan(var x,y:integer);
var help:integer;
begin
 help:=x;
 x:=y;
 y:=help;
 sp:=sp+1;
end;

{Процедура поиск максимального элемента в векторе}
procedure poisk_max(var i,max,jmax:integer);
var j:integer;
begin
 max:=A[i];   {Максимальный элемент}
 jmax:=i;     {Номер максимального элемента}
 for j:=i+1 to n do
                   begin
                    if A[j]>max
                               then
                                   begin
                                    max:=A[j];
                                    jmax:=j;
                                   end;
                    ss:=ss+1;
                   end;
end;

{Процедура сортировки методом простого перебора по убыванию}
procedure  sortppy(var A:vector);
var  i,max,jmax:integer;
begin
 for i:=1 to n-1 do
                   begin
                    poisk_max(i,max,jmax);
                    if A[i]<>A[jmax]
                                    then perestan(A[i],A[jmax]);
                    write('Шаг ',i,':');
                    print_vector(A);
                    writeln('  *  ',A[i],' и ',A[jmax]);
                   end;

end;

begin
 vvod_vector(A);
                write(' ':6);
 print_vector(A);
                writeln;
 sp:=0;
 ss:=0;
 sortppy(A);
                writeln;
                writeln('Окончательный вид вектора');
 print_vector(A);
                writeln;
                writeln('Колличество перестановок:',sp:5);
                writeln('Колличество сравнений:',ss:5);
end.