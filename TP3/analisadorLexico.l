%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

%}

%%
DIAPOSITIVO                         {return DIAPOSITIVO;}
CRED                                {return CRED;}
IMG                                 {return IMG;}
LI                                  {return LI;}
VID                                 {return VID;}
TITL                                {return TITL;}
AUD                                 {return AUD;}
[\[\],{}]                           {return yytext[0];}
[0-9]+                              {yylval.num = atof(yytext); return NUM;}
\"[^\"]*\"                          {yylval.str = strdup(yytext); return STRING;}
.|\n                                {;}
%%

int yywrap() {return 1;}
