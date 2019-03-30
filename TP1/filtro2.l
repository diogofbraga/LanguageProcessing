%{
#include <stdio.h>

int paginas = 0;
int paginas_titulo = 0;
int quote = 0;
%}
espaco          (\ )
espacos         [ ]*
nova_pag        \<page\>
fim_pag         \<\/page\>
ini_tit         \<title\>
fim_tit         \<\/title\>
quote_token     {espacos}\&quot\;{espacos}
letras          ([A-Za-z]+)
especiais       (\[)

%x PAGE
%x PAGE_CONTEUDO CONTEUDO_TURQ_BUL_CHI_HOL CONTEUDO_VEN_POL CONTEUDO_RUS CONTEUDO_GAL_JAP_ALE CONTEUDO_LAT CONTEUDO_CORS_EGI CONTEUDO_ITA CONTEUDO_ISR CONTEUDO_ESP CONTEUDO_FRA CONTEUDO_TUN CONTEUDO_ARA
%x QUOTE QUOTE_TURQ_BUL_CHI_HOL QUOTE_VEN_POL QUOTE_RUS QUOTE_GAL_JAP_ALE QUOTE_LAT QUOTE_CORS_EGI QUOTE_ITA QUOTE_ISR QUOTE_ESP QUOTE_FRA QUOTE_TUN QUOTE_ARA
%%
{nova_pag}                                                   {paginas++; BEGIN PAGE;}

<PAGE>{ini_tit}Provérbios{espacos}turcos{fim_tit}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}

<PAGE>{ini_tit}Provérbios{espacos}búlgaros{fim_tit}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}

<PAGE>{ini_tit}Provérbios{espacos}chineses{fim_tit}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}

<PAGE>{ini_tit}Provérbios{espacos}holandeses{fim_tit}  {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}

<PAGE>{ini_tit}Provérbios{espacos}venezuelanos{fim_tit}  {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                  printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_VEN_POL;}

<PAGE>{ini_tit}Provérbios{espacos}poloneses{fim_tit}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_VEN_POL;}

<PAGE>{ini_tit}Provérbios{espacos}russos{fim_tit}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_RUS;}

<PAGE>{ini_tit}Provérbios{espaco}galegos{fim_tit}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_GAL_JAP_ALE;}

<PAGE>{ini_tit}Provérbios{espacos}japoneses{fim_tit}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_GAL_JAP_ALE;}

<PAGE>{ini_tit}Provérbios{espacos}córsicos{fim_tit}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_CORS_EGI;}

<PAGE>{ini_tit}Provérbios{espacos}alemães{fim_tit}     {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_GAL_JAP_ALE;}

<PAGE>{ini_tit}Provérbios{espacos}latinos{fim_tit}     {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_LAT;}

<PAGE>{ini_tit}Provérbios{espacos}italianos{fim_tit}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_ITA;}

<PAGE>{ini_tit}Provérbios{espacos}egípcios{fim_tit}    {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_CORS_EGI;}

<PAGE>{ini_tit}Provérbios{espacos}israelenses{fim_tit} {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_ISR;}

<PAGE>{ini_tit}Provérbios{espacos}espanhóis{fim_tit}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_ESP;}

<PAGE>{ini_tit}Provérbios{espacos}franceses{fim_tit}   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_FRA;}

<PAGE>{ini_tit}Provérbios{espacos}tunisianos{fim_tit}  {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_TUN;}

<PAGE>{ini_tit}Provérbios{espacos}árabes{fim_tit}      {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN CONTEUDO_ARA;}

<PAGE>{ini_tit}Provérbios.*{fim_tit}                   {yytext = yytext+7; paginas_titulo++; yytext[yyleng-15] = '\0';
                                                                printf("\nTitle: %s\n\n",yytext); BEGIN PAGE_CONTEUDO;}


