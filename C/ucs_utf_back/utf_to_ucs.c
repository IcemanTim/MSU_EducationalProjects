#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define  badbit 12345
#define  delta 50
typedef unsigned short ushort;

void readfile();
int utf8_ucs2(char*, int, ushort*, int, ushort);
void printfile(ushort*, int);
int order=0;

int main(int argc, char *argv[]) {
    char* dir;
    
    if (argc < 2)
        dir = "le";
    else
        dir = argv[1];
    order = strcmp(dir, "le");
    readfile();
    
    return 0;
}

void printfile(ushort* ucs, int finlen){
    int byte1, byte2, help,i;
    
    for(i = 0;i<finlen;i++){
        byte1 = (*ucs & 0xff00) >> 8;
        byte2 = (*ucs & 0xff);
        if(order){
          help  = byte1;
          byte1 = byte2;
          byte2 = help;
        }
        putchar(byte1);
        putchar(byte2);
        ucs++;
    }
}

void readfile(){
    int len = 0, finlen = 0,buf;
    char *utf = malloc(delta * sizeof(char));
    char *help = utf;
    ushort* ucs;
    
    while ((buf = getchar()) != EOF){
        if (len % delta == 0){
            help = (char*) realloc(help, (len + delta) * sizeof(char));
            utf = help + len;
        }
        *utf = buf;
        len++;
        utf++;
    }
    ucs = (ushort*) malloc(len * sizeof(ushort));
    utf = help;
    finlen = utf8_ucs2(utf, len, ucs, len, badbit);
    if (finlen< 0){
      fprintf(stderr, "переполнение\n");
      exit(1);
    }
    else
      printfile(ucs, finlen);
}

int utf8_ucs2(char* utf, int n, ushort* ucs, int len, ushort bad){
    int buf;
    int count = 0;
    int finlen = 0;
    
    while (count<n){
        if (finlen >= len)
            return -1;
        buf = *utf;
        utf++;
        count++;
        if ((buf & 0x80) == 0)
            *ucs = buf;
        else if ((buf & 0xe0) == 0xc0){
            *ucs = (buf & 0x1f) << 6;            
            if (count < n){
                if (((buf = *utf) & 0xc0) == 0x80){
                    utf++;
                    count++;
                    *ucs |= buf & 0x3f;
                }
                else{
                    utf++;
                    count++;
                    *ucs = bad;
                    fprintf(stderr, "неверный символ %d на %d позиции\n", buf, count);
                }
            }
            else{
                *ucs = bad;
                fprintf(stderr, "переполнение\n");
                return -1;
            }
        }
        else if ((buf & 0xF0) == 0xE0){
            *ucs = (buf & 0xf) << 12;
            if (count >= n - 1){
                *ucs = bad;
                fprintf(stderr, "переполнение\n");
                return -1;
            }
            if (((buf = *utf) & 0xc0) != 0x80){
                *ucs = bad;
                count++;
                utf++;
                fprintf(stderr, "неверный символ %d на %d позиции\n", buf, len);
            }
            else{
                *ucs |= (buf & 0x3f) << 6;
                count++;
                utf++;
                if (((buf = *utf) & 0xc0) == 0x80){
                    utf++;
                    count++;
                    *ucs |= buf & 0x3f;
                }
                else{
                    utf++;
                    count++;
                    *ucs = bad;
                    fprintf(stderr, "Неверный символ %d на %d позиции\n", buf, len);
                }
            }
        }
        else{
            *ucs = bad;
            fprintf(stderr, "неверный символ %d на %d позиции\n", buf, len);
        }
        ucs++;
        finlen++;
    }
    return finlen;
}