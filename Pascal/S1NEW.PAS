program sort1metod2(input,output);{Сортировка целочисленного массива бинарными вставками}
{Попова Елизавета 114 гр}
const
  N=10;
var
  C:array[1..N] of integer;
  i,j,a,b,sr,per,x:integer;
begin
  writeln('1) Введение массива');
  for i:=1 to N do
     read(C[i]);
  writeln('2) Введеный массив');
  for i:=1 to N do
      write(C[i],' ');
  writeln;
  {Начало сортировки}
  sr:=0;     {Счетчик числа сравнений}
  per:=0;    {Счетчик числа перестановок}
  for i:=2 to N do
      begin
       a:=1; {Левая граница отсортированного отрезка}
       b:=i; {Правая граница отсортированного отрезка}
       x:=C[i];  {Вставляемый элемент}
       while a<=b do
       if x>=C[(b+a) div 2] then
          begin
               sr:=sr+1;
               a:=(b+a) div 2+1;
          end
       else
           begin
                sr:=sr+1;
                b:=(b+a) div 2-1;
           end;
       for j:=i-1 downto a do
           begin
            C[j+1]:=C[j];
            per:=per+1;
           end;
       if a<=i then
            C[a]:=x;
       writeln(i-1,' этап сортировки: ');
       for j:=1 to N do
            write(C[j],' ');
       writeln;
      end;
      writeln('3) Выводим отсоритованный массив');
      for i:=1 to N do
          write(C[i],' ');
      writeln;
      writeln('В ходе работы проведено ',sr,' сравнений');
      writeln('Общее число перестановок = ',per);
end.


