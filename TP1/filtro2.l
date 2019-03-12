%{
// definiçoes gerais do sistema
#include <stdio.h>

int paginas = 0;
int paginas_titulo = 0;
char* title;
int count = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
inicio_titulo   \<title\>
fim_titulo      \<\/title\>

%x PAGE
%x TITULO
%x CITACAO
%%
{nova_pagina}                                     {paginas++; BEGIN PAGE;}

<PAGE>{inicio_titulo}                             {BEGIN TITULO;}
<PAGE>{fim_pagina}                                {BEGIN INITIAL;}

<TITULO>Provérbios{espacos}[^({fim_titulo})]+     {paginas_titulo++; title = yytext; printf("%s\n",title); }
<TITULO>{fim_titulo}                              {BEGIN PAGE;}

<*>.|\n                                           {;}

%%

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("A inicializar filtragem...\n\n");
    yylex();
    printf("\nTerminei. Número de páginas: %d\n", paginas);
    printf("Terminei. Número de páginas com título começado por 'Provérbios': %d\n", paginas_titulo);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | head -5000 | ./filtro2
