{Author: Galkov A.V
 Group: 115
 Task: Game of Life
  ���ᠭ��:
  - - ����� ���⪠
  0 - ��⥭��
  + - �ࠢ�來��
  * - �魨�
  # - ᢥ��ᮡ�
  & - ��ࠦ����� �ᮡ� (�����)
 �ணࠬ�� ࠡ�⠥� � ���� ०����: �⫠��筮� � ���筮�.
 � �⫠��筮� ०��� �࠭� �� ����⭮��. ��ப ����� �����
  ��砫쭮� ���ﭨ� ��⥬� �� �।�������� ��� ������ ������.
 �����, ��� �㦭� �������� ��� ���� ����⢮, �� ��ப� �ॡ����
  ����� ����� ��ப� � �⮫�� �������, ����� ����室��� ��������.
 � ���筮� ०��� ��⥬� ����砫쭮 ��������� ����묨 ���⪠��,
  � ��砫쭮� ������⢮ ��⥭�� � �ࠢ�來�� �������� ��ப��.
 ����� ��⥬� ���������� ��砩�� ��ࠧ��.
 � ���⮩ ���⪥ � ����⭮���� 5% ����� ������ ��⥭��
  � � ⠪�� �� ����⭮���� �ࠢ�來��.

 ��騥 �ࠢ���.
 �᫨ �冷� � ��⥭��� ���� �ࠢ�來��, � �ࠢ�來��
  �c� ��⥭��, � �� ���� ��⥭�� ஦������ ��㣮� �ࠢ�來��.
 �᫨ �冷� � �ࠢ�來� ���� �魨�, � �魨� ��� �ࠢ�來��,
  � �� ���� �ࠢ�來��� ஦������ �� ���� �魨�.
 �᫨ �冷� � �魨��� ���� ᢥ��ᮡ�, � ��� ��� �魨��,
  � �� ��� ���� ஦������ ��㣠� ᢥ��ᮡ�.
 �᫨ �冷� � �ࠢ�來� ��� �� ��⥭��, �� �魨���,
  � ��� �⠭������ �魨���.
 �������筮, �᫨ �冷� � �魨��� ��� �� �ࠢ�來��, �� ᢥ��ᮡ��,
  � �魨� �⠭������ ᢥ��ᮡ��.
 �� ��ᠥ��� ᢥ��ᮡ��, � �� ���� �� ���, � ��� �� � ���� ��
  �ॢ������, �� � ��� � ᢥ��ᮡ�. ������, �᫨ ��ப
  ��筥� ��������, � �।� ��� ������� ��ࠧ�� �ᮡ�-�����,
  ��祬, �᫨ ����� �������� ���⮪ ����� ᢥ��ᮡ� ������
  �����, � ��� �� ������ � ᥡ� ��������, ���� ���� �ꥤ��� ��.
 ���� ����⢮-�����, �᫨ �冷� � ��� ����� �������� ⠪�� ��
  �����-�����, 㬨ࠥ�.
 �� ��㣨� �����, �஬� ᢥ��ᮡ��, ����� ����� �� ॠ������.
 �� ���� 室 � �ᮡ�� ����� �ந���� ⮫쪮 ���� ���������.
 ����� ��ப ����� �ࠢ� �������� �� ������⢮ ��⥭��,
  �ࠢ�來��, �魨���, ᢥ��ᮡ��, ����� ��������,
  ��⠭����� ��, ���ந�� ��⥮��� �����
  (�롨����� �ந������ ��ࠧ�� �����஥ ������⢮ ���⮪, � ��,
  �� � ���, � ⠪�� � ����� �������� ���⪠� 㬨ࠥ�
  - �㤠 �������� ��⥮��).
 �⮡� ��⠭����� ����, ���짮��⥫� ������ ����� ��ਠ��
 "���ந�� ����� ᢥ�".}

program prog(input,output);
const n=20; m=70;           { - ࠧ���� ������ � ���筮� ०���}
      k=6; l=12;            { - ࠧ���� ������ � �⫠�筮� ०���}
type  matr=array [1..n,1..m] of char;
var   A:matr;
      y:integer;

{��楤�� ���樠����樨 ��砫쭮�� ���ﭨ�. �� ���⪨ �����}
procedure pysto(var A:matr);
{ - ��譨� ��ࠬ��஢ ���}
var   i,j:integer;
begin
 for i:=1 to n do
  for j:=1 to m do
   A[i,j]:='-';
