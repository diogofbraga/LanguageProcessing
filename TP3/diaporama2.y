%{
#include <stdio.h>
#include <stdlib.h>
#define GNUSOURCE
%}
%union{char* str; int num;}
%token DIAPOSITIVO CRED IMG LI VID TITL AUD
%token <str> STRING
%token <num> NUM
%type <str> Elementos Elemento Tipo Credito Imagem Item Vid Opcoes Titulo Audio
%type <num> Tempo
%%
Diaporama : Elementos
          ;

Elementos : Elemento
          | Elementos ',' Elemento
          ;

// Elemento : DIAPOSITIVO '{' Tempo ',' Tipo '}'
//          ;

Elemento : DIAPOSITIVO '{' Tempo ',' Body '}'
         ;

// Head : '(' Tempo ',' Nome ')'
//      ;

Body : Opcoes '[' Tipos ']'
     | '[' Tipos ']'
     ;

Tipos : Tipo
      | Tipos ',' Tipo
      ;

Tempo : NUM
      ;

Tipo : Credito
     | Imagem
     | Item
     | Video
     ;

Credito : CRED STRING
        ;

Imagem : IMG STRING
       ;

Item : LI STRING
     ;

Video : VID STRING
      ;

Opcoes : Opcoes ',' Audio
       | Opcoes ',' Titulo
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
