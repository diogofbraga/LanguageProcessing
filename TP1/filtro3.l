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

%x PAGE P_C QUOTE ADULT ALTER Q_ADULT Q_ALTER Q_C
%%
{nova_pag}                                    {paginas++; BEGIN PAGE;}

<PAGE>{ini_tit}Provérbios.*{fim_tit}          {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                              printf("\nTitle: %s\n\n",yytext); BEGIN P_C;}

<P_C,Q_C>\*{quote_token}                      {citacao = "";BEGIN QUOTE;}

<QUOTE>.*{quote_token}                        {yytext[yyleng-6] = '\0';citacao=strdup(yytext);
                                              BEGIN Q_C;}

<Q_C>\*\*{adulterados}                      {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ADULT;}

<Q_C>\*\*{adulteracao}                      {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ADULT;}

<Q_C>\*\*{alternativos}                     {quote++;printf("    - Quote: %s\n",citacao);
                                              BEGIN ALTER;}

<ADULT>\*\*\*{quote_token}                    {BEGIN Q_ADULT;}

<ADULT>\*{quote_token}                        {BEGIN QUOTE;}

<ALTER>\*\*\*{quote_token}                    {BEGIN Q_ALTER;}

<ALTER>\*{quote_token}                        {BEGIN QUOTE;}

<ALTER>\*\*{adulterados}                      {yytext[yyleng-20] = '\0'; BEGIN ADULT;}

<ALTER>\*\*{adulteracao}                      {yytext[yyleng-20] = '\0'; BEGIN ADULT;}

<Q_ADULT>.*{quote_token}                      {adulterados++; yytext[yyleng-6] = '\0';
                                              printf("        - Adulterado: %s\n",yytext);
                                              BEGIN ADULT;}

<Q_ALTER>.*{quote_token}                      {alternativos++; yytext[yyleng-6] = '\0';
                                              printf("        - Alternativo: %s\n",yytext);
                                              BEGIN ALTER;}

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