<PAGE_CONTEUDO>\*{quote_token}                         {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>\*{quote_token}''                       {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>\*{quote_token}'''                      {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>\*{espacos}''{quote_token}              {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>\*{espacos}'''{quote_token}             {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>\*\*{espacos}''{quote_token}            {quote++; BEGIN QUOTE;}
<PAGE_CONTEUDO>:{espacos}'''{quote_token}              {quote++; BEGIN QUOTE;}


<CONTEUDO_TURQ_BUL_CHI_HOL>\*{quote_token}             {quote++; BEGIN QUOTE_TURQ_BUL_CHI_HOL;}
<CONTEUDO_TURQ_BUL_CHI_HOL>\*{espacos}                 {quote++; BEGIN QUOTE_TURQ_BUL_CHI_HOL;}


<CONTEUDO_VEN_POL>\*{quote_token}                      {quote++; BEGIN QUOTE_VEN_POL;}
<CONTEUDO_VEN_POL>\*{espacos}/{letras}                 {quote++; BEGIN QUOTE_VEN_POL;}
<CONTEUDO_VEN_POL>\*{espacos}/{especiais}              {quote++; BEGIN QUOTE_VEN_POL;}


<CONTEUDO_RUS>\n\*{espaco}                             {quote++; BEGIN QUOTE_RUS;}
<CONTEUDO_RUS>\*{quote_token}                          {quote++; BEGIN QUOTE_RUS;}


<CONTEUDO_GAL_JAP_ALE>\n\*{espacos}'''                 {quote++; BEGIN QUOTE_GAL_JAP_ALE;}
<CONTEUDO_GAL_JAP_ALE>\n\*{espacos}''                  {quote++; BEGIN QUOTE_GAL_JAP_ALE;}
<CONTEUDO_GAL_JAP_ALE>\n\*{espacos}''{quote_token}     {quote++; BEGIN QUOTE_GAL_JAP_ALE;}


<CONTEUDO_LAT>\n\*{espacos}''                          {quote++; BEGIN QUOTE_LAT;}
<CONTEUDO_LAT>\n\*{quote_token}                        {quote++; BEGIN QUOTE_LAT;}
<CONTEUDO_LAT>\n\*{espacos}/{letras}                   {quote++; BEGIN QUOTE_LAT;}


<CONTEUDO_CORS_EGI>\*{espacos}'''                      {quote++; BEGIN QUOTE_CORS_EGI;}
<CONTEUDO_CORS_EGI>\:{espacos}'''                      {quote++; BEGIN QUOTE_CORS_EGI;}
<CONTEUDO_CORS_EGI>^'''                                {quote++; BEGIN QUOTE_CORS_EGI;}


<CONTEUDO_ITA>\n\*{espacos}''                          {quote++; BEGIN QUOTE_ITA;}
<CONTEUDO_ITA>\n\*{espacos}''{quote_token}             {quote++; BEGIN QUOTE_ITA;}


<CONTEUDO_ISR>\n\*{espacos}'''                         {quote++; BEGIN QUOTE_ISR;}
<CONTEUDO_ISR>\n\*{espacos}/{letras}                   {quote++; BEGIN QUOTE_ISR;}


<CONTEUDO_ESP>\n\*{espacos}/{letras}                   {quote++; BEGIN QUOTE_ESP;}
<CONTEUDO_ESP>\n\*{espacos}''/{letras}                 {quote++; BEGIN QUOTE_ESP;}
<CONTEUDO_ESP>\n\*{espacos}'''/{letras}                {quote++; BEGIN QUOTE_ESP;}
<CONTEUDO_ESP>\n\*{quote_token}                        {quote++; BEGIN QUOTE_ESP;}


<CONTEUDO_FRA>\n\*{quote_token}                        {quote++; BEGIN QUOTE_FRA;}
<CONTEUDO_FRA>\n/[QD]                                  {quote++; BEGIN QUOTE_FRA;}


<CONTEUDO_TUN>\*{espacos}“''                           {quote++; BEGIN QUOTE_TUN;}


<CONTEUDO_ARA>\n\*{espacos}                            {quote++; BEGIN QUOTE_ARA;}



<QUOTE>.+'''{quote_token}                              {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN PAGE_CONTEUDO;}
<QUOTE>.+''{quote_token}                               {yytext[yyleng-8] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN PAGE_CONTEUDO;}
<QUOTE>.+{quote_token}                                 {yytext[yyleng-6] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN PAGE_CONTEUDO;}
<QUOTE>.+{quote_token}''                               {yytext[yyleng-8] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN PAGE_CONTEUDO;}
<QUOTE>.+{quote_token}'''                              {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN PAGE_CONTEUDO;}


<QUOTE_TURQ_BUL_CHI_HOL>.+{quote_token}\n              {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}
<QUOTE_TURQ_BUL_CHI_HOL>.+{quote_token}.\n             {yytext[yyleng-8] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}
<QUOTE_TURQ_BUL_CHI_HOL>.+\n                           {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_TURQ_BUL_CHI_HOL;}


<QUOTE_VEN_POL>.+{quote_token}\n                       {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_VEN_POL;}
<QUOTE_VEN_POL>.+\n                                    {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_VEN_POL;}


<QUOTE_RUS>.+{quote_token}\n                           {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_RUS;}
<QUOTE_RUS>.+\n                                        {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_RUS;}


<QUOTE_GAL_JAP_ALE>.+''\n                              {yytext[yyleng-3] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_GAL_JAP_ALE;}
<QUOTE_GAL_JAP_ALE>.+'''\n                             {yytext[yyleng-4] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_GAL_JAP_ALE;}
<QUOTE_GAL_JAP_ALE>.+''.\n                             {yytext[yyleng-4] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_GAL_JAP_ALE;}
<QUOTE_GAL_JAP_ALE>.+\n                                {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_GAL_JAP_ALE;}
<QUOTE_GAL_JAP_ALE>.+{quote_token}.''\n                {yytext[yyleng-10] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_GAL_JAP_ALE;}


<QUOTE_LAT>.+''\n                                      {yytext[yyleng-3] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_LAT;}
<QUOTE_LAT>.+\n                                        {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_LAT;}


<QUOTE_CORS_EGI>.+'''                                  {yytext[yyleng-3] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_CORS_EGI;}


<QUOTE_ITA>.+''                                        {yytext[yyleng-2] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ITA;}
<QUOTE_ITA>.+{quote_token}''\n                         {yytext[yyleng-9] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ITA;}


<QUOTE_ISR>.+'''\n                                     {yytext[yyleng-4] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ISR;}
<QUOTE_ISR>.+\n                                        {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ISR;}


<QUOTE_ESP>.+'''\n                                     {yytext[yyleng-4] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ESP;}
<QUOTE_ESP>.+''\n                                      {yytext[yyleng-3] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ESP;}
<QUOTE_ESP>.+{quote_token}\n                           {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ESP;}
<QUOTE_ESP>.+\n                                        {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ESP;}


<QUOTE_FRA>.+{quote_token}\n                           {yytext[yyleng-7] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_FRA;}
<QUOTE_FRA>.+\n                                        {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_FRA;}


<QUOTE_TUN>.+\,/&lt;ref&gt;JUSTO,                      {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_TUN;}


<QUOTE_ARA>[^\n]+                                      {yytext[yyleng-1] = '\0'; printf("    - Quote: %s\n",yytext);
                                                       BEGIN CONTEUDO_ARA;}


<*>{fim_pag}                                        {BEGIN INITIAL;}
<*>.|\n                                                {;}
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
