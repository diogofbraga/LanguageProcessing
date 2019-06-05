%{
#include <stdio.h>
#include <stdlib.h>
#define GNUSOURCE
%}
%union{char* str; int num;}
%token DIAPOSITIVO CRED IMG LI VID TITL AUD
%token <str> STRING
%token <num> NUM
%type <str> Elementos Elemento Tipo PagInicial Galeria PagSimples Video Creditos Credito Imagens Imagem ListItems Item Vid Opcoes Titulo Audio
%type <num> Tempo
%%
Diaporama : Elementos
          ;

Elementos : Elemento
          | Elementos ',' Elemento
          ;

Elemento : DIAPOSITIVO '{' Tempo ',' Tipo '}'
         ;

Tempo : NUM
      ;

Tipo : PagInicial
     | Galeria
     | PagSimples
     | Video
     ;

PagInicial : Opcoes ',' Creditos
           | Creditos
           ;

Creditos : Credito
         | Creditos ',' Credito
         ;

Credito : CRED STRING
        ;

Galeria : Opcoes ',' Imagens
        | Imagens
        ;

Imagens : Imagem
        | Imagens ',' Imagem
        ;

Imagem : IMG STRING
       ;

PagSimples : Opcoes ',' ListItems
           | ListItems
           ;

ListItems : Item
          | ListItems , Item
          ;

Item : LI STRING
     ;

Video : Opcoes ',' Vid
      | Vid
      ;

Vid : VID STRING
    ;

Opcoes : Titulo ',' Audio
       | Audio ',' Titulo
       | Titulo
       | Audio
       ;

Titulo : TITL STRING
       ;

Audio : AUD STRING
      ;
%%

#include "lex.yy.c"

int yyerror(char* s){
    printf("Erro: %s", s);
    return 0;
}

int main(){
    yyparse();
    return 0;
}
