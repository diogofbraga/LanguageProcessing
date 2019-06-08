%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "auxiliares.h"
#define GNUSOURCE

char* pasta;
int slide_counter = 0;
FILE *file;

%}
%union{char* str; int num;}
%token DIAPOSITIVO CRED IMG LI VID TITL AUD
%token <str> STRING
%token <num> NUM
%type <str> Nome Elementos Elemento Body Tipos Tipo Credito Imagem Item Video Opcoes Titulo Audio
%type <num> Tempo
%%
Diaporama : Nome ',' Elementos                          {createLastFile(slide_counter, pasta);}
          ;

Nome : STRING                                           {pasta = strdup($1); mkdir(pasta, 0777); }
     ;

Elementos : Elemento
          | Elementos ',' Elemento
          ;

Elemento : DIAPOSITIVO '{' Tempo ';' Body '}'           {fileTermination(file);}
         ;

Body : '(' Opcoes ')' ',' Tipos
     | Tipos
     ;

Tipos : Tipo
      | Tipos ',' Tipo
      ;

Tempo : NUM                                             {slide_counter++;
                                                         file = createFile(slide_counter, pasta);
                                                         makeheader($1, file, slide_counter); }
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

Item : LI STRING                                        {insertItem(file, $2);}
     ;

Video : VID STRING
      ;

Opcoes : Opcoes ',' Audio
       | Opcoes ',' Titulo
       | Titulo
       | Audio
       ;

Titulo : TITL STRING                                    {insertTitle(file, $2);}
       ;

Audio : AUD STRING                                      {insertAudio(file, $2);}
      ;
%%

#include "lex.yy.c"

int yyerror(char* s){
    printf("Erro: %s\n", s);
    return 0;
}

int main(){
    yyparse();
    return 0;
}
