%{
// definiçoes gerais do sistema
#include <stdio.h>
int paginas = 0;
%}
%x PAGE
%%
\<page>                 {paginas++; BEGIN PAGE;}
<PAGE>\<\/page>         {BEGIN INITIAL;}
<*>.|\n                 {;}
%%

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("A inicializar filtragem...\n");
    yylex();
    printf("Terminei. Número de páginas: %d\n", paginas);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro
