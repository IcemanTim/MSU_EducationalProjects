INCLUDE IO1.ASM
STACK	SEGMENT STACK
	DB 128 DUP (?)
STACK	ENDS
DATA SEGMENT
  a   dw 3 dup (?)  
  s1 db '������ ���ᨢ - ','$'
  s2 db '�������� ���ᨢ - ','$'
  s3 db '���⥤ ���ᨢ    - ','$'
DATA	ENDS
CODE	SEGMENT
	ASSUME SS:STACK, DS:DATA, CS:CODE
BEGIN:  MOV AX, DATA
	MOV DS,AX
	lea DX,S1; ������ ���ᨢ - �� �᭮ ��� ����
	outstr
    mov CX,10
	mov BX,0
In: inint a[BX]
    add BX,2
	loop In
	mov BX,0
	newline
	mov CX,5; �ய�᪠�� ���� ��ப - ��-����� �祭� ����� ����
clr:newline
    loop clr	
	mov CX,10; �뢮��� ����砫�� ���ᨢ - ⮦� �� ����⭮
	lea DX,S2
	outstr
Out:outint a[BX],6
    add BX,2
    loop Out	
	newline
	mov BX,0; � ������ ��砥 BX - ����� �����, ����� �� ��ࠢ�塞 �� ��� ������. �.�. �� ������� ����� 横��, � "���譨�" �� �� �࠭�� � DI.
	mov DI,0
S:  mov AX,a[BX]
    mov DX,a[BX+2]
	cmp AX,DX; �ࠢ������ ��� �ᥤ��� ����� - �᫨ ��� �����஢���, � 㢥��稢��� "���譨�" ��
	JG P
	mov a[BX],DX; �᫨ �� ��� �� �����஢���, � �� ���塞 �� ������ ���⠬�, 㬥��蠥� �� � �����塞 ��楤��� �� �� ���, ����: ���� ��ਠ�� - ������ ���� �����,
	mov a[BX+2],AX; � ���� ����� �ࠢ� �� ���� �㤥� �����, ��ன ��ਠ�� - ᫥�� �� ��⠭���� "�ᥤ��". � ����� ����� � �⮣� �� ���� � �.
	sub BX,2
	cmp BX,-2
	JE P
	JMP S
P:  add DI,2; �����稢��� "���譨�" ��
    mov BX,DI
    cmp DI,18; �஢��塞, � �� �����஢��� �� �� 㦥 �� ��������
    JNE S	
	newline
Fin:mov CX,10; ����⢥���, ��. ����� �뢮��� �����஢���� ���ᨢ.
    mov BX,0	
	lea DX,S3
	outstr
Ot:outint a[BX],6
    add BX,2
    loop Ot
	newline
       FINISH; ���ᨡ� �� ��ᬮ��, �� �⮬ �ணࠬ��, ��, �����稢�����.
CODE	ENDS
        END BEGIN