end;

{��楤�� ��� ���� ⥪�饣� ���ﭨ� ��������}
procedure print(var A:matr;p,q:integer);
{ - ��譨� ��ࠬ��஢ ���, p,q - ࠧ���� ������ (������� �� ०���)}
var i,j:integer;
begin
 writeln;
 for i:=1 to p do
  begin
   for j:=1 to q do
    write(A[i,j]);
   writeln
  end;
 writeln;
 write('������ Enter');
 readln;
end;

{��楤�� ���������� ����� �� �⫠���}
procedure dob_ot(var A:matr;x:integer;ch1,ch2:char);
{ - �뫨 ��譨� ��ࠬ���� p,q. ��ࠫ)}
var l,i,j:integer;
begin
 l:=0;
 while l<>x do
  begin
   write('������ ����� ��ப� � �⮫��, � ����� �㦭� �������� ����⢮: ');
   readln(i,j);
    if A[i,j]=ch2
       then A[i,j]:=ch1
       else l:=l-1;
   l:=l+1;
  end;
end;


{��楤�� ���������� ����� � ���筮� ०���}
procedure dob(var A:matr; x:integer;ch1,ch2:char);
{ - �뫨 ��譨� ��ࠬ���� p,q. ��ࠫ)}
var l,i,j:integer;
begin
 l:=0;
 while l<>x do
  begin
   i:=1+random(n);
   j:=1+random(m);
   if A[i,j]=ch2
      then A[i,j]:=ch1
      else l:=l-1;
   l:=l+1;
  end;
end;

{��楤�� ��� ���⪨ ��࠭�}
procedure clean;  { - ��� ��譨� ��ࠬ��஢}
var i:integer;
begin
 for i:=1 to 30 do writeln;
end;

{��������� ���⮩ ���⪨}
function pys:char;
{ - �뫨 ��譨� ��ࠬ���� A:matr; gr1,gr2,gr3,gr4:integer. ��ࠫ}
var x:integer;
begin
 x:=1+random(100);
 if (x>=1) and (x<=5)
    then pys:='0'
    else if (x>=11) and (x<=15)
            then pys:='+'
            else pys:='-';
end;

{�㭪�� ��������� ��⥭��}
function eda(var A:matr; gr1,gr2,gr3,gr4:integer):char;
{ - ��� ��譨� ��ࠬ��஢}
var i,j:integer;
    f:boolean;
begin
 f:=false;
 for i:=gr1 to gr2 do
  for j:=gr3 to gr4 do
   if A[i,j]='+'
      then f:=true;
 if f
    then eda:='+'
    else eda:='0';
end;

{�㭪�� ��������� �ࠢ�來��}
function osob1(var A:matr; gr1,gr2,gr3,gr4:integer):char;
{ - ��� ��譨� ��ࠬ��஢}
var i,j:integer;
    f1,f2:boolean;
begin
 f1:=false;
 f2:=false;
 for i:=gr1 to gr2 do
  for j:=gr3 to gr4 do
   case A[i,j] of
    '0': f1:=true;
    '*': f2:=true;
   end;
 if f2
    then osob1:='*'
    else if f1
            then osob1:='+'
            else osob1:='*';
end;

{�㭪�� ��������� �魨���}
function osob2(var A:matr; gr1,gr2,gr3,gr4:integer):char;
{ - ��� ��譨� ��ࠬ��஢}
var i,j:integer;
    f1,f2:boolean;
begin
 f1:=false;
 f2:=false;
 for i:=gr1 to gr2 do
  for j:=gr3 to gr4 do
    case A[i,j] of
    '+': f1:=true;
    '#': f2:=true;
    end;
 if f2
    then osob2:='#'
    else if f1
         then osob2:='*'
         else osob2:='#'
end;

{�㭪�� ��������� ᢥ��ᮡ��}
function osob3(var A:matr; gr1,gr2,gr3,gr4:integer):char;
{ - ��� ��譨� ��ࠬ��஢}
var i,j,s:integer;
begin
 s:=0;
 for i:=gr1 to gr2 do
  for j:=gr3 to gr4 do
   if A[i,j]='&'
      then s:=s+1;
 if s<>0
    then if s>(gr2-gr1+1)*(gr4-gr3+1) div 2
         then osob3:='-'
         else osob3:='&'
    else osob3:='#';
end;

