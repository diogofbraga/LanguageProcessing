#ifndef ESTRUTURAS_H
#define ESTRUTURAS_H
#endif


/**
@brief Estrutura que armazena o nome dum autor e a lista de citações que fez
*/
typedef struct Autor* Autor;

/**
@brief Estrutura que armazena uma Hash Table em que a chave é o nome do autor
    e o valor é um estrutura do tipo Autor.
*/
typedef struct TodasCitacoes* TodasCitacoes;

/**
@brief Função que cria uma estrutura do tipo Autor

@param novo_nome, É a string que contém um nome de autor

@returns Autor, Autor criado
*/
Autor createAutor(char* novo_nome);


/**
@brief Função que cria uma estrutura do tipo TodasCitacoes

@returns TodasCitacoes, Estrutura TodasCitacoes criada
*/
TodasCitacoes createTodasCitacoes();

/**
@brief Função que insere uma citação no respetivo autor.

@param tc, Estrutra do tipo TodasCitacoes onde será incluída a citação.
@param nome, Nome do autor a que pertence a citação.
@param citacao, Citação a ser inserida na estrutura

@returns TodasCitacoes, Estrutura TodasCitacoes criada
*/
void insereCitacao(TodasCitacoes tc, char* nome, char* citacao);

/**
@brief Função que imprime para ecrã a estrutura passada como parâmetro.

@param tc, Estrutura do tipo TodasCitacoes a ser imprimida.
*/
void imprimeCitacoes(TodasCitacoes tc);
