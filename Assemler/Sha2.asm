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
	mov cl, 0; counter
	cycle:
		inch al
		cmp al, '.'
		je endc; if . goto endc
		cmp al, '('
		jne A
		inc cl; if ( c++
		A:
		cmp al, ')'
		jne B
		dec cl; if ) c--
		B:
		cmp cl, 0
		jl bad; if c<0 goto bad
		jmp cycle
	endc:
	cmp cl, 0
	jne bad
	outch 'Y'
	jmp endAll
	bad:
	outch 'N'
	endAll:
	
    finish
code ends
    end start 
	