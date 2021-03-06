{Author: Galkov A.V
  Group: 115
   �⠯: 2
   Task: 1)���� �窨 ���祭�� �㭪権 f(x)=5/x � g(x)=2.5*x-9.5
           �������஢���� ��⮤
         2)���᫥��� ��⥣ࠫ� �� �㭪樨 f(x)=5/x
           �������ୠ� ��㫠: ���㫠 ����ᮭ�}
program prog(input,output);
var     a,b,eps1,eps2,int:real;
        k:integer;

{�㭪�� ��� ���᫥��� ���祭�� h(x)=f(x)-g(x) � �窥}
function h(x:real):real;
begin
 h:=2.5*x-9.5-5/x;
end;

{�㭪�� ��� ���᫥��� ���祭�� ��ࢮ� �ந�������}
function f1(x:real):real;
begin
 f1:=(2.5*sqr(x)+5)/sqr(x);
end;

{��楤�� ��� ��宦����� �窨 ����祭�� �㭪権 � ��ࢮ� ��砥}
procedure root1(var a,b,eps1:real);
var i:integer;
    c1,c2:real;
begin
 i:=0;
 repeat
       {��宦����� ����� �࠭���� �祪}
       c1:=(a*h(b)-b*h(a))/(h(b)-h(a));
       c2:=b-h(b)/f1(b);

       a:=c1;
       b:=c2;
       {���稪 ���権}
       i:=i+1;
       writeln('����� ���樨: ',i,', a=',a:10:3,', b=',b:10:3);
 until abs(b-a)<eps1;
 writeln;
 writeln('����� ���樨: ',i,', �ਡ����⥫쭮� ���祭�� ����:',(a+b)/2:10:3);
end;

{��楤�� ��� ��宦����� �窨 ����祭�� �㭪権 �� ��஬ ��砥}
procedure root2(var a,b,eps1:real);
var i:integer;
    c1,c2:real;
begin
 i:=0;
 repeat
       {��宦����� ����� �࠭���� �祪}
       c1:=(a*h(b)-b*h(a))/(h(b)-h(a));
       c2:=a-h(a)/f1(a);

       a:=c2;
       b:=c1;
       {���稪 ���権}
       i:=i+1;
       writeln('����� ���樨: ',i,', a=',a:10:3,', b=',b:10:3);
 until abs(b-a)<eps1;
 writeln;
 writeln('����� ���樨: ',i,', �ਡ����⥫쭮� ���祭�� ����:',(a+b)/2:10:3);
end;


{��楤�� ��� �஢�ન ����}
procedure prov(var a,b,eps1:real);
begin
 if ( h(a)<0 ) and
    ( h( (a+b)/2 )<( h(a)+h(b) ) / 2) or
    ( h(a)<0 ) and
    ( h( (a+b)/2 )<( h(a)+h(b) ) / 2)
                                        then
                                            root1(a,b,eps1)
                                        else
                                            root2(a,b,eps1);
end;

{�㭪�� ��� ���᫥��� ���祭�� f(x)=5/x � �窥}
function f(x:real):real;
begin
 f:=5/x;
end;

{�㭪�� ��� ���᫥��� ��⥣ࠫ�}
function integral(var k:integer; var a,b,eps2:real):real;
var      n,i:integer;
         intn,int2n,s,p:real;
begin
 n:=1;                       { - ��砫쭮� ������⢮ ࠧ������}
 int2n:=(f(a)+f(b))*(b-a)/3; { - ��砫쭮� ���祭�� ��⥣ࠫ�}
 s:=0;                       { - ��६����� ��� ������ �஬������� �㬬}
 p:=(b-a)/n;     { - ��砫쭠� ����� ��१���, �� ����� ࠧ�������� [a,b]}
 repeat
  intn:=int2n;   { ��ᢠ����� �।��饬� ���祭�� ��⥣ࠫ� ����� �筮�}
  int2n:=int2n*3/p - 2*s;    { �����塞 �����樥��� ��� ������}
  s:=0;                      {    ����� �筮�� ���祭�� �⥣ࠫ�}
  n:=n*2;                    { 㢥��稢��� �᫮ ࠧ������}
  p:=(b-a)/n;                { ����塞 ����� ����� ��१���}
  {��⠥� �㬬� �������⥫��� ���祭�� �㭪樨}
  for i:=1 to n-1 do
                    begin
                     if i mod 2 =1 then s:=s + f(a+i*p);
                    end;

  int2n:=(int2n + 4*s)*p/3;  {����塞 ����� �筮� ���祭�� ��⥣ࠫ�}
  k:=k+1;                    {���稪 ���権}
  write('����� ���樨: ',k);
  writeln(', �ਡ����⥫쭮� ���祭�� ��⥣ࠫ�:',int2n:13:3);
 until 1/15*abs(Intn-Int2n)<eps2;
 integral:=int2n;            {�����⥫쭮� ���祭�� ��⥣ࠫ�}
end;

begin
   writeln('���� �窨 ���祭�� �㭪権 f(x)=5/x � g(x)=2.5*x-9.5');
     write('������ �筮��� ���᫥���: ');
        readln(eps1);
   writeln('������ �஬���⮪ ����⮭���� �㭪樨, �� ���஬ ������ ��୨');
     write('��砫� � ����� �१ �஡�� (�� ࠢ�� ��� � ������ �����): ');
        readln(a,b);
 if h(a)*h(b)>0
               then
                   writeln('��୥� ���')
               else
                   prov(a,b,eps1);
   writeln;
   writeln('���᫥��� ��⥣ࠫ� �㭪樨 f(x)=5/x');
     write('������ �筮��� ���᫥���: ');
        readln(eps2);
   writeln('������ �஬���⮪ ��� ���᫥��� ��⥣ࠫ�');
     write('��砫� � ����� �१ �஡�� (�� ࠢ�� ��� � ������ �����): ');
        readln(a,b);
 k:=0;
 int:=integral(k,a,b,eps2);
   writeln;
   writeln('�����⥫�� १����');
   write('����� ���樨: ',k);
   writeln(', �ਡ����⥫쭮� ���祭�� ��⥣ࠫ�:',int:13:3);
   writeln('������ Enter');
        readln
end.