{�㭪�� ��������� �����-�ᮡ�}
function zombi(var A:matr; gr1,gr2,gr3,gr4:integer):char;
{ - ��� ��譨� �ࠬ��஢}
var s,i,j:integer;
begin
 s:=0;
 for i:=gr1 to gr2 do
  for j:=gr3 to gr4 do
   if A[i,j]='&'
      then s:=s+1;
 if s>=(gr2-gr1+1)*(gr4-gr3+1) div 2
    then zombi:='-'
    else zombi:='&'
end;

{��楤�� ��������� �����}
procedure change(var A:matr; p,q:integer);
{ - ��� ��譨� ��ଥ�஢}
var  i,j,gr1,gr2,gr3,gr4:integer;
     B:matr;
begin
 B:=A;
 for i:=1 to p do
  for j:=1 to q do
   begin
    gr1:=i-1;
    gr2:=i+1;
    gr3:=j-1;
    gr4:=j+1;
    if i=1 then gr1:=1;
    if i=p then gr2:=p;
    if j=1 then gr3:=1;
    if j=q then gr4:=q;
    case A[i,j] of
     '-': if p=n
             then B[i,j]:=pys;
     '0': B[i,j]:=eda(A,gr1,gr2,gr3,gr4);
     '+': B[i,j]:=osob1(A,gr1,gr2,gr3,gr4);
     '*': B[i,j]:=osob2(A,gr1,gr2,gr3,gr4);
     '#': B[i,j]:=osob3(A,gr1,gr2,gr3,gr4);
     '&': B[i,j]:=zombi(A,gr1,gr2,gr3,gr4);
    end;
   end;
  A:=B;
end;

{��⠭����� ��������}
procedure stop_epid(var A:matr; p,q:integer);
{ - ��� ��譨� ��ࠬ��஢}
var i,j:integer;
begin
 for i:=1 to p do
  for j:=1 to q do
   if A[i,j]='&'
      then A[i,j]:='-';
end;

{��⥮��� �����}
procedure mete_dozd(var A:matr; y:integer);
{ - ��� ��譨� ��ࠬ��஢}
var i,j,l:integer;
begin
 for l:=1 to y do
  begin
   i:=1+random(n);
   j:=1+random(m);
   A[i,j]:='-';
   if i<>1 then A[i-1,j]:='-';
   if i<>n then A[i+1,j]:='-';
   if j<>1 then A[i,j-1]:='-';
   if j<>m then A[i,j+1]:='-';
  end;
end;

{��⥮��� �����. �⫠���}
procedure mete_dozd_ot(var A:matr; y:integer);
{ - �뫨 ��譨� ��ࠬ���� p,q. ��ࠫ}
var i,j,z:integer;
begin
 z:=0;
 while z<>y do
  begin
   write('������ ����� ��ப� � �⮫�� �������, � ����� ����� ��⥮��: ');
   readln(i,j);
   A[i,j]:='-';
   if i<>1 then A[i-1,j]:='-';
   if i<>k then A[i+1,j]:='-';
   if j<>1 then A[i,j-1]:='-';
   if j<>l then A[i,j+1]:='-';
   z:=z+1;
  end;
end;

{����� ᢥ�}
procedure apoc(var A:matr; p,q:integer);
{ - ��� ��譨� ��ࠬ��஢}
var   i,j:integer;
begin
 for i:=1 to p do
  for j:=1 to q do
   if A[i,j]<>'-'
      then A[i,j]:='';
end;

{�᭮���� ����}
procedure main_part(var A:matr; p,q:integer);
{ - ��� ��譨� ��ࠬ��஢}
var x,y:integer;

{�஢�ઠ ������ ����}
function prov_mest(var A:matr; y,p,q:integer; ch:char):boolean;
{ - ��譨� ��ࠬ��஢ ���}
var s,i,j:integer;
begin
 s:=0;
 for i:=1 to p do
  for j:=1 to q do
   if A[i,j]=ch
      then  s:=s+1;
 if y>s
    then prov_mest:=false
    else prov_mest:=true;
end;

