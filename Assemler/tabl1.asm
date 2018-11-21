	INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DB 128 DUP (?)
STACK	ENDS
DATA SEGMENT 
DATA ENDS
CODE	SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
BEGIN: 
 mov DX,1
 inint CX
 mov BX,4
OUT: mov SI,CX
     mov CX,BX
  IN:outint DX,3
     loop IN
     inc DX
     newline
     mov CX,SI
     loop OUT
     finish	 
	 
CODE	ENDS
	 END BEGIN
	 END BEGIN