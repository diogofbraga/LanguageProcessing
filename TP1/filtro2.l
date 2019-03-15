%{
// definiçoes gerais do sistema
#include <stdio.h>

int paginas = 0;
int paginas_titulo = 0;
char* title;
int quote = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
inicio_titulo   \<title\>
fim_titulo      \<\/title\>
quote_token     {espacos}\&quot\;


%x PAGE TITLE CONTEUDO_PAGE QUOTE
%%
{nova_pagina}                              {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}                      {BEGIN TITLE;}

<TITLE>Provérbios.*{fim_titulo}            {paginas_titulo++; yytext[yyleng-8] = '\0'; printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_PAGE;}

<CONTEUDO_PAGE>\*{quote_token}{espacos}    {quote++; BEGIN QUOTE;}

<QUOTE>.*{quote_token}                     {yytext[yyleng-6] = '\0'; printf("    - Quote: %s\n",yytext); BEGIN CONTEUDO_PAGE;}

<*>{fim_pagina}                            {BEGIN INITIAL;}
<*>.|\n                                    {;}
%%

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
