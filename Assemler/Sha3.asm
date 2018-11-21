;Shalimov Timofey 114
;multiply of the first and last digit of number
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
	inint ax
	mov dx, 0
	mov cx, 10
	div cx; ax := ax div 10
	mov bx, dx; bx := ax mod 10
	cmp ax, 0; if ax div 10 = 0
	je endc
Cycle:
	mov dx, 0
	div cx; ax := ax div 10
	cmp ax, 0
	jne cycle; if ax div 10 <> 0
endc:
	mov al, dl
	mul bl; both numers <10
	outint ax
	
    finish
code ends
    end start 
	