begin
 repeat
  change(A,p,q);
  print(A,p,q);
  writeln('������: 1-�������� ��⥭��,');
  writeln('         2-�������� �ࠢ�來��,');
  writeln('         3-�������� �魨���');
  writeln('         4-�������� ᢥ��ᮡ��,');
  writeln('         5-����� ��������');
  writeln('         6-��⠭����� ��������');
  writeln('         9-��⥮��� �����');
  writeln('         0-��祣� �� ������,');
  writeln('         666-���ந�� ����� ᢥ�');
  readln(x);
  case x of
   1: begin
       write('������ ������⢮ ������塞�� ��⥭��: ');
       readln(y);
       if prov_mest(A,y,p,q,'-')
          then if p=n
                  then dob(A,y,'0','-')
                  else dob_ot(A,y,'0','-')
          else writeln('��墠⠥� ����');
      end;
   2: begin
       write('������ ������⢮ ������塞�� �ࠢ�來��: ');
       readln(y);
       if prov_mest(A,y,p,q,'-')
          then if p=n
                  then dob(A,y,'+','-')
                  else dob_ot(A,y,'+','-')
          else writeln('��墠⠥� ����');
      end;
   3: begin
       write('������ ������⢮ ������塞�� �魨���: ');
       readln(y);
       if prov_mest(A,y,p,q,'-')
          then if p=n
                  then dob(A,y,'*','-')
                  else dob_ot(A,y,'*','-')
          else writeln('��墠⠥� ����');
      end;
   4: begin
       write('������ ������⢮ ������塞�� ᢥ��ᮡ��: ');
       readln(y);
       if prov_mest(A,y,p,q,'-')
          then if p=n
                  then dob(A,y,'#','-')
                  else dob_ot(A,y,'#','-')
          else writeln('��墠⠥� ����');
      end;
   5: begin
       write('������ ������⢮ ������塞�� �����: ');
       readln(y);
       if prov_mest(A,y,p,q,'#')
          then if p=n
                  then dob(A,y,'&','#')
                  else dob_ot(A,y,'&','#')
          else writeln('��墠⠥� ����');
      end;
   6: stop_epid(A,p,q);
   9: begin
       write('������ ������⢮ ��⥮�⮢: ');
       readln(y);
       if p=n
          then mete_dozd(A,y)
          else mete_dozd_ot(A,y);
      end;
   0:;
   666: apoc(A,p,q);
  end;
  print(A,p,q);
 until x=666;
end;

{�⫠���� ०��}
procedure otlad(var A:matr);
{ - ��� ��譨� ��ࠬ��஢}
var x:integer;

{��楤�� ������� ��砫쭮�� ���ﭨ� - 1}
procedure nach_1(var A:matr);
{ - ��� ��譨� ��ࠬ��஢}
begin
 A[1,1]:='0'; A[1,2]:='+'; A[1,3]:='-'; A[1,4]:='+'; A[1,5]:='+'; A[1,6]:='-';
 A[1,7]:='-'; A[1,8]:='-'; A[1,9]:='-'; A[1,10]:='&'; A[1,11]:='&'; A[1,12]:='&';

 A[2,1]:='-'; A[2,2]:='-'; A[2,3]:='-'; A[2,4]:='-'; A[2,5]:='-'; A[2,6]:='-';
 A[2,7]:='*'; A[2,8]:='*'; A[2,9]:='-'; A[2,10]:='&'; A[2,11]:='&'; A[2,12]:='&';

 A[3,1]:='*'; A[3,2]:='#'; A[3,3]:='-'; A[3,4]:='-'; A[3,5]:='-'; A[3,6]:='-';
 A[3,7]:='-'; A[3,8]:='-'; A[3,9]:='-'; A[3,10]:='&'; A[3,11]:='&'; A[3,12]:='&';

 A[4,1]:='-'; A[4,2]:='-'; A[4,3]:='-'; A[4,4]:='-'; A[4,5]:='&'; A[4,6]:='-';
 A[4,7]:='&'; A[4,8]:='-'; A[4,9]:='-'; A[4,10]:='-'; A[4,11]:='+'; A[4,12]:='*';

 A[5,1]:='-'; A[5,2]:='-'; A[5,3]:='-'; A[5,4]:='-'; A[5,5]:='&'; A[5,6]:='#';
 A[5,7]:='&'; A[5,8]:='-'; A[5,9]:='-'; A[5,10]:='-'; A[5,11]:='-'; A[5,12]:='-';

 A[6,1]:='-'; A[6,2]:='-'; A[6,3]:='-'; A[6,4]:='-'; A[6,5]:='&'; A[6,6]:='&';
 A[6,7]:='&'; A[6,8]:='-'; A[6,9]:='-'; A[6,10]:='-'; A[6,11]:='#'; A[6,12]:='&';
end;

