%{
#include <stdio.h>

char* citacao;
int paginas = 0;
int paginas_titulo = 0;
int quote = 0;
int adulterados = 0;
int alternativos = 0;
%}
espacos         [ ]*
nova_pag        \<page\>
fim_pag         \<\/page\>
ini_tit         \<title\>
fim_tit         \<\/title\>
quote_token     {espacos}\&quot\;{espacos}
adulteracao     {espacos}'''Adulteração:'''
alternativos    {espacos}'''Alternativos:'''
adulterados     {espacos}'''Adulterados:'''

%x PAGE PAGE_CONTEUDO QUOTE ADULTERADOS ALTERNATIVOS QUOTES_ADULTERADOS QUOTES_ALTERNATIVOS QUOTE_CONT
%%
{nova_pag}                                    {paginas++; BEGIN PAGE;}

<PAGE>{ini_tit}Provérbios.*{fim_tit}          {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                              printf("\nTitle: %s\n\n",yytext); BEGIN PAGE_CONTEUDO;}

<PAGE_CONTEUDO,QUOTE_CONT>\*{quote_token}     {citacao = "";BEGIN QUOTE;}

<QUOTE>.*{quote_token}                        {yytext[yyleng-6] = '\0';citacao=strdup(yytext);
                                              BEGIN QUOTE_CONT;}

<QUOTE_CONT>\*\*{adulterados}                 {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ADULTERADOS;}

<QUOTE_CONT>\*\*{adulteracao}                 {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ADULTERADOS;}

<QUOTE_CONT>\*\*{alternativos}                {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ALTERNATIVOS;}

<ADULTERADOS>\*\*\*{quote_token}              {BEGIN QUOTES_ADULTERADOS;}

<ADULTERADOS>\*{quote_token}                  {BEGIN QUOTE;}

<ALTERNATIVOS>\*\*\*{quote_token}             {BEGIN QUOTES_ALTERNATIVOS;}

<ALTERNATIVOS>\*{quote_token}                 {BEGIN QUOTE;}

<ALTERNATIVOS>\*\*{adulterados}               {yytext[yyleng-20] = '\0'; BEGIN ADULTERADOS;}

<ALTERNATIVOS>\*\*{adulteracao}               {yytext[yyleng-20] = '\0'; BEGIN ADULTERADOS;}

<QUOTES_ADULTERADOS>.*{quote_token}           {adulterados++; yytext[yyleng-6] = '\0';
                                              printf("        - Adulterado: %s\n",yytext);
                                              BEGIN ADULTERADOS;}

<QUOTES_ALTERNATIVOS>.*{quote_token}          {alternativos++; yytext[yyleng-6] = '\0';
                                              printf("        - Alternativo: %s\n",yytext);
                                              BEGIN ALTERNATIVOS;}

<*>{fim_pag}                                  {BEGIN INITIAL;}
<*>.|\n                                       {;}
%%

int yywrap(){ return 1; }

int main(int argc, char* argv[]){
    printf("Organizado por título e citações (com os seus adulterados).\n\n");
    yylex();
    printf("\n\nNúmero de páginas: %d\n", paginas);
    printf("Número de páginas com título começado por 'Provérbios': %d\n", paginas_titulo);
    printf("Número de adulterações: %d\n", adulterados);
    printf("Número de alternativos: %d\n", alternativos);
    printf("Número de citações com adulterações ou alternativos: %d\n", quote);
    return 0;
}

// invoquem assim:
// bzcat ptwikiquote-20190301-pages-articles.xml.bz2 | ./filtro3 > saida.txt
