%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

char* removeTokens(char* s);

%}

%%
DIAPOSITIVO                         {return DIAPOSITIVO;}
CRED                                {return CRED;}
IMG                                 {return IMG;}
LI                                  {return LI;}
VID                                 {return VID;}
LB                                  {return LB;}
TITL                                {return TITL;}
AUD                                 {return AUD;}
[,;{}()]                            {return yytext[0];}
[0-9]+                              {yylval.num = atof(yytext); return NUM;}
\"[^\"]*\"                          {char* str = removeTokens(yytext); yylval.str = strdup(str); return STRING;}
.|\n                                {;}
%%

int yywrap() {return 1;}

char* removeTokens(char* s){
    char *p = s;
    p++;
    p[strlen(p)-1] = 0;
    return p;
}
