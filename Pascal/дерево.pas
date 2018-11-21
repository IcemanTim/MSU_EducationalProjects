{opredelayet chislo vhozhdeniy elementa E v derevo T}
function count(T:derevo; E: TED):integer;
var k:integer;
begin 
 if T=nil then count:=0
 else begin
   if T^.elem=E then k:=1 else k:=0;
   count:=k+count(T^.lv,E)+count(T^.pr,E);
 end;
end;
{***********************************************}
{������ 3.5. ������� ��������� ������ ������, ���������� ������ ���-
���� h � ������� ���������������� �������.}
procedure PrintTree(T : Tree; h : integer );
 var i : integer;
begin
   if T <> nil then
   begin
        PrintTree (T^.R, h+1);
        for i:=1 to h do write(� �);
        writeln( T^.inf );
        PrintTree (T^.L, h+1);
   end
end;     { PrintTree }
{**********************************************}
{������� ��������� MaxEl , ������������ ����������
������� ��������� ������ T.
     �������� MaxEl ���������� ���������� ����� ������: ���������� ���-
���� ��������� ��� � ����, ��� � ��� ����� ���������, ��� � ��� ������
���������.}
procedure MaxEl(T : Tree; var max : integer);
var m : integer;
begin
  if T <> nil then
  begin
     max:=T^.inf;
     if T^.L <> nil then
        begin
          MaxEl(T^.L, m);
          if m > max then max:=m
        end;
        if T^.R <> nil then
         begin
             MaxEl(T^.R, m);
             if m > max then max:=m
         end
  end
end; { MaxEl }
{***************************************************************}
{������ 3.7. ������� ����������� ��������� Leaf �������� ���������� k
������� ������.}
procedure Leaf( T : Tree; var k : integer);
begin
      if T <> nil then
       if (T^.L=nil) and (T^.R=nil) then
         k:=k+1
       else
       begin
         Leaf(T^.L,k);
         Leaf(T^.R,k)
       end
end;     { Leaf }
{���������� List ������� ������ Root ����� ����������, ����������� �
��������� Leaf : List:=0; Leaf(Root,List);}
{���� ������� ���������� � ���� �������, �� �� �������� ���������� �
������������ ���� ������������������� ����� �� �������.}
function fLeaf ( T: Tree ) : integer;
begin
  if T=nil then fLeaf:=0
  else if (T^.L=nil) and (T^.R=nil) then
         fLeaf:=1
       else fLeaf:= fLeaf(T^.L)+fLeaf(T^.R)
end     {fLeaf};
{***************************************************************************}
{������ 3.8. ������� ����������� ������� Double, ������� ���������,
���� �� � ������ T ���� �� ��� ���������� ��������.
���� �� ��������� �������� ������� � ������������� ������� Count �������� 
����� ��������� ��������� �������� El � ������ T. ������� Double ��-
�������� ��������� ����� ��������� �������� �������� T^.inf � ������: ����
����� ��������� ������ 1, �� ��������� �������� � ������, ���� ���, �� �����
�������� ����� ���������� � ����� ��������� ��� � ������ ���������.}
function COUNT(T : Tree; El :integer ) : integer;
var k : integer;
begin
    if T=nil then       COUNT:=0
    else
     begin
        if T^.inf = El then k:=1 else k:=0;
        COUNT:=k+COUNT(T^.L,El)+COUNT(T^.R,El)
     end
end; { COUNT }

function Double(T : Tree) : boolean;
begin
    if T=nil then Double:=false
    else
     begin
        if COUNT(T,T^.inf) > 1 then Double:=true
        else
           Double:= Double(T^.L) or Double(T^.R)
     end
end; { Double }

