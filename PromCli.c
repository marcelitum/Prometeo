#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#define MAXLEN 80
#define CONFIG_FILE "/etc/ssmtp/ssmtp.conf"

struct sample_parameters
{
  char usuario[MAXLEN];
  char password[MAXLEN];
}
  sample_parameters;

/*
 * trim: get rid of trailing and leading whitespace...
 *       ...including the annoying "\n" from fgets()
 */
char * trim (char * s)
{
  /* Initialize start, end pointers */
  char *s1 = s, *s2 = &s[strlen (s) - 1];

  /* Trim and delimit right side */
  while ( (isspace (*s2)) && (s2 >= s1) )
    s2--;
  *(s2+1) = '\0';

  /* Trim left side */
  while ( (isspace (*s1)) && (s1 < s2) )
    s1++;

  /* Copy finished string */
  strcpy (s, s1);
  return s;
}

void parse_config (struct sample_parameters * parms)
{
  char *s, buff[256];
  FILE *fp = fopen (CONFIG_FILE, "r");
  if (fp == NULL)
  {
    return;
  }

  /* Read next line */
  while ((s = fgets (buff, sizeof buff, fp)) != NULL)
  {
    /* Skip blank lines and comments */
    if (buff[0] == '\n' || buff[0] == '#')
      continue;

    /* Parse name/value pair from line */
    char name[MAXLEN], value[MAXLEN];
    s = strtok (buff, "=");
    if (s==NULL)
      continue;
    else
      strncpy (name, s, MAXLEN);
    s = strtok (NULL, "=");
    if (s==NULL)
      continue;
    else
      strncpy (value, s, MAXLEN);
    trim (value);

    /* Copy into correct entry in parameters struct */
    if (strcmp(name, "AuthUser")==0)
      strncpy (parms->usuario, value, MAXLEN);
    else if (strcmp(name, "AuthPass")==0)
      strncpy (parms->password, value, MAXLEN);
  }

  fclose (fp);
}
int main (int argc, char *argv[])
{
  struct sample_parameters parms;
  char cShell[180];
  
  printf ("Reading config file...\n");
  parse_config (&parms);

  strcpy(cShell,"curl -u ");
  strcat(cShell,parms.usuario);
  strcat(cShell,":");
  strcat(cShell,parms.password);
  strcat(cShell," --silent \"https://mail.google.com/mail/feed/atom\" | grep -oPm1 \"(?<=<title>)[^<]+\" | sed '1d' > titulos.txt ");
  system(cShell);
  
  strcpy(cShell,"df > df.txt");
  system(cShell);

  #fusermount -u /mnt/interno
  #sshfs marcelo@190.193.134.181:/media/interno /mnt/interno -C -p 9876  
  
  return 0;
}
