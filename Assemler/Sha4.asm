;Shalimov Timofey 114
;input number in 5 base
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
	
	mov bx, 5
	mov ax, 0
	mov cx, 0
	outch '?'
cycle:
	inch cl
	cmp cl, ' '; if ' ' goto endc
	je endc
	sub cl, '0'
	mul bx; dx = 0 by conditions
	add ax, cx
	jmp cycle
endc:
	outint ax
	
    finish
code ends
    end start 
	