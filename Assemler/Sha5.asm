;Shalimov Timofey 114
;nearest 7k
include io1.asm ;подключение операций ввода-вывода
stack segment stack
	dw 128 dup (?)
stack ends
data segment
	base equ 7
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code

start:
	mov ax,data
	mov ds,ax
	
	outch '?'
	inint ax
	mov bx, base
	mov dx, 0
	mov cx, ax
	div bx
	cmp dx, 0
	je output; if ax mod base = 0 goto output
	sub cx, dx; cx := cx - mod
	mov ax, bx
	mov bx, 2
	div bl
	mov ah, 0; ax := bx div 2
	cmp dx, ax; if mod <= (base mod 2) goto output
	jbe output
	add cx, base; else cx := cx + base 
output:
	outint cx
	
    finish
code ends
    end start 
	