#include <glib.h>
#include "estruturas.h"

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
    au->quotes = g_list_append(au->quotes, quote);
}



struct TodasCitacoes{
    GHashTable* autor_quote;
};

Autor createTodasCitacoes() {
  TodasCitacoes tc = malloc(sizeof(struct TodasCitacoes));
  tc->autor_quote = g_hash_table_new(g_str_hash, g_str_equal);
  return tc;
}

void insereCitacao(TodasCitacoes tc, char* nome, char* citacao){
    Autor au = (Autor) g_hash_table_lookup(tc, (gpointer) nome);
    if(au == NULL){
        au = createAutor(nome);
        insertQuote(au,citacao);
        g_hash_table_insert(tc, (gpointer) nome, (gpointer) au);
        return;
    }
    insertQuote(au,citacao);
}
