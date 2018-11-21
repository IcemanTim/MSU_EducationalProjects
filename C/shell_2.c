#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

typedef struct list{
  char* elem;
  struct list *next;
  struct list *prev;
}list;

typedef struct nomer{
  int elem;
  struct nomer *prev;
  struct nomer *next;
}nomer;

nomer *pushbackk(nomer *head,int value);
list *pushback(list *head,char *value);
list *getlastelem(list *head);
nomer *getlastelemm(nomer *head);
void deletelist(list **head);
char** toarray(const list *head,int leng);
void readline();
nomer * start(char **argv,int kol,nomer *tmp);
int pop(nomer **head);
nomer* getNth(nomer* head, int n);

//-------------------------------------
int main(int argc, char *argv[]){

    readline();
    return 0;
  
}

/*чтение строки и разбивка ее на отдельные слова*/
void readline(){
    
    nomer *NUM=NULL;
    list *tmp = NULL; 
    char **mass=0;
    int N=50,delta=10,c,cc,i;
    char *buf =(char*)calloc(N,sizeof(char));
    int fl_kov,k=0,kol=0;
	
    printf("$ ");
    while( (c=getchar()) != EOF){
	  
      if(c!='"'){
        if((c!=' ') && (c!='\n')){
	      buf[k++] = c;
	      fl_kov = 0;
	      if(k >= N-1){
	        N += delta;
	        buf = realloc(buf,N*sizeof(char));
	      } 
	    }
	    else{
	      if(buf[0] != 0){
	        tmp = pushback(tmp,buf);
	        kol++;
	        N = 50;
	        k = 0;
	        buf = (char *) calloc(N,sizeof(char));
	      }
	    }
	  }     
	  else{
        while(1){
          cc = getchar();
          
          if(cc == '"'){
            fl_kov = 0;
            break;
          }
          else{
            buf[k++] = cc;
	        fl_kov = 1;
	        if(k >= N){
	          N += delta;
	          buf = realloc(buf,sizeof(char)*N);
            }       
	      } 
	      
          if((cc == EOF) && (fl_kov == 1)){
            fprintf(stderr, "Нечетное число кавычек!\n");
            exit(1);
          }
          
          if((cc == '\n') && (fl_kov == 1)){
            if(tmp!=NULL)
              deletelist(&tmp);
            N=50;
	    k=0;
	    buf = (char*)calloc(N,sizeof(char));
            tmp = NULL; 
            kol=0;  
            fprintf(stderr, "Нечетное число кавычек!\n");
            printf("\n>>>");
            break;
          }
        }  
      }    
      
      if(c == '\n'){
        if(tmp!=NULL){
          mass = toarray(tmp,kol);
          NUM = start(mass,kol,NUM);          
          deletelist(&tmp);
          for(i = 0; i < kol; i++)
            free(mass[i]);
          free(mass);
        }
        tmp = NULL;
        kol=0;
	printf("$ ");   
      }  	        
    } 
    deletelist(&tmp);
} 

/*вставка нового элемента сзади*/
list *pushback(list *head, char* value){
  list *last = getlastelem(head);
  list *tmp = malloc(sizeof(list));
  tmp->elem = value;
  tmp->next = NULL;
  tmp->prev = last;
  if(last != NULL){
    last->next = tmp;
    return head;
  }
  else
    return tmp;   
}

/* получение последнего элемента списка*/
list *getlastelem(list *head){
  if(head == NULL)
    return NULL;
  while(head->next){
    head = head->next;
  }
  return head;
}


/*вставка нового элемента сзади*/
nomer *pushbackk(nomer *head, int value){
  nomer *last = getlastelemm(head);
  nomer *tmp = malloc(sizeof(nomer));
  tmp->elem = value;
  tmp->next = NULL;
  tmp->prev = last;
  if(last != NULL){
    last->next = tmp;
    return head;
  }
  else
    return tmp;   
}

/* получение последнего элемента списка*/
nomer *getlastelemm(nomer *head){
  if(head  == NULL)
    return NULL;
  while(head->next){
    head = head->next;
  }
  return head;
}

//создание массива из списка
char** toarray(const list *head,int leng){
  int N=50, i,k=0;
  char** values = (char**) malloc((leng+1)*sizeof(char*));
  for(i = 0; i < leng; i++)
    values[i] = (char *)malloc(N*sizeof(char));
  while(head && k<leng){
    values[k++] = head->elem; 
    head = head->next;
  } 
  values[leng] = NULL; 
  return values;
}
//процессы и команды
nomer* start(char **argv,int kol,nomer *tmp){
  
  nomer *help=NULL; 
  char *myarg;
  int res;
  pid_t pid,value;
  int flag=0,i;

  help=tmp;
  
  if(strcmp(argv[0],"cd")==0)
  {
    if(argv[1]!=NULL && argv[2]==NULL)
    {
      if(strcmp(argv[1],"~")==0){
        myarg=getenv("HOME");
        res=chdir(myarg);
      }
      else
        res = chdir(argv[1]);
      if(res!=0){
        perror(argv[0]);
      }
    }   
    if(argv[1]==NULL){
      myarg=getenv("HOME");
      res=chdir(myarg);
      if(res!=0)
        perror(argv[0]);
    }             
    if(argv[2]!=NULL)
      perror(argv[0]);
  }
  else{ 
    for(i=0;i<kol;i++){
      if(argv[i]=="&"){
        flag=1;
        break;
      }
    }
    if(flag==1){
      if(argv[i+1]!=NULL)
        printf(" Неправильно реализован переход в фоновый режим!");
      else{
        argv[i]=NULL;
        signal(SIGINT,SIG_IGN);
        pid = fork();
        tmp=pushbackk(tmp,getpid()); 
        kol++;  
        if(pid == 0){
	  execvp(argv[0],argv);
          perror(argv[0]);
          exit(1);
        }
        else{
          if(pid < 0)
            status = -1;
	}
      } 
    }
    else{
      pid = fork();      
      if( pid == 0){
        execvp(argv[0],argv);
        perror(argv[0]);
        exit(1);
      }
      else{
        wait4(pid,&status,WUNTRACED);
        while(help){
          value = waitpid(help->elem,&status,WNOHANG);
          if(value>0)
            deleteNth(tmp,i);
	  help=help->next;
        }
      }
    }
  }
}
//удаление списка
void deletelist(list **head){
  list* prev = NULL;
  while ((*head)->next){
    prev = (*head);
    (*head) = (*head)->next;
    free(prev);
  }
  free(*head);
}

int deleteNth(nomer **head, int n){
  if(n == 0)
    return pop(head);
  else{
    nomer *help = getNth(*head, n-1);
    nomer *elm  = help->next;
    int val = elm->elem; 
    help->next = elm->next;
    free(elm);
    return val;
  }
}

nomer* getNth(nomer* head, int n) {
  int counter = 0;
  while (counter < n && head) {
    head = head->next;
    counter++;
  }
  return head;
}

int pop(nomer **head){
  nomer* help = NULL;
  int val;
  if(head == NULL){
    exit(-1);
  }
  help = (*head);
  val = help->elem;
  (*head) = (*head)->next;
  free(help);
  return val;
}
