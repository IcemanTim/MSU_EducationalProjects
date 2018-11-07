
#include <chicken.h>
#include <string.h>
#include <stdio.h>

extern const char* palindrome(const char*);

int main(int argc, char *argv[]) 
{
  CHICKEN_run(C_toplevel);
  
  if(argc == 1) {
    printf("Command line has no additional arguments\n");
    exit(0);
  }

  for(int i=1 ; i<argc; i++) {
  	if (!strcmp(argv[i], palindrome(argv[i]))) {
  		printf("%s\n", argv[i]);
  	}
  }

  return 0;
}
