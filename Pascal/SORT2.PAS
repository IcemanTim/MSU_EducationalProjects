{Author: Galkov A.V
 Group: 115
 Задание: Быстрая сортировка, нерекурсивный метод;
 Этап: 2}
program prog(input,output);
const n=100; m=10;
type  FF=File of Char;
      stroka=array [1..m] of char;
      mass=array [1..n] of Stroka;
var F:FF;
    A:mass;
    k,srav,peres:integer;
{*************************************************************************
 F - файл, из которого считывается последовательность;
 A - двумерный массив, в котором хранится последовательность из слов,
     каждое слово в отдельной строке:
 k - число слов в последовательности;
 srav - число сравнений;
 peres - число перестановок;
*************************************************************************}

{Процедура ZapF заполняет файл данными с клавиатуры}
procedure ZapF(var F:FF);
var n,i,l:integer;
    a:char;
begin
 rewrite(F);
 write ('Введите количество слов=') ;
 readln(n);
 l:=1;
 writeln('Введите ',n,' слов из строчных русских букв через пробел, на конце точка');
 while l<=n do
  begin
   read(A);
   if (A=' ') or (A='.')
      then l:=l+1;
   if A<>'.'
      then write(F,A)
  end;
 close(F)
End;

{Процедура Read_File считывает данные из файла}
procedure Read_File(var F:FF; var A:mass; var i:integer);
var j:integer;
    x:char;
begin
 reset(F);
 i:=1;
 j:=1;
 while not eof(F) do
  begin
   read(F,x);
   if x<>' '
      then begin
            A[i,j]:=x;
            j:=j+1;
           end
      else begin
            i:=i+1;
            j:=1;
           end;
  end;
 writeln;
 close(F)
End;

{Процедура zap_Mass заполняет массив, в который потом будут
 записываться элементы последовательности, символом '-'}
procedure zap_Mass(var A:mass);
var i,j:integer;
begin
 for i:=1 to n do
  for j:=1 to m do
   A[i,j]:='-'
end;

{Процедура Write_Mass выводит текущее состояние массива}
procedure Write_Mass(var A:mass; k:integer);
var i,j:integer;
begin
 for i:=1 to k do
  begin
   j:=1;
   while A[i,j]<>'-' do
    begin
     write(A[i,j]);
     j:=j+1;
    end;
   write(' ');
  end;
 writeln;
end;

{Процедура zam меняет местами две строки}
procedure zam(var st1,st2:stroka);
var x:stroka;
begin
 x:=st1;
 st1:=st2;
 st2:=x;
 peres:=peres+1;
end;

{************************************************************************
Основная процедура q_sort осуществляет быструю сортировку нерекурсивным
методом.
В своей работе использует процедуры:
1) zam(var st1,st2:stroka) - меняет местами две строки st1 и st2;
2) sort1(var A:mass; i,j:integer; var m:integer) - вызывается,
   если количество сортируемых строк больше трех; фиксирует среднюю
   строку среди строк от i до j массива A и ставит ее на свое место;
   возвращает измененый массив и новый индекс m фиксированной строки;
3) sort2(var A:Mass; ot1,ot2:integer) - вызывается, если количество
   сортируемых строк меньше или равно трем; сортирует строки от i
   до j путем обычного их сравнения;
************************************************************************}

procedure q_sort(var A:mass; k:integer);
var stek:array [1..n] of integer;
    sp,ot,m,i:integer;
{************************************************************************
  A - сортируемый массив;
  k - число элементов в массиве;
  stek - массив, в котором записываются начало и конец отрезков, которые
         необходимо отсортировать с помощью процедуры sort1;
  sp - число элементов в stek;
  ot,m,i - вспомогательные переменные;
************************************************************************}

procedure sort1(var A:mass; i,j:integer; var m:integer);
var q:stroka;             { - вспомогательный массив-строка}
begin
 q:=A[(j+i) div 2];
 while i<>j do
  begin
   while A[i]<q do
    begin
     i:=i+1;
     srav:=srav+1;
    end;
   while A[j]>q do
    begin
     j:=j-1;
     srav:=srav+1;
    end;
   if i<>j
      then zam(A[i],A[j]);
   srav:=srav+1;
  end;
 m:=i;
end;

procedure sort2(var A:Mass; ot1,ot2:integer);
begin
 case ot2-ot1+1 of
  3:begin
     if A[ot2] < A[ot2-1]
        then zam( A[ot2] , A[ot2-1] );
     if A[ot2-1] < A[ot2-2]
        then zam(A [ot2-1] , A[ot2-2] );
     if A[ot2] < A[ot2-1]
        then zam( A[ot2] , A[ot2-1] );
     srav:=srav+3;
    end;
  2:begin
     if A[ot2] < A[ot2-1]
        then zam( A[ot2] , A[ot2-1] );
     srav:=srav+1;
    end;
 end;
end;

{************************************************************************
Алгоритм работы процедуры q_sort:
1) Задаем начальное состояние стека:
2) В цикле с условием: пока стек непустой:
2.1) берем из стека два значения: начало и конец сортируемого отрезка -
     и сортируем его.
     Получаем два новых отрезка [stek[sp-1],m) и (m,stek[sp]],
     где m - индекс строки, фиксированной при сортировке;
2.2) с помощью вспомогательной переменной сохраняем конец отрезка, чтобы
     это значение не было потеряно в дальнейших преобразованиях;
2.3) проверяем, каким методом будем сортировать отрезки, полученные
     на шаге 2.1. Если длина отрезка меньше или равна трем, то сортируем,
     используя процедуру sort2, иначе записываем в стек: этот отрезок
     будет отсортирован на следующем шаге цикла.
************************************************************************}

begin
 stek[1]:=1;                          {1}
 stek[2]:=k;
 sp:=2;

 while sp>0 do                        {2}
  begin
   sort1(A,stek[sp-1],stek[sp],m);    {2.1}
   ot:=stek[sp];                      {2.2}
   if m-stek[sp-1]<=3                 {2.3}
      then begin
            sort2(A,stek[sp-1],m-1);
            sp:=sp-2;
           end
      else stek[sp]:=m-1;
   if ot-m<=3                         {2.3}
      then sort2(A,m+1,ot)
      else begin
            sp:=sp+2;
            stek[sp-1]:=m+1;
            stek[sp]:=ot;
           end;
   srav:=srav+2;
   write_Mass(A,k);
  end;
end;

Begin
 assign(F,'input.int');      { - привязываем файл к переменной}
 zapf(F);                    { - записываем в файл последовательность}
 zap_Mass(A);                { - заполняем массив символами '-'}
 Read_File(F,A,k);           { - читаем с файла последоваетельность
                                 и записываем ее в массив}
 Write_Mass(A,k);            { - выводим начальное состояние массива}
 srav:=0;                    { - начальное число сравнений}
 peres:=0;                   { - начальное число перестановок}
 q_sort(A,k);                { - сортируем массив}

{Выводим окончательные результаты}
 writeln('Окончательный вид последовательности: ');
 Write_Mass(A,k);
 writeln('Число перестановок: ',peres);
 writeln('Число Сравнений: ',srav)
End.