program sort1metod2(input,output);{����஢�� 楫��᫥����� ���ᨢ� �����묨 ��⠢����}
{������ �������� 114 ��}
const
  N=10;
var
  C:array[1..N] of integer;
  i,j,a,b,sr,per,x:integer;
begin
  writeln('1) �������� ���ᨢ�');
  for i:=1 to N do
     read(C[i]);
  writeln('2) ������� ���ᨢ');
  for i:=1 to N do
      write(C[i],' ');
  writeln;
  {��砫� ���஢��}
  sr:=0;     {���稪 �᫠ �ࠢ�����}
  per:=0;    {���稪 �᫠ ����⠭����}
  for i:=2 to N do
      begin
       a:=1; {����� �࠭�� �����஢������ ��१��}
       b:=i; {�ࠢ�� �࠭�� �����஢������ ��१��}
       x:=C[i];  {��⠢�塞� �������}
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
       writeln(i-1,' �⠯ ���஢��: ');
       for j:=1 to N do
            write(C[j],' ');
       writeln;
      end;
      writeln('3) �뢮��� ����⮢���� ���ᨢ');
      for i:=1 to N do
          write(C[i],' ');
      writeln;
      writeln('� 室� ࠡ��� �஢����� ',sr,' �ࠢ�����');
      writeln('��饥 �᫮ ����⠭���� = ',per);
end.


