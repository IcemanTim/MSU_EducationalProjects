{Author:Galkov A.V.,
  Group:115
   Task:����஢�� ��⮤�� ���⮣� ��ॡ�� �� �뢠���}
program prog(input,output);
const   n=10;

type    vector=array [1..n] of integer;

var     sp,ss:integer;
        A:vector;

{��楤�� ����� �����}
procedure vvod_vector(var A:vector);
var i:integer;
begin
 writeln('������ �����');
 for i:=1 to n do
                 begin
                  write('A[',i,']=');
                  readln(A[i]);
                 end;
end;

{��楤�� �뢮�� �����}
procedure print_vector(var A:vector);
var i:integer;
begin
{ for i:=1 to n do write(i:5);
 writeln;
 for i:=1 to 30 do write('X');
 writeln;}
 for i:=1 to n do write(A[i]:5);
end;

{��楤�� ����⠭���� ���⠬� ���祭�� ���� ������⮢}
procedure perestan(var x,y:integer);
var help:integer;
begin
 help:=x;
 x:=y;
 y:=help;
 sp:=sp+1;
end;

{��楤�� ���� ���ᨬ��쭮�� ������� � �����}
procedure poisk_max(var i,max,jmax:integer);
var j:integer;
begin
 max:=A[i];   {���ᨬ���� �������}
 jmax:=i;     {����� ���ᨬ��쭮�� �������}
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

{��楤�� ���஢�� ��⮤�� ���⮣� ��ॡ�� �� �뢠���}
procedure  sortppy(var A:vector);
var  i,max,jmax:integer;
begin
 for i:=1 to n-1 do
                   begin
                    poisk_max(i,max,jmax);
                    if A[i]<>A[jmax]
                                    then perestan(A[i],A[jmax]);
                    write('��� ',i,':');
                    print_vector(A);
                    writeln('  *  ',A[i],' � ',A[jmax]);
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
                writeln('�����⥫�� ��� �����');
 print_vector(A);
                writeln;
                writeln('�������⢮ ����⠭����:',sp:5);
                writeln('�������⢮ �ࠢ�����:',ss:5);
end.