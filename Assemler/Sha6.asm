;Shalimov Timofey 114
;sum
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
	
	outch '?'
	inch bl
	sub bl, '0'
	mov bh, 0
	mov ch, 0
	mov ax, bx
cycle:
	inch bl
	cmp bl, '.'
	je output
	inch cl
	sub cl, '0'	
	cmp bl, '+'
	je summ
	sub ax, cx
	jmp cycle
	summ:
	add ax, cx	
	jmp cycle
output:	
	outint ax	
	
    finish
code ends
    end start 
	