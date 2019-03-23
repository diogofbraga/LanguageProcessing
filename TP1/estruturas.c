#include <stdio.h>
#include <glib.h>
#include <gmodule.h>
#include "estruturas.h"


//////////////////////////////////// Autor ////////////////////////////////////
struct Autor{
   char* nome;
   GList* quotes;
};

Autor createAutor(char* novo_nome) {
  Autor a = malloc(sizeof(struct Autor));
  a->nome = strdup(novo_nome);
  a->quotes = NULL;
  return a;
}

void insertQuote(Autor au, char* quote){
    /**char* word = "\&quot;";
    deleteWord(quote,word);*/
    au->quotes = g_list_append(au->quotes, quote);
}


//////////////////////////////////// TodasCitações ////////////////////////////////////
struct TodasCitacoes{
    GHashTable* autor_quote;
};

TodasCitacoes createTodasCitacoes() {
  TodasCitacoes tc = malloc(sizeof(struct TodasCitacoes));
  tc->autor_quote = g_hash_table_new(g_str_hash, g_str_equal);
  return tc;
}

void insereCitacao(TodasCitacoes tc, char* nome, char* citacao){
    Autor au = (Autor) g_hash_table_lookup(tc->autor_quote, (gpointer) nome);
    if(au == NULL){
        au = createAutor(nome);
        insertQuote(au,citacao);
        g_hash_table_insert(tc->autor_quote, (gpointer) nome, (gpointer) au);
        return;
    }
    insertQuote(au,citacao);
}

void imprimeCitacoes(TodasCitacoes tc){
    GList* values = g_hash_table_get_values(tc->autor_quote);
    while(values != NULL){
        Autor a = (Autor) values->data;
        printf("\n\nAuthor: %s\n",a->nome );
        while(a->quotes != NULL){
            printf("    - Quote: %s\n",a->quotes->data);
            a->quotes = g_list_next(a->quotes);
        }
        values = g_list_next(values);
    }
}

//////////////////////////////////// Auxiliares ////////////////////////////////////



void deleteWord(char * str, char * toRemove){
    int i, j, stringLen, toRemoveLen;
    int found;

    stringLen   = strlen(str);      // Length of string
    toRemoveLen = strlen(toRemove); // Length of word to remove


    for(i=0; i <= stringLen - toRemoveLen; i++){
        /* Match word with string */
        found = 1;
        for(j=0; j<toRemoveLen; j++){
            if(str[i + j] != toRemove[j]){
                found = 0;
                break;
            }
        }

        /* If it is not a word */
        if(str[i + j] != ' ' && str[i + j] != '\t' && str[i + j] != '\n' && str[i + j] != '\0')
            found = 0;

        /*
         * If word is found then shift all characters to left
         * and decrement the string length
         */
        if(found == 1){
            for(j=i; j<=stringLen - toRemoveLen; j++)
                str[j] = str[j + toRemoveLen];

            stringLen = stringLen - toRemoveLen;

            // We will match next occurrence of word from current index.
            i--;
        }
    }
}
