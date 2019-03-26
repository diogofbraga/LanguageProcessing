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
%x CONTEUDO_PAGE CONTEUDO_PT CONTEUDO_GAL
%x QUOTE QUOTE_PT QUOTE_GAL
%%
{nova_pagina}                                   {paginas++; BEGIN PAGE;}


<PAGE>{inicio_titulo}Provérbios{espaco}em{espaco}Português{fim_titulo}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                         printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_PT;}

<CONTEUDO_PT>^\*{espacos}{quote_token}{espacos}                          {quote++; BEGIN QUOTE_PT;}

<QUOTE_PT>.+{quote_token}                                                {yytext[yyleng-6] = '\0'; printf("    - Quote: %s\n",yytext);
                                                                         BEGIN CONTEUDO_PT ;}


<PAGE>{inicio_titulo}Provérbios{espaco}galegos{fim_titulo}              {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                         printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_GAL;}




<*>{fim_pagina}                                 {BEGIN INITIAL;}
<*>.|\n                                         {;}
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
