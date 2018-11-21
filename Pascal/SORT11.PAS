program sort1metod2(input,output);{Сортировка массива бинарными вставками}
{Попова}
label
  12;
const
  N=10;
var
  C:array[1..N] of integer;
  i,j,k,P,M,a,b,sr,per,x:integer;
begin
  writeln('1) Введение массива');
  writeln('Введите массив в строчку через пробел');
  for i:=1 to N do
      read(C[i]);
  writeln('2) Введеный массив');
  for i:=1 to N do
      write(C[i],' ');
  writeln;
  {Начало сортировки}
  sr:=0;
  per:=0;
  for i:=2 to N do
      begin
       a:=1;
       b:=i-1;
       x:=C[i];
       k:=b-a;
       while k>=1 do
             begin
              P:=a+k div 2;
              if C[P]>x then
                 begin
                 b:=P-1;
                 sr:=sr+1;
                 end
              else
                  if C[P]=x then
                     begin
                     a:=b;
                     goto 12;
                     end
                  else
                      begin
                      a:=P+1;
                      sr:=sr+1;
                      end;
              K:=b-a;
             end;
     12: if C[a]<=x then
          begin
          M:=a+1;
          sr:=sr+1;
          end
         else
               begin
               sr:=sr+1;
               M:=a;
               end;
       for j:=i-1 downto M do
           begin
            C[j+1]:=C[j];
            per:=per+1;
           end;
           C[M]:=x;
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


