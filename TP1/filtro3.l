%{
#include <stdio.h>

int paginas = 0;
int paginas_titulo = 0;
int quote = 0;
int adulterados = 0;
int alternativos = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
inicio_titulo   \<title\>
fim_titulo      \<\/title\>
quote_token     {espacos}\&quot\;
adulteracao     '''Adulteração:'''
alternativos    '''Alternativos:'''
adulterados     '''Adulterados:'''
portugal        {espaco}(Portugal)
brasil          {espaco}(Brasil)

%x PAGE TITLE CONTEUDO_PAGE QUOTE ADULTERACAO ALTERNATIVOS QUOTES_ADULTERACAO QUOTES_ALTERNATIVOS
%%
{nova_pagina}                                                  {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}                                          {BEGIN TITLE;}

<TITLE>Provérbios.*{fim_titulo}                                {paginas_titulo++; yytext[yyleng-8] = '\0';
                                                               printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_PAGE;}

<CONTEUDO_PAGE>\*{quote_token}{espacos}                        {BEGIN QUOTE;}

<QUOTE>.*{quote_token}                                         {BEGIN CONTEUDO_PAGE;}

<QUOTE>.*{quote_token}\n\*\*{espaco}{adulterados}              {quote++; yytext[yyleng-28] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}{portugal}\n\*\*{espaco}{adulterados}    {quote++; yytext[yyleng-39] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}{brasil}\n\*\*{espaco}{adulterados}      {quote++; yytext[yyleng-37] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}\n\*\*{espaco}{adulteracao}              {quote++; yytext[yyleng-30] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}{portugal}\n\*\*{espaco}{adulteracao}    {quote++; yytext[yyleng-41] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}{brasil}\n\*\*{espaco}{adulteracao}      {quote++; yytext[yyleng-39] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTE>.*{quote_token}\n\*\*{espaco}{alternativos}             {quote++; yytext[yyleng-29] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ALTERNATIVOS;}

<QUOTE>.*{quote_token}{portugal}\n\*\*{espaco}{alternativos}   {quote++; yytext[yyleng-40] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ALTERNATIVOS;}

<QUOTE>.*{quote_token}{brasil}\n\*\*{espaco}{alternativos}     {quote++; yytext[yyleng-38] = '\0';
                                                               printf("    - Quote: %s\n",yytext);
                                                               BEGIN ALTERNATIVOS;}

<ADULTERACAO>\*\*\*{quote_token}                               {BEGIN QUOTES_ADULTERACAO;}
<ADULTERACAO>\*{quote_token}{espacos}                          {BEGIN QUOTE;}

<ALTERNATIVOS>\*\*\*{quote_token}                              {BEGIN QUOTES_ALTERNATIVOS;}
<ALTERNATIVOS>\*{quote_token}{espacos}                         {BEGIN QUOTE;}
<ALTERNATIVOS>\*\*{espaco}{adulterados}                        {yytext[yyleng-20] = '\0'; BEGIN ADULTERACAO;}
<ALTERNATIVOS>\*\*{espaco}{adulteracao}                        {yytext[yyleng-20] = '\0'; BEGIN ADULTERACAO;}

<QUOTES_ADULTERACAO>.*{quote_token}                            {adulterados++; yytext[yyleng-6] = '\0';
                                                               printf("        - Adulterado: %s\n",yytext);
                                                               BEGIN ADULTERACAO;}

<QUOTES_ALTERNATIVOS>.*{quote_token}                           {alternativos++; yytext[yyleng-6] = '\0';
                                                               printf("        - Alternativo: %s\n",yytext);
                                                               BEGIN ALTERNATIVOS;}

<*>{fim_pagina}                                                {BEGIN INITIAL;}
<*>.|\n                                                        {;}
%%

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("Organizado por título e citações (com os seus adulterados).\n\n");
    yylex();
    printf("\n\nNúmero de páginas: %d\n", paginas);
    printf("Número de páginas com título começado por 'Provérbios': %d\n", paginas_titulo);
    printf("Número de adulterações: %d\n", adulterados);
    printf("Número de alternativos: %d\n", alternativos);
    printf("Número de citações com adulterações ou alternativos: %d\n", quote);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro3 > saida.txt
