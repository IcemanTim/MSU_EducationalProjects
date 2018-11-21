include io1.asm ;подключение операций ввода-вывода
stack segment stack
	dw 128 dup (?)
stack ends
data segment
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
start:
	 mov ax,data
	 mov ds,ax
	 MOV CX,9
ttt: OUTCH '*'
	 OUTINT CX
	 newline
	 MOV SI,CX
	 MOV AX,CX
	 MOV CX,9
	 MOV BL,'1'
sss: OUTINT SI,2
	 OUTCH ' '
	 OUTCH '*'
	 OUTCH BL
	 OUTCH '='
	 OUTINT AX
	 DEC SI
	 OUTINT SI,2
	 OUTCH ' '
	 OUTCH '*'
	 OUTCH BL
	 OUTCH '='
	 OUTINT AX
	 newline
	 ADD AX,SI
	 INC BL
	 LOOP sss1
	 JMP sss2
	 sss1: JMP sss
	 sss2: INCH DL
	 MOV CX,SI
	 LOOP ttt1
	 finish
	 ttt1: JMP ttt	 

code ends
    end start 
	