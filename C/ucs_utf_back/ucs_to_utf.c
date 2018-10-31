#include <stdio.h>
#include <stdlib.h>

#define MAX 1000000
typedef unsigned short ushort;

int ucs2_utf8(ushort*, int, char*,int k);      
int  readfile(ushort*);						  	 
ushort get_byte(int,int*);						  

int main(){
	int len,i,kolb;
	char* utf;
	ushort* ucs;
	
	ucs=(ushort*)malloc(sizeof(ushort));
	len=readfile(ucs);
	utf=(char*) malloc(1);
	kolb=ucs2_utf8(ucs, len, utf, MAX);
	for(i=0; i<kolb; i++)
		putchar(utf[i]);
	return 0;	
}

int ucs2_utf8(ushort *ucs, int n, char* utf,int k){
	int i,j=0;
	
	for (i=0; i<n; i++){
		if (ucs[i]<=127){
			utf=(char*) realloc(utf,(j+1));
			utf[j]=ucs[i];
			j++;
		}
		else{
			 if (ucs[i]<=2047){
				 utf=(char*)realloc(utf,j+2);
				 utf[j]=6; 
				 utf[j]<<=5;
				 
				 utf[j+1]=2;  
				 utf[j+1]<<=6;
				 
				 utf[j+1]|= 0x3F & ucs[i];
				 
				 ucs[i]>>=6;
				 utf[j] |=0x1F & ucs[i];  
				 j+=2;
			 }
			 else{
				 if(ucs[i]<=65535){
					 utf=(char*) realloc(utf,j+3);
					 utf[j]=14; 
					 utf[j]<<=4;
					 
					 utf[j+1]=utf[j+2]=2;
					 utf[j+1]<<=6;
					 utf[j+2]<<=6;
					 
					 utf[j+2]|=0x3F & ucs[i]; 
					 
					 ucs[i]>>=6;
					 utf[j+1]|=0x3F & ucs[i];
					 
					 ucs[i]>>=6;
					 utf[j]|=0xF & ucs[i];
					 j+=3;
				 }
			 }
		 }
		 if (j>k){
			printf("Переборщили с текстом!\n");
			return -1;
		}
	 }
	 return j;
 }
 			
int readfile(ushort* ucs){
	ushort buf;
	int n=-1,i=0,flag=0;   //: 1 прямой, -1 обратный
	
	if ((buf=get_byte(n,&flag))==0xFFFE || buf==0xFEFF){// LE или BE
		if (buf==0xFFFE)  
			n=1;
		else   			  
			n=-1;
		buf=get_byte(n,&flag);
	}
	else
		n=-1;//если нет BOM - LE
	while (flag==0){
		ucs[i]=buf;
		i++;
		ucs=(ushort*) realloc( ucs,(i+1)*sizeof(ushort));
		buf=get_byte(n,&flag);
	}
	if (flag==-1){
		printf("Нечетное количество элементов\n");
	    return 0;  
    }
    else
		return i;
}
			
ushort get_byte(int n,int* flag){
	int buf,help; 
	
	buf=getchar();
	if(buf==EOF)
		*flag=1;//конец файла
	else{
		help=getchar();
		if (help==EOF)//ошибка - нечетное количество байт
			*flag=-1;
		else{
			if(n==1)
			  return ((buf&0xFF)<<8 | (help&0xFF));
			if(n==-1)
			  return ((help&0xFF)<<8 | (buf&0xFF));
		}
		return 0;
	}	
	return 0;	
}
