	INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DB 128 DUP (?)
STACK	ENDS
DATA SEGMENT 
X DW 10 dup (?)
DATA ENDS
CODE	SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
BEGIN: 
 	mov ax,data
	mov ds,ax
	mov CX,0
	;Ввод
	mov SI,-2
 IN:outch'>'
    ADD SI,type(X)
	inc CX
	inint X[SI]
	cmp X[SI],0
	JNE IN
	;Вывод
	mov SI,0
OUT:outint X[SI],3
	ADD SI,type(X)
	loop OUT
	newline
	finish
CODE	ENDS
	 END BEGIN
	 END BEGIN