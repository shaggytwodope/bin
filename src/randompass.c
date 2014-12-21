/* Generate text using the linux /dev/random device.                          */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

static const char *allowed_symbols = "-+;!%=,.-#&@$~";

char get_valid_char(FILE *fp);

int main(void)
{
  int len;
  int loopster;
  char *gentext;
  FILE *fp;

  printf("How long do you want the random string to be? ");
  scanf("%d", &len);

  gentext = malloc(len + 1);
  fp = fopen("/dev/random", "rb");

  printf("Generating... ");
  fflush(stdout);

  for(loopster = 0; loopster < len; loopster++)
    *(gentext + loopster) = get_valid_char(fp);
  *(gentext + len) = 0;

  printf("The string you requested: \"%s\"\n", gentext);
  fclose(fp);
  free(gentext);
  
  return 0;
}

char get_valid_char(FILE *fp)
{
  char read_byte;
  int loopster;

READ_LOOP_BEGIN:
  read_byte = getc(fp);

  if(isalnum(read_byte))
    goto READ_LOOP_END;

  for(loopster = 0; loopster < strlen(allowed_symbols); loopster++)
    if(read_byte == *(allowed_symbols + loopster))
      goto READ_LOOP_END;

  goto READ_LOOP_BEGIN;

READ_LOOP_END:

  return read_byte;
}