{��楤�� ������� ��砫쭮�� ���ﭨ� - 2}
procedure nach_2(var A:matr);
{ - ��� ��譨� ��ࠬ��஢}
begin
 A[1,1]:='0'; A[1,2]:='+'; A[1,3]:='-'; A[1,4]:='-'; A[1,5]:='-'; A[1,6]:='-';
 A[1,7]:='-'; A[1,8]:='-'; A[1,9]:='-'; A[1,10]:='-'; A[1,11]:='+'; A[1,12]:='0';

 A[2,1]:='-'; A[2,2]:='0'; A[2,3]:='+'; A[2,4]:='-'; A[2,5]:='-'; A[2,6]:='-';
 A[2,7]:='-'; A[2,8]:='-'; A[2,9]:='-'; A[2,10]:='+'; A[2,11]:='0'; A[2,12]:='-';

 A[3,1]:='-'; A[3,2]:='-'; A[3,3]:='0'; A[3,4]:='+'; A[3,5]:='-'; A[3,6]:='-';
 A[3,7]:='-'; A[3,8]:='-'; A[3,9]:='+'; A[3,10]:='0'; A[3,11]:='-'; A[3,12]:='-';

 A[4,1]:='-'; A[4,2]:='-'; A[4,3]:='-'; A[4,4]:='0'; A[4,5]:='+'; A[4,6]:='-';
 A[4,7]:='-'; A[4,8]:='+'; A[4,9]:='0'; A[4,10]:='-'; A[4,11]:='-'; A[4,12]:='-';

 A[5,1]:='-'; A[5,2]:='-'; A[5,3]:='-'; A[5,4]:='-'; A[5,5]:='0'; A[5,6]:='+';
 A[5,7]:='+'; A[5,8]:='0'; A[5,9]:='-'; A[5,10]:='-'; A[5,11]:='-'; A[5,12]:='-';

 A[6,1]:='+'; A[6,2]:='+'; A[6,3]:='+'; A[6,4]:='+'; A[6,5]:='+'; A[6,6]:='0';
 A[6,7]:='0'; A[6,8]:='+'; A[6,9]:='+'; A[6,10]:='+'; A[6,11]:='+'; A[6,12]:='+';
end;

{��楤�� ������� ��砫쭮�� ���ﭨ� - 3}
procedure nach_3(var A:matr);
{ - ��� ��譨� ��ࠬ��஢}
var i,j:integer;
begin
 for i:=1 to k do
  begin
   write('������ ',i,'-� ��ப� (12 ᨬ����� ��� �஡����): ');
   for j:=1 to l do
    read(A[i,j]);
   readln;
  end;
end;

begin
 writeln('�롥�� ��砫쭮� ���ﭨ�:');
 writeln('1 - 0+-++----&&&        2 - 0+--------+0');
 writeln('    ------**-&&&            -0+------+0-');
 writeln('    *#-------&&&            --0+----+0--');
 writeln('    ----&-&---+*            ---0+--+0---');
 writeln('    ----&#&-----            ----0++0----');
 writeln('    ----&&&---#&            +++++00+++++');
 writeln('3 - ������ ������');
 write('>');
 readln(x);
 case x of
 1: nach_1(A);
 2: nach_2(A);
 3: nach_3(A);
 end;
 print(A,k,l);
 main_part(A,k,l);
end;

{����� ०��}
procedure common(var A:matr);
{ - ��� ��譨� ��ࠬ��஢}
var x:integer;
begin
 pysto(A);
 write('������ ��砫쭮� ������⢮ �ᮡ�� (�� ����� 250): ');
  readln(x);
 dob(A,x,'+','-');
 print(A,n,m);

 write('������ ��砫쭮� ������⢮ ��� (�� ����� 250): ');
  readln(x);
 dob(A,x,'0','-');
 print(A,n,m);
 main_part(A,n,m);
end;