function Same(T: tree): boolean;
var S:set of char; {�������� �� ������������� ������}
function Same1(T: tree): boolean;
begin
{����� ������ �� ������� ����������}
if T=nil the Same1:=false else {�������� ����� :}
if T^.elem in S then Same1:=true else
begin {������� �� ����� ����� �� ����������}
S:=S+[T^.elem]; {�������� ����� ������� � S}
if Same1(T^.left) then Same1:=true
else Same1:= Same1(T^.right)
end
end;
begin S:=[];
Same:=Same1(T)
end;
{******************************************************************************}
type TE= ...; {��� �������� ������}
tree =^node;
node = record elem: TE; left, right: tree end;
{*****************************************************************************}
{������ 3.9. ������� ������� Equal �������� �� ��������� ���� �����-
��� �������� ���������� ���������.}
function Equal(T1,T2 : Tree ) : boolean;
begin
    if T1=T2 then Equal:=true
    else
        if (T1 <> nil) and (T2 <> nil) then
             if T1^.inf = T2^.inf then
                Equal:=Equal(T1^.L,T2^.L) and
                       Equal(T1^.R,T2^.R)
             else Equal:=false
        else Equal:=false
end; { Equal }
{*****************************************************************************}
{������ 3.10.   ������� ���������   Copy,   ������� ������� ����� T2
������ T1.}
procedure Copy(T1 : Tree; var T2 : Tree);
begin
    if T1 = nil then T2:=nil
    else begin
         new(T2); T2^.inf:=T1^.inf;{����� �����}
         Copy(T1^.L,T2^.L);{����� ������ � ������� �����������}
         Copy(T1^.R,T2^.R);
       end
end;     { Copy }

{****************************************************************************}
{�������� ����������� ������� Height(T) ��� ���������� ������ ������
T (�������, ��� ������ ��������� ������ � ��� ����� ������ �� �����
������� �� ����� �� ����� ������ �� �������, ������ ������� ������ �0)}

function Height(T:tree): integer;
var hL,hR:integer;{������ ������ � ������� �����������}
begin
if T=nil then Height:=0 else {����� ������:}
begin 
 hL:=Height(T^.left);
 hR:=Height(T^.right);
if hL>hR then Height:=hL+1 else
Height:=hR+1
end
end;
{****************************************************************************}
{�������� ����������� ������� Level(T,n) ��� �������� ����� ������ �� n-�(n>=1)
������ ������ T (�������, ��� 1-�� ������� ������������� ����� ������, � ��
����� ����� ������ ������� � �� ������� ������ ������ � ������������ �������)}
function Level(T:tree; n: integer): integer; {n>=1}
begin
if T=nil then Level:=0 else {������� �������:}
if n=1 then Level:=1 else {����� ������:}
Level:= Level(T^.left,n-1)+ Level(T^.right,n-1)
end;
{**************************************************************************}
{������� ����������� ������� IsPos(T), �����������,���� �� � ������ � 
���� �� ���� ���� (�� ����� �� ����� ������������),�� ���� ��������
�������� ��������� ������ ������������� �������� (TE=real)}
function IsPos(T:tree):boolean;
begin
if T=nil then IsPos:=false
else {�������� ����������� �������� �������:}
if T^.elem<=0 then IsPos:=false {���� ���}
else {������ ����������� :}
if (T^.left=nil)and(T^.right=nil) then
IsPos:=true{��� ����, �.�. ���� ������}
else{����� ���� � ����� ���������:}
if IsPos(T^.left) then IsPos:=true
else{����� ���� � ������ ���������:}
IsPos:=IsPos(T^.right)
end;
{*****************************************************************************}
{�������� ����������� ��������� Leaves(T), ������� �������
(� ������������� ������) ��� ������ ������ �}
procedure Leaves(var T:tree);
begin
{�������� ����������� ������ � �������� �������!}
if T<>nil then {������ ��������, � �� ���� �������?}
if (T^.left=nil)and(T^.right=nil)then {��,����}
begin
{�������� ������������ �������, �.�. �����:}
dispose(T);{������������� ������,������� ��� ����}
T:=nil{����� �������� ����� ������ ����� ������}
end
else{� ������ ������� ����� ����� �������}
begin{����������� ��������� �����������}
Leaves(T^.left);
Leaves(T^.right)
end
end;
{*****************************************************************************}
{