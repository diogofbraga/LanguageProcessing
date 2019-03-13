%{
#include <stdio.h>
#include "estruturas.h"

TodasCitacoes tc = NULL;

char* nome;
int paginas = 0;
int paginas_autor = 0;
int count = 0;
int quote = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pagina     \<page\>
fim_pagina      \<\/page\>
nome_linguas    (Nome|Nombre|Name)
inicio_autor    \{\{(?i:Autor)
fim_autor       \}\}
nome_autor      \|{espacos}{nome_linguas}{espacos}={espacos}
quote_token     {espacos}\&quot\;

%x PAGE AUTOR NOME_AUTOR QUOTE
%%
{nova_pagina}                     {paginas++; BEGIN PAGE;}

<PAGE>{inicio_autor}              {paginas_autor++; BEGIN AUTOR;}

<AUTOR>{nome_autor}               {BEGIN NOME_AUTOR;}
<AUTOR>\*{quote_token}            {quote++; BEGIN QUOTE;}

<NOME_AUTOR>.*[\n\|]              {yytext[yyleng-1] = '\0'; nome = strdup(yytext);
                                   if(strlen(nome) <= 1){ nome = ""; BEGIN PAGE;}
                                   else{count++; BEGIN AUTOR;}}

<QUOTE>.*{quote_token}            {yytext[yyleng-6] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\n:-        {yytext[yyleng-9] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\.\n:-      {yytext[yyleng-10] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\n::-       {yytext[yyleng-10] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\.\n::-     {yytext[yyleng-11] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\n\*\*\     {yytext[yyleng-10] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*{quote_token}\.\n\*\*\   {yytext[yyleng-11] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*\n:-                     {yytext[yyleng-3] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*\n::-                    {yytext[yyleng-4] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}
<QUOTE>.*\n\*\*                   {yytext[yyleng-3] = '\0'; insereCitacao(tc,nome,strdup(yytext)); BEGIN AUTOR;}

<*>{fim_pagina}          {BEGIN INITIAL;}
<*>.|\n                           {;}
%%

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    tc = createTodasCitacoes();
    printf("Organizado por autor e citações.\n");
    yylex();
    imprimeCitacoes(tc);
    printf("\n\nNúmero de páginas: %d\n", paginas);
    printf("Número de páginas de autor: %d\n", paginas_autor);
    printf("Número de autores: %d\n", count);
    printf("Número de citações: %d\n", quote);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro1 > saida.txt
