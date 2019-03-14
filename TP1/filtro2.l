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


%x PAGE TITULO CONTEUDO_TITULO QUOTE
%%
{nova_pagina}                               {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}                       {BEGIN TITULO;}

<TITULO>Provérbios.*{fim_titulo}            {paginas_titulo++; yytext[yyleng-8] = '\0'; title = yytext; printf("%s\n\n\n",title); BEGIN CONTEUDO_TITULO;}

<CONTEUDO_TITULO>\*{quote_token}            {quote++; BEGIN QUOTE;}
<CONTEUDO_TITULO>{fim_pagina}               {BEGIN INITIAL;}

<QUOTE>.*{quote_token}                      {yytext[yyleng-6] = '\0'; printf("%s\n",yytext); BEGIN CONTEUDO_TITULO;}

<*>.|\n                                     {;}
%%
// tenho que ver os quotes só ate ao final da pagina

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("A inicializar filtragem...\n\n");
    yylex();
    printf("\nTerminei. Número de páginas: %d\n", paginas);
    printf("Terminei. Número de páginas com título começado por 'Provérbios': %d\n", paginas_titulo);
    printf("Número de citações: %d\n", quote);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | head -5000 | ./filtro2
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro2 > saida.txt
