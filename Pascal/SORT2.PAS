{Author: Galkov A.V
 Group: 115
 �������: ������ ���஢��, ��४��ᨢ�� ��⮤;
 �⠯: 2}
program prog(input,output);
const n=100; m=10;
type  FF=File of Char;
      stroka=array [1..m] of char;
      mass=array [1..n] of Stroka;
var F:FF;
    A:mass;
    k,srav,peres:integer;
{*************************************************************************
 F - 䠩�, �� ���ண� ���뢠���� ��᫥����⥫쭮���;
 A - ��㬥�� ���ᨢ, � ���஬ �࠭���� ��᫥����⥫쭮��� �� ᫮�,
     ������ ᫮�� � �⤥�쭮� ��ப�:
 k - �᫮ ᫮� � ��᫥����⥫쭮��;
 srav - �᫮ �ࠢ�����;
 peres - �᫮ ����⠭����;
*************************************************************************}

{��楤�� ZapF �������� 䠩� ����묨 � ����������}
procedure ZapF(var F:FF);
var n,i,l:integer;
    a:char;
begin
 rewrite(F);
 write ('������ ������⢮ ᫮�=') ;
 readln(n);
 l:=1;
 writeln('������ ',n,' ᫮� �� ������ ���᪨� �㪢 �१ �஡��, �� ���� �窠');
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

{��楤�� Read_File ���뢠�� ����� �� 䠩��}
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

{��楤�� zap_Mass �������� ���ᨢ, � ����� ��⮬ ����
 �����뢠���� �������� ��᫥����⥫쭮��, ᨬ����� '-'}
procedure zap_Mass(var A:mass);
var i,j:integer;
begin
 for i:=1 to n do
  for j:=1 to m do
   A[i,j]:='-'
end;

{��楤�� Write_Mass �뢮��� ⥪�饥 ���ﭨ� ���ᨢ�}
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

{��楤�� zam ����� ���⠬� ��� ��ப�}
procedure zam(var st1,st2:stroka);
var x:stroka;
begin
 x:=st1;
 st1:=st2;
 st2:=x;
 peres:=peres+1;
end;

{************************************************************************
�᭮���� ��楤�� q_sort �����⢫�� ������� ���஢�� ��४��ᨢ��
��⮤��.
� ᢮�� ࠡ�� �ᯮ���� ��楤���:
1) zam(var st1,st2:stroka) - ����� ���⠬� ��� ��ப� st1 � st2;
2) sort1(var A:mass; i,j:integer; var m:integer) - ��뢠����,
   �᫨ ������⢮ ����㥬�� ��ப ����� ���; 䨪���� �।���
   ��ப� �।� ��ப �� i �� j ���ᨢ� A � �⠢�� �� �� ᢮� ����;
   �����頥� �������� ���ᨢ � ���� ������ m 䨪�஢����� ��ப�;
3) sort2(var A:Mass; ot1,ot2:integer) - ��뢠����, �᫨ ������⢮
   ����㥬�� ��ப ����� ��� ࠢ�� �६; ������ ��ப� �� i
   �� j ��⥬ ���筮�� �� �ࠢ�����;
************************************************************************}

procedure q_sort(var A:mass; k:integer);
var stek:array [1..n] of integer;
    sp,ot,m,i:integer;
{************************************************************************
  A - ����㥬� ���ᨢ;
  k - �᫮ ������⮢ � ���ᨢ�;
  stek - ���ᨢ, � ���஬ �����뢠���� ��砫� � ����� ��१���, �����
         ����室��� �����஢��� � ������� ��楤��� sort1;
  sp - �᫮ ������⮢ � stek;
  ot,m,i - �ᯮ����⥫�� ��६����;
************************************************************************}

procedure sort1(var A:mass; i,j:integer; var m:integer);
var q:stroka;             { - �ᯮ����⥫�� ���ᨢ-��ப�}
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
������ ࠡ��� ��楤��� q_sort:
1) ������ ��砫쭮� ���ﭨ� �⥪�:
2) � 横�� � �᫮����: ���� �⥪ �����⮩:
2.1) ��६ �� �⥪� ��� ���祭��: ��砫� � ����� ����㥬��� ��१�� -
     � ����㥬 ���.
     ����砥� ��� ����� ��१�� [stek[sp-1],m) � (m,stek[sp]],
     ��� m - ������ ��ப�, 䨪�஢����� �� ���஢��;
2.2) � ������� �ᯮ����⥫쭮� ��६����� ��࠭塞 ����� ��१��, �⮡�
     �� ���祭�� �� �뫮 ����ﭮ � ���쭥��� �८�ࠧ�������;
2.3) �஢��塞, ����� ��⮤�� �㤥� ���஢��� ��१��, ����祭��
     �� 蠣� 2.1. �᫨ ����� ��१�� ����� ��� ࠢ�� �६, � ����㥬,
     �ᯮ���� ��楤��� sort2, ���� �����뢠�� � �⥪: ��� ��१��
     �㤥� �����஢�� �� ᫥���饬 蠣� 横��.
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
 assign(F,'input.int');      { - �ਢ�뢠�� 䠩� � ��६�����}
 zapf(F);                    { - �����뢠�� � 䠩� ��᫥����⥫쭮���}
 zap_Mass(A);                { - ������塞 ���ᨢ ᨬ������ '-'}
 Read_File(F,A,k);           { - �⠥� � 䠩�� ��᫥�����⥫쭮���
                                 � �����뢠�� �� � ���ᨢ}
 Write_Mass(A,k);            { - �뢮��� ��砫쭮� ���ﭨ� ���ᨢ�}
 srav:=0;                    { - ��砫쭮� �᫮ �ࠢ�����}
 peres:=0;                   { - ��砫쭮� �᫮ ����⠭����}
 q_sort(A,k);                { - ����㥬 ���ᨢ}

{�뢮��� �����⥫�� १�����}
 writeln('�����⥫�� ��� ��᫥����⥫쭮��: ');
 Write_Mass(A,k);
 writeln('��᫮ ����⠭����: ',peres);
 writeln('��᫮ �ࠢ�����: ',srav)
End.