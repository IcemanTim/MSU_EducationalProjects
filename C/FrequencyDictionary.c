#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct list{
  char *word;
  int count;
  struct list *next;
}list;

struct list* poisk(struct list* sp,char *elem);
void print(struct list* tmp,int maxword);
void del(struct list *tmp);
void sorting(struct list *tmp);
void vstav(struct list **tmp,char *elem);
struct list *search_add(struct list *spis,char *elem);
struct list *readword(struct list *tmp,int *maxword);

int main(){
  struct list* spis;
  int maxword;
  spis=NULL;
  spis=readword(spis,&maxword);
  printf("\n Частотный словарь имеет вид:\n");
  sorting(spis);
  print(spis,maxword);
  printf("\n");
  del(spis);
  return 0;
}


struct list* readword(struct list *tmp,int *maxword){
  int N=10,delta=10,i=0,c;
  char *buf=(char*)malloc(N*sizeof(char));
  char *sep="\".,?/!;:'$&%*(){}[]|";
  
  *maxword=0;
  while( (c=getchar())!=EOF){
    if(i>=N){
      N+=delta;
      buf=(char*)realloc(buf,sizeof(char)*N);
    }
    if(!isspace(c) && strchr(sep,c)==0)
      buf[i++]=c;
    else{
      if(i!=0){
        buf[i]=0;
        tmp=search_add(tmp,buf);
        (*maxword)++;
        i=0;
        N=10;
        buf=(char*)malloc(N*sizeof(char));
      }
      if(strchr(sep,c)!=0){
        buf[0]=c;
        buf[1]=0;
        tmp=search_add(tmp,buf);
        (*maxword)++;
        i=0;
        N=10;
        buf=(char*)malloc(N*sizeof(char));
      }
    }  
  }
  free(buf);
  return tmp;
}

struct list *search_add(struct list* tmp, char* elem){
  struct list *a;
  
  if((a=poisk(tmp,elem))==NULL)
    vstav(&tmp,elem);
  else
    (a->count)++;
  return tmp;
}

void sorting(struct list* tmp){
  struct list *i,*j,*last=NULL;
  int help;
  char *whelp;

  if(tmp==NULL || tmp->next==NULL)
    return;
  while(last!=(tmp->next)){
    i=tmp; j=tmp->next;
    while(j!=last){
      if(i->count < j->count){
        help=i->count;
        whelp=i->word;
        i->count=j->count;
        i->word=j->word;
        j->count=help;
        j->word=whelp;
      }
      i=j;
      j=j->next;
    }
    last=i;
  }
}

struct list* poisk(struct list* tmp,char *elem){
  return (tmp==NULL)?NULL:(strcmp(tmp->word,elem)==0)?tmp:poisk(tmp->next,elem);
}

void vstav(struct list** tmp,char *elem){
  struct list *help;
  
  help=malloc(sizeof(struct list));
  help->word=elem;
  help->count=1;
  help->next=*tmp;
  *tmp=help;
}

void print(struct list* tmp, int maxword){
  while(tmp!=NULL){
    printf("%s %d\n",tmp->word,tmp->count);
    tmp=tmp->next;
 }
}

void del(struct list* tmp){
  struct list *help;
  while(tmp!=NULL){
    help=tmp;
    tmp=tmp->next;
    free(help->word);
    free(help);
  }
}
