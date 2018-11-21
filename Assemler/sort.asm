; Баранчук Дима 114
; "Сортировка бинарными вставками по возрастанию"

	INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DW 150 DUP (?)
STACK	ENDS

DATA SEGMENT 

DATA ENDS

CODE    SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE


BEGIN:
 IRP C,<INC A,M>
  C
 ENDM
 
CODE	ENDS
	 END BEGIN
	 END BEGIN