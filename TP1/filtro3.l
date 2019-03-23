%{
#include <stdio.h>

char* citacao;
int paginas = 0;
int paginas_titulo = 0;
int quote = 0;
int adulterados = 0;
int alternativos = 0;
%}
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
inicio_titulo   \<title\>
fim_titulo      \<\/title\>
quote_token     {espacos}\&quot\;
adulteracao     '''Adulteração:'''
alternativos    '''Alternativos:'''
adulterados     '''Adulterados:'''
portugal        {espacos}(Portugal)
brasil          {espacos}(Brasil)

%x PAGE CONTEUDO_PAGE QUOTE ADULTERACAO ALTERNATIVOS QUOTES_ADULTERACAO QUOTES_ALTERNATIVOS QUOTE_CONT
%%
{nova_pagina}                                                  {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}Provérbios.*{fim_titulo}                  {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                               printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_PAGE;}

<CONTEUDO_PAGE,QUOTE_CONT>\*{quote_token}{espacos}             {citacao = "";BEGIN QUOTE;}

<QUOTE>.*{quote_token}                                         {yytext[yyleng-6] = '\0';citacao=strdup(yytext);
                                                               BEGIN QUOTE_CONT;}

<QUOTE_CONT>\n\*\*{espacos}{adulterados}                       {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>{portugal}\n\*\*{espacos}{adulterados}             {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>{brasil}\n\*\*{espacos}{adulterados}               {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>\n\*\*{espacos}{adulteracao}                       {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>{portugal}\n\*\*{espacos}{adulteracao}             {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>{brasil}\n\*\*{espacos}{adulteracao}               {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ADULTERACAO;}

<QUOTE_CONT>\n\*\*{espacos}{alternativos}                      {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ALTERNATIVOS;}

<QUOTE_CONT>{portugal}\n\*\*{espacos}{alternativos}            {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ALTERNATIVOS;}

<QUOTE_CONT>{brasil}\n\*\*{espacos}{alternativos}              {quote++;printf("    - Quote: %s\n",citacao);
                                                               BEGIN ALTERNATIVOS;}

<ADULTERACAO>\*\*\*{quote_token}                               {BEGIN QUOTES_ADULTERACAO;}

<ADULTERACAO>\*{quote_token}{espacos}                          {BEGIN QUOTE;}

<ALTERNATIVOS>\*\*\*{quote_token}                              {BEGIN QUOTES_ALTERNATIVOS;}

<ALTERNATIVOS>\*{quote_token}{espacos}                         {BEGIN QUOTE;}

<ALTERNATIVOS>\*\*{espacos}{adulterados}                       {yytext[yyleng-20] = '\0'; BEGIN ADULTERACAO;}

<ALTERNATIVOS>\*\*{espacos}{adulteracao}                       {yytext[yyleng-20] = '\0'; BEGIN ADULTERACAO;}

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
