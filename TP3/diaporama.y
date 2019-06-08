%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#define GNUSOURCE

char* pasta;
int slide_counter = 0;
int file_descriptor;

int criaFicheiro();
void renameFiles();
%}
%union{char* str; int num;}
%token DIAPOSITIVO CRED IMG LI VID TITL AUD
%token <str> STRING
%token <num> NUM
%type <str> Nome Elementos Elemento Body Tipos Tipo Credito Imagem Item Video Opcoes Titulo Audio
%type <num> Tempo
%%
Diaporama : Nome ',' Elementos                          {pasta = strdup($1); mkdir(pasta, 0777); renameFiles();}
          ;

Nome : STRING
     ;

Elementos : Elemento
          | Elementos ',' Elemento
          ;

Elemento : DIAPOSITIVO '{' Tempo ';' Body '}'           {slide_counter++; file_descriptor = criaFicheiro();}
         ;

Body : '(' Opcoes ')' ',' Tipos
     | Tipos
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

int criaFicheiro(){
    char file_name[100];
    sprintf(file_name, "diap%d.html",slide_counter);
    return open(file_name, O_CREAT | O_RDWR, 0666);
}

void renameFiles(){
    for(int i = 1 ; i <= slide_counter ; i++){
        char old[100], new[100];
        sprintf(old, "diap%d.html",i);
        sprintf(new, "%s/%s",pasta,old);
        rename(old, new);
    }
}


int yyerror(char* s){
    printf("Erro: %s\n", s);
    return 0;
}

int main(){
    yyparse();
    printf("Número de slides: %d\n", slide_counter );
    return 0;
}
