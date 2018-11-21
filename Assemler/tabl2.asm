	INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DB 128 DUP (?)
STACK	ENDS
DATA SEGMENT 
DATA ENDS
CODE	SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
BEGIN: 
 inint SI
 mov CX,4
 mov BX,4
OUT:  mov DX,1
     mov BX,CX
     mov CX,SI
  IN:outint DX,3
     inc DX
	 loop IN
     newline
     mov CX,BX
     loop OUT
     finish	 
	 
CODE	ENDS
	 END BEGIN
	 END BEGIN