INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DB 128 DUP (?)
STACK	ENDS
DATA SEGMENT
  a   dw 3 dup (?)  
  s1 db 'Введите массив - ','$'
  s2 db 'Введенный массив - ','$'
  s3 db 'Сортед массив    - ','$'
DATA	ENDS
CODE	SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
BEGIN:  MOV AX, DATA
	MOV DS,AX
	lea DX,S1; Вводим массив - все ясно как день
	outstr
    mov CX,10
	mov BX,0
In: inint a[BX]
    add BX,2
	loop In
	mov BX,0
	newline
	mov CX,5; Пропускаем пару строк - по-моему очень изящный жест
clr:newline
    loop clr	
	mov CX,10; Выводим изначальный массив - тоже все понятно
	lea DX,S2
	outstr
Out:outint a[BX],6
    add BX,2
    loop Out	
	newline
	mov BX,0; В данном случае BX - номер элемента, который мы отправляем на его позицию. Т.к. ВХ меняется внутри цикла, то "внешний" ВХ мы храним в DI.
	mov DI,0
S:  mov AX,a[BX]
    mov DX,a[BX+2]
	cmp AX,DX; Сравниваем два соседних элемента - если они отсортированы, то увеличиваем "внешний" ВХ
	JG P
	mov a[BX],DX; Если же они не отсортированы, то мы меняем эти элементы местами, уменьшаем ВХ и повторяем процедуру до тех пор, пока: первый вариант - найдем место элемента,
	mov a[BX+2],AX; то есть элемент справа от него будет меньше, второй вариант - слева не останется "соседей". В обоих случаях в итоге мы идем в Р.
	sub BX,2
	cmp BX,-2
	JE P
	JMP S
P:  add DI,2; Увеличиваем "внешний" ВХ
    mov BX,DI
    cmp DI,18; Проверяем, а не отсортировали ли мы уже все жлементы
    JNE S	
	newline
Fin:mov CX,10; Собственно, все. Дальше выводим отсортированный массив.
    mov BX,0	
	lea DX,S3
	outstr
Ot:outint a[BX],6
    add BX,2
    loop Ot
	newline
       FINISH; Спасибо за просмотр, на этом программа, увы, заканчивается.
CODE	ENDS
        END BEGIN
