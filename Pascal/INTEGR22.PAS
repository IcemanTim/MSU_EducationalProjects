program integral2(input,output);
{������ �������� 114��}
{�ணࠬ�� ���᪠ ��୥� �㭪樨 F1(x)=x*x*x-2*x*x-19*x+20 �������஢���� ��⮤��
� ���᫥��� ��।�������� ��⥣ࠫ� �㭪樨 F11(x)=3*x*x-4*x-19 �� ����� ���� �࠯�権.
�㭪�� F1(x)=x*x*x-2*x*x-19*x+20 ����� ࠧ������� F1(x)=(x-1)(x-5)(x+4).
�㭪�� F11(x) - �ந������� �㭪樨 F1(x)}
type
    Fun=function(x:real):real;
var
  I,a,b,eps1,eps2,x:real;
  kr,ki:integer;
{$F+}
function f1(x:real):real;
begin
     f1:=x*x*x-2*x*x-19*x+20;
end;
function f11(x:real):real;
begin
     f11:=3*x*x-4*x-19;
end;
{******* ��楤�� ��宦����� ���� �㭪樨 F1(x) �������஢���� ��⮤�� *******}
procedure root(f1:Fun; a,b,eps1:real; var x:real; var k:integer);
            {��६����� k �� ���� ᤥ���� �����쭮�, � ���祭�� k � ���� �뢮��� �᭮���� �ணࠬ��, � �� ᠬ� ��楤��}
var
   c1,c2:real;  {�1 ��� ��⮤� ��, �2 ��� ��⮤� ���⥫���}
begin
     k:=0;
     while abs(a-b)>eps1 do
     begin
           c1:=(a*f1(b)-b*f1(a))/(f1(b)-f1(a));
           if ((f1(a)<0) and (f1((a+b)/2)<(f1(a)+f1(b))/2) or ((f1(a)>0) and (f1((a+b)/2)>(f1(a)+f1(b))/2))) then
              begin
                   a:=c1;
                   c2:=b-f1(b)/f11(b);
                   b:=c2;
                   k:=k+1;
              end
           else
               begin
                    b:=c1;
                    c2:=a-f1(a)/f11(a);
                    a:=c2;
                    k:=k+1;
               end;
     end;
     x:=a;
end;
function integral(f11:Fun; a,b,eps2:real; var  k:integer):real;
{******* ���᫥��� ��⥣ࠫ� � ������� ���� �࠯�権 �� ��१�� [a,b] � �筮���� eps2*******}
{******* ��筮��� ��⠥��� ���⨣��⮩, ����� �� ��।��� 蠣� ����稭� p*abs(I1-I2) �������� ����� eps2*******}
const
     p=1/3;
var
   h,I1,I2:real;
   n,j:integer;
begin
     n:=10;
     h:=(b-a)/n;
     I1:=h*0.5*(f11(a)+f11(b));
     for j:=1 to n-1 do
     I1:=I1+h*f11(a+j*h);
     I2:=I1;
     k:=0;
     repeat {�⮡� �� ������뢠�� ���祭�� Fi, ���᫥��� ࠭�� ��� �㬬� In, � ࠧ����� ���� �� ���
             � ������ ⮫쪮 � ���祭��, ������ "�� 墠⠥�", � ����祭�� ࠭�� ���� ������� � �ਡ�����}
           I1:=I2;
           I2:=h*0.5*f11(a+h*0.5);
           for j:=1 to n-1 do
               I2:=I2+h*0.5*f11(a+h*0.5+j*h);
           I2:=I2+I1*0.5;
           h:=h*0.5;
           n:=n*2;
           k:=k+1;
     until (p*abs(I1-I2))<eps2;
     integral:=I2;
end;
(************* �᭮���� ���� �ணࠬ�� ***************)
begin
     writeln('������ ��१�� ��� ������ ����');
     read(a,b);
     writeln('������ �筮��� ��� ������ ����');
     readln(eps1);
     root(f1,a,b,eps1,x,kr);
     Writeln('��᫮ ���権 =',kr:3,' ��७� �ࠢ����� = ',x:7:3);
     readln;
     writeln('������ ��१�� ��� ������ ��⥣ࠫ� �㭪樨');
     read(a,b);
     writeln('������ �筮��� ��� ������ ��⥣ࠫ� �㭪樨');
     readln(eps2);
     I:=integral(f11,a,b,eps2,ki);
     writeln('��᫮ ���権 =', ki:3,' ��⥣ࠫ = ',I:7:3);
end.













