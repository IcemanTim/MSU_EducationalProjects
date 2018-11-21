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
{Пример 3.5. Описать процедуру вывода дерева, выделяющую каждый уро-
вень h с помощью соответствующего отступа.}
procedure PrintTree(T : Tree; h : integer );
 var i : integer;
begin
   if T <> nil then
   begin
        PrintTree (T^.R, h+1);
        for i:=1 to h do write(‘ ‘);
        writeln( T^.inf );
        PrintTree (T^.L, h+1);
   end
end;     { PrintTree }
{**********************************************}
{Описать процедуру MaxEl , определяющую наибольший
элемент непустого дерева T.
     Алгоритм MaxEl использует префиксный обход дерева: наибольший эле-
мент находится или в узле, или в его левом поддереве, или в его правом
поддереве.}
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
{Пример 3.7. Описать рекурсивную процедуру Leaf подсчета количества k
листьев дерева.}
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
{Количество List листьев дерева Root можно определить, обратившись к
процедуре Leaf : List:=0; Leaf(Root,List);}
{Если описать реализацию в виде функции, то не придется заботиться о
присваивании нуля параметру–результату перед ее вызовом.}
function fLeaf ( T: Tree ) : integer;
begin
  if T=nil then fLeaf:=0
  else if (T^.L=nil) and (T^.R=nil) then
         fLeaf:=1
       else fLeaf:= fLeaf(T^.L)+fLeaf(T^.R)
end     {fLeaf};
{***************************************************************************}
{Пример 3.8. Описать рекурсивную функцию Double, которая проверяет,
есть ли в дереве T хотя бы два одинаковых элемента.
Один из вариантов проверки состоит в использовании функции Count подсчета 
числа вхождений заданного элемента El в дерево T. Функция Double по-
очередно проверяет число вхождений текущего значения T^.inf в дерево: если
число вхождений больше 1, то результат проверки – истина, если нет, то такая
ситуация может возникнуть в левом поддереве или в правом поддереве.}
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
var S:set of char; {элементы из просмотренных вершин}
function Same1(T: tree): boolean;
begin
{обход дерева до первого совпадения}
if T=nil the Same1:=false else {проверка корня :}
if T^.elem in S then Same1:=true else
begin {элемент из корня ранее не встречался}
S:=S+[T^.elem]; {добавить новый элемент в S}
if Same1(T^.left) then Same1:=true
else Same1:= Same1(T^.right)
end
end;
begin S:=[];
Same:=Same1(T)
end;
{******************************************************************************}
type TE= ...; {тип элемента дерева}
tree =^node;
node = record elem: TE; left, right: tree end;
{*****************************************************************************}
{Пример 3.9. Описать функцию Equal проверки на равенство двух двоич-
ных деревьев одинаковой структуры.}
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
{Пример 3.10.   Описать процедуру   Copy,   которая создает копию T2
дерева T1.}
procedure Copy(T1 : Tree; var T2 : Tree);
begin
    if T1 = nil then T2:=nil
    else begin
         new(T2); T2^.inf:=T1^.inf;{копия корня}
         Copy(T1^.L,T2^.L);{копия левого и правого поддеревьев}
         Copy(T1^.R,T2^.R);
       end
end;     { Copy }

{****************************************************************************}
{Написать рекурсивную функцию Height(T) для нахождения высоты дерева
T (считать, что высота непустого дерева – это число вершин на самом
длинном из путей от корня дерева до листьев, высота пустого дерева –0)}

function Height(T:tree): integer;
var hL,hR:integer;{высоты левого и правого поддеревьев}
begin
if T=nil then Height:=0 else {общий случай:}
begin 
 hL:=Height(T^.left);
 hR:=Height(T^.right);
if hL>hR then Height:=hL+1 else
Height:=hR+1
end
end;
{****************************************************************************}
{Написать рекурсивную функцию Level(T,n) для подсчёта числа вершин на n-м(n>=1)
уровне дерева T (считать, что 1-ый уровень соответствует корню дерева, а ур
овень любой другой вершины – на единицу больше уровня её родительской вершины)}
function Level(T:tree; n: integer): integer; {n>=1}
begin
if T=nil then Level:=0 else {непусто едерево:}
if n=1 then Level:=1 else {общий случай:}
Level:= Level(T^.left,n-1)+ Level(T^.right,n-1)
end;
{**************************************************************************}
{Описать рекурсивную функцию IsPos(T), проверяющую,есть ли в дереве Т 
хотя бы один путь (от корня до листа включительно),во всех вершинах
которого находятся только положительные элементы (TE=real)}
function IsPos(T:tree):boolean;
begin
if T=nil then IsPos:=false
else {проверка содержимого корневой вершины:}
if T^.elem<=0 then IsPos:=false {пути нет}
else {корень положителен :}
if (T^.left=nil)and(T^.right=nil) then
IsPos:=true{это лист, т.е. путь найден}
else{поиск пути в левом поддереве:}
if IsPos(T^.left) then IsPos:=true
else{поиск пути в правом поддереве:}
IsPos:=IsPos(T^.right)
end;
{*****************************************************************************}
{Написать рекурсивную процедуру Leaves(T), которая удаляет
(с освобождением памяти) все листья дерева Т}
procedure Leaves(var T:tree);
begin
{действия производить только с непустым деревом!}
if T<>nil then {дерево непустое, в нём одна вершина?}
if (T^.left=nil)and(T^.right=nil)then {да,одна}
begin
{удаление единственной вершины, т.е. листа:}
dispose(T);{высвобождение памяти,занятой под лист}
T:=nil{после удаления листа дерево стало пустым}
end
else{в дереве имеется более одной вершины}
begin{рекурсивная обработка поддеревьев}
Leaves(T^.left);
Leaves(T^.right)
end
end;
{*****************************************************************************}
{