begin
 randomize;
 writeln('*************************��� �ਢ������ ��� "�����"*************************');
 writeln;
 writeln('- - ����� ���⪠');
 writeln('0 - ��⥭��');
 writeln('+ - �ࠢ�來��');
 writeln('* - �魨�');
 writeln('# - ᢥ��ᮡ�');
 writeln('& - ��ࠦ����� �ᮡ� (�����)');
 writeln('�ணࠬ�� ࠡ�⠥� � ���� ०����: �⫠��筮� � ���筮�.');
 writeln('� �⫠��筮� ०��� �࠭� �� ����⭮��. ��ப ����� �����');
 writeln(' ��砫쭮� ���ﭨ� ��⥬� �� �।�������� ��� ������ ������.');
 writeln('�����, ��� �㦭� �������� ��� ���� ����⢮, �� ��ப� �ॡ����');
 writeln(' ����� ����� ��ப� � �⮫�� �������, ����� ����室��� ��������.');
 writeln('� ���筮� ०��� ��⥬� ����砫쭮 ��������� ����묨 ���⪠��,');
 writeln(' � ��砫쭮� ������⢮ ��⥭�� � �ࠢ�來�� �������� ��ப��.');
 writeln('����� ��⥬� ���������� ��砩�� ��ࠧ��.');
 writeln('� ���⮩ ���⪥ � ����⭮���� 5% ����� ������ ��⥭��');
 writeln(' � � ⠪�� �� ����⭮���� �ࠢ�來��.');
 write('������ Enter');
 readln;
 writeln;

 writeln('��騥 �ࠢ���.');
 writeln('�᫨ �冷� � ��⥭��� ���� �ࠢ�來��, � �ࠢ�來��');
 writeln(' �c� ��⥭��, � �� ���� ��⥭�� ஦������ ��㣮� �ࠢ�來��.');
 writeln('�᫨ �冷� � �ࠢ�來� ���� �魨�, � �魨� ��� �ࠢ�來��,');
 writeln(' � �� ���� �ࠢ�來��� ஦������ �� ���� �魨�.');
 writeln('�᫨ �冷� � �魨��� ���� ᢥ��ᮡ�, � ��� ��� �魨��,');
 writeln(' � �� ��� ���� ஦������ ��㣠� ᢥ��ᮡ�.');
 writeln('�᫨ �冷� � �ࠢ�來� ��� �� ��⥭��, �� �魨���,');
 writeln(' � ��� �⠭������ �魨���.');
 writeln('�������筮, �᫨ �冷� � �魨��� ��� �� �ࠢ�來��, �� ᢥ��ᮡ��,');
 writeln(' � �魨� �⠭������ ᢥ��ᮡ��.');
 writeln('�� ��ᠥ��� ᢥ��ᮡ��, � �� ���� �� ���, � ��� �� � ���� ��');
 writeln(' �ॢ������, �� � ��� � ᢥ��ᮡ�. ������, �᫨ ��ப');
 writeln(' ��筥� ��������, � �।� ��� ������� ��ࠧ�� �ᮡ�-�����,');
 writeln(' ��祬, �᫨ ����� �������� ���⮪ ����� ᢥ��ᮡ� ������');
 writeln(' �����, � ��� �� ������ � ᥡ� ��������, ���� ���� �ꥤ��� ��.');
 writeln('���� ����⢮-�����, �᫨ �冷� � ��� ����� �������� ⠪�� ��');
 writeln(' �����-�����, 㬨ࠥ�.');
 writeln('�� ��㣨� �����, �஬� ᢥ��ᮡ��, ����� ����� �� ॠ������.');
 write('������ Enter');
 readln;
 writeln;

 writeln('�� ���� 室 � �ᮡ�� ����� �ந���� ⮫쪮 ���� ���������.');
 writeln('����� ��ப ����� �ࠢ� �������� �� ������⢮ ��⥭��,');
 writeln(' �ࠢ�來��, �魨���, ᢥ��ᮡ��, ����� ��������,');
 writeln(' ��⠭����� ��, ���ந�� ��⥮��� �����');
 writeln(' (�롨����� �ந������ ��ࠧ�� �����஥ ������⢮ ���⮪, � ��,');
 writeln(' �� � ���, � ⠪�� � ����� �������� ���⪠� 㬨ࠥ�');
 writeln(' - �㤠 �������� ��⥮��).');
 writeln('�⮡� ��⠭����� ����, ���짮��⥫� ������ ����� ��ਠ��');
 writeln(' "���ந�� ����� ᢥ�".');
 write('������ Enter');
 readln;
 clean;
 writeln('1 - �⫠���� ०��');
 writeln('2 - ����� ०��');
 write('>');
 readln(y);
 clean;
 if y=1
    then begin
          otlad(A);
          writeln('����� ᢥ� ����㯨�.');
          clean;
         end
    else begin
          common(A);
          writeln('����� ᢥ� ����㯨�.');
          clean;
         end;
end.