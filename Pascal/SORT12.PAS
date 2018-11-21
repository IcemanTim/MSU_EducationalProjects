program sort12(input,output);{Быстрая сортировка, рекурсивный вариант}
{Попова}
label
  11,12;
const
  N=10;
var
  A:array[1..N] of integer;
  i,P,f,l,k,mid,per,count:integer;

begin
     writeln('Ввод массива');
     for i:=1 to N do
         read(A[i]);
     writeln('введенный массив');
     for i:=1 to N do
         write(A[i],' ');
     writeln;
     writeln('Выводим промежуточные значения');
     per:=0;
     count:=0;
     f:=1;
     l:=N;
12: if f<l then
        begin
        k:=(f+l) div 2;
        mid:=A[k];
        repeat
              while A[f]<mid do
                     begin
                     f:=f+1;
                     count:=count+1;
                     end;
              while A[l]>mid do
                    begin
                    l:=l-1;
                    count:=count+1;
                    end;
              if f<l then
                 begin
                   P:=A[l];
                   A[l]:=A[f];
                   A[f]:=P;
                   f:=f+1;
                   l:=l-1;
                   per:=per+1;
                   count:=count+2;
                   for i:=1 to N do
                   write(A[i],' ');
                   writeln;
                 end
        until f>=l;
        l:=l;
        f:=1;
        goto 12;
        end
    else
       begin
       l:=N;
       f:=1;
   11: if f<l then
        begin
        k:=(f+l) div 2;
        if k<>f then begin
        mid:=A[k];
        repeat
              while A[f]<mid do
                    begin
                     f:=f+1;
                     count:=count+1;
                     end;
              while A[l]>mid do
                    begin
                    l:=l-1;
                    count:=count+1;
                     end;
              if f<l then
                 begin
                   P:=A[l];
                   A[l]:=A[f];
                   A[f]:=P;
                   f:=f+1;
                   l:=l-1;
                   per:=per+1;
                   count:=count+2;
                   for i:=1 to N do
                       write(A[i],' ');
                   writeln;
                 end
        until f>=l;
        l:=N;
        f:=f;
        goto 11;
        end
        else if A[l]<A[f] then
                   begin
                   P:=A[l];
                   A[l]:=A[f];
                   A[f]:=P;
                   per:=per+1;
                   end;
        end;
     end;
     writeln('Окончательный результат');
     for i:=1 to N do
     write(A[i],' ');
     writeln;
     writeln('Всего проведено сравнений = ',count+1);
     writeln('Сделано  перестановок = ',per);
end.

