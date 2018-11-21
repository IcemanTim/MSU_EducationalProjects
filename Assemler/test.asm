include io1.asm ;подключение операций ввода-вывода

stack segment stack
	dw 128 dup (?)
stack ends
AB SEGMENT 
DW 10 DUP(?)
AB ENDS
data segment
X DB 10 DUP ('1'),10 DUP ('2')
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
DOUBLE PROC
 PUSH BP 
 MOV BP,SP
 PUSH BX
 PUSH CX
 MOV CX,[BP+6]
 MOV BX,[BP+4]
RPT: 
 SHR BYTE PTR[BX],1
 JNC A
 RCL BYTE PTR[BX],1
A:
 RCL BYTE PTR[BX],1
 INC BX
LOOP RPT
 POP CX
 POP BX
 POP BP
 RET 4
DOUBLE ENDP 

MCWD MACRO 
LOCAL PL
 XOR DX,DX
 SHL AX,1
 JNC PL
 DEC DX
PL:
 RCR AX,1
ENDM
start:
	mov ax,DATA
	mov ds,ax
    MOV BP,20
    OUTCH X[BP-1]
    finish
code ends
    end start 
	end start 