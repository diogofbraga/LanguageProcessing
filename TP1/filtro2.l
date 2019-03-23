%{
#include <stdio.h>

int paginas = 0;
int paginas_titulo = 0;
int quote = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
inicio_titulo   \<title\>
fim_titulo      \<\/title\>
quote_token     {espacos}\&quot\;

%x PAGE
%x CONTEUDO_PAGE CONTEUDO_TURQ_BUL_HOL CONTEUDO_CHI_JAP CONTEUDO_JUD CONTEUDO_POL CONTEUDO_GRE CONTEUDO_RUS_ESP CONTEUDO_ARA
%x QUOTE QUOTE_TURQ_BUL_HOL QUOTE_CHI_JAP QUOTE_JUD QUOTE_POL QUOTE_GRE QUOTE_RUS_ESP QUOTE_ARA
%%
{nova_pagina}                                   {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}Provérbios{espacos}turcos{fim_titulo}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_HOL;}

<PAGE>{inicio_titulo}Provérbios{espacos}búlgaros{fim_titulo}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_HOL;}

<PAGE>{inicio_titulo}Provérbios{espacos}chineses{fim_titulo}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_CHI_JAP;}

<PAGE>{inicio_titulo}Provérbios{espacos}judaicos{fim_titulo}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_JUD;}

<PAGE>{inicio_titulo}Provérbios{espacos}holandeses{fim_titulo}  {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_HOL;}

<PAGE>{inicio_titulo}Provérbios{espacos}poloneses{fim_titulo}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_POL;}

<PAGE>{inicio_titulo}Provérbios{espacos}gregos{fim_titulo}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_GRE;}

<PAGE>{inicio_titulo}Provérbios{espacos}russos{fim_titulo}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_RUS_ESP;}

<PAGE>{inicio_titulo}Provérbios{espacos}espanhóis{fim_titulo}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_RUS_ESP;}

<PAGE>{inicio_titulo}Provérbios{espacos}árabes{fim_titulo}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                  printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_ARA;}

<PAGE>{inicio_titulo}Provérbios{espacos}japoneses{fim_titulo}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_CHI_JAP;}


<PAGE>{inicio_titulo}Provérbios.*{fim_titulo}                    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                  printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_PAGE;}

<CONTEUDO_PAGE>^\*{quote_token}{espacos}             {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^\*{espacos}''                        {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^\*{espacos}'''                       {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^\*{espacos}'''{quote_token}          {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^\*{espacos}''{quote_token}           {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^:'''                                 {quote++; BEGIN QUOTE;}

<CONTEUDO_PAGE>^'''                                  {quote++; BEGIN QUOTE;}



<CONTEUDO_TURQ_BUL_HOL>^\*{quote_token}{espacos}         {quote++; BEGIN QUOTE_TURQ_BUL_HOL;}

<CONTEUDO_TURQ_BUL_HOL>^\*{espacos}                      {quote++; BEGIN QUOTE_TURQ_BUL_HOL;}

<CONTEUDO_CHI_JAP>^\*{quote_token}{espacos}              {quote++; BEGIN QUOTE_CHI_JAP;}

<CONTEUDO_CHI_JAP>^\*{espacos}                           {quote++; BEGIN QUOTE_CHI_JAP;}

<CONTEUDO_JUD>^\*{espacos}''{quote_token}            {quote++; BEGIN QUOTE_JUD;}

<CONTEUDO_JUD>^\*\*{espacos}''{quote_token}          {quote++; BEGIN QUOTE_JUD;}

<CONTEUDO_JUD>^\*{espacos}{quote_token}              {quote++; BEGIN QUOTE_JUD;}

<CONTEUDO_POL>^\*{espacos}                           {quote++; BEGIN QUOTE_POL;}

<CONTEUDO_GRE>^\:{espacos}{quote_token}'''           {quote++; BEGIN QUOTE_GRE;}

<CONTEUDO_GRE>^\:'''{quote_token}                    {quote++; BEGIN QUOTE_GRE;}

<CONTEUDO_GRE>^\::''                                 {quote++; BEGIN QUOTE_GRE;}

<CONTEUDO_GRE>^\::''{quote_token}                    {quote++; BEGIN QUOTE_GRE;}

<CONTEUDO_GRE>^\*{espacos}{quote_token}'''           {quote++; BEGIN QUOTE_GRE;}

<CONTEUDO_RUS_ESP>^\*{espacos}                       {quote++; BEGIN QUOTE_RUS_ESP;}

<CONTEUDO_ARA>^\*{espacos}                           {quote++; BEGIN QUOTE_ARA;}




<QUOTE>.*''{quote_token}\n                      {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}

<QUOTE>.*{quote_token}\n                          {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}

<QUOTE>.*{quote_token}''\n                        {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}

<QUOTE>.*{quote_token}'''{espacos}\n            {yytext[yyleng-11] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}

<QUOTE>.*'''                                     {yytext[yyleng-3] = '\0'; printf("    - Quote: %s\n",yytext);
                                                 BEGIN CONTEUDO_PAGE;}

<QUOTE>.*''                                      {yytext[yyleng-2] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}

<QUOTE>.*\n                                      {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_PAGE;}



<QUOTE_TURQ_BUL_HOL>.*{quote_token}\n               {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_TURQ_BUL_HOL;}

<QUOTE_TURQ_BUL_HOL>.*\n                            {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_TURQ_BUL_HOL;}

<QUOTE_CHI_JAP>.*{quote_token}\n                    {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_CHI_JAP;}

<QUOTE_CHI_JAP>.*{quote_token}{espacos}\n           {yytext[yyleng-8] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_CHI_JAP;}

<QUOTE_CHI_JAP>.*\n                                 {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_CHI_JAP;}

<QUOTE_JUD>.*{quote_token}.''\n                 {yytext[yyleng-10] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_JUD;}

<QUOTE_JUD>.*{quote_token}''\n                  {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_JUD;}

<QUOTE_JUD>.*{quote_token}\n                    {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_JUD;}

<QUOTE_POL>.*\n                                 {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_POL;}

<QUOTE_GRE>.*{quote_token}''\n                  {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_GRE;}

<QUOTE_GRE>.*{quote_token}'''\n                 {yytext[yyleng-10] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_GRE;}

<QUOTE_RUS_ESP>.*\n                             {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_RUS_ESP;}

<QUOTE_ARA>.*\n                                 {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN CONTEUDO_ARA;}


<*>{fim_pagina}                                 {BEGIN INITIAL;}
<*>.|\n                                         {;}
%%

/*

<CONTEUDO_PAGE>^\*{espaco}.*\n:                  {quote++; yytext[yyleng-2] = '\0'; printf("    - Quote: %s\n",yytext);
                                                BEGIN QUOTE_BULG; }

*/

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("Organizado por título e citações.\n\n");
    yylex();
    printf("\n\nNúmero de páginas: %d\n", paginas);
    printf("Número de páginas com título começado por 'Provérbios': %d\n", paginas_titulo);
    printf("Número de citações: %d\n", quote);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro2 > saida.txt
