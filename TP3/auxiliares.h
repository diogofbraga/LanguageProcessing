#ifndef AUXILIARES_H
#define AUXILIARES_H
#endif

/*
 * Função: createFile
 * ----------------------------
 *   Retorna o ficheiro criado para futura utilização.
 *
 *   @param num: número do ficheiro a ser criado;
 *   @param pasta: nome da pasta onde o ficheiro vai ser incluído
 *
 *   returns: FILE* que é o ficheiro criado
 */
FILE* createFile(int num, char* pasta);

/*
 * Função: makeheader
 * ----------------------------
 *   Insere um header ao ficheiro HTML.
 *
 *   @param tempo: indica o tempo da disposição da página HTML;
 *   @param file: indica em que ficheiro o cabeçalho vai ser colocado;
 *   @param num: indica o numero do ficheiro atual.
 */
void makeheader(int tempo, FILE* file, int num);


/*
 * Função: makeheaderStyle
 * ----------------------------
 *   Insere um header ao ficheiro HTML com um dado estilo CSS.
 *
 *   @param tempo: indica o tempo da disposição da página HTML;
 *   @param file: indica em que ficheiro o cabeçalho vai ser colocado;
 *   @param num: indica o numero do ficheiro atual;
 *   @param style_file: indica o ficheiro CSS onde se encontra o style a usar.
 */
void makeheaderStyle(int tempo, FILE* file, int num, char* style_file);

/*
 * Função: insertTitle
 * ----------------------------
 *   Insere um título ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o título vai ser colocado;
 *   @param tile: indica o título a acrescentar.
 */
void insertTitle(FILE* file, char* title);

/*
 * Função: insertAudio
 * ----------------------------
 *   Insere um áudio ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o áudio vai ser colocado;
 *   @param audio: indica o audio a acrescentar.
 */
void insertAudio(FILE* file, char* audio);

/*
 * Função: insertItem
 * ----------------------------
 *   Insere um item ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o item vai ser colocado;
 *   @param item: indica o item a acrescentar.
 */
void insertItem(FILE* file, char* item);

/*
 * Função: insertCred
 * ----------------------------
 *   Insere um crédito ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o crédito vai ser colocado;
 *   @param cred: indica o crédito a acrescentar.
 */
void insertCred(FILE* file, char* cred);

/*
 * Função: insertImage
 * ----------------------------
 *   Insere uma imagem ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro a imagem vai ser colocada;
 *   @param image: indica a imagem a acrescentar.
 */
void insertImage(FILE* file, char* image);

/*
 * Função: insertImageSize
 * ----------------------------
 *   Insere uma imagem com uma dada largura e altura ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro a imagem vai ser colocada;
 *   @param image: indica a imagem a acrescentar;
 *   @param width: indica a largura da imagem;
 *   @param height: indica a altura da imagem.
 */
void insertImageSize(FILE* file, char* image, int width, int height);

/*
 * Função: insertVideo
 * ----------------------------
 *   Insere um vídeo ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o vídeo vai ser colocado;
 *   @param video: indica o vídeo a acrescentar.
 */
void insertVideo(FILE* file, char* video);

/*
 * Função: insertVideoSize
 * ----------------------------
 *   Insere um vídeo ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro o vídeo vai ser colocado;
 *   @param video: indica o vídeo a acrescentar;
 *   @param width: indica a largura do vídeo;
 *   @param height: indica a altura do vídeo.
 */
void insertVideoSize(FILE* file, char* video, int width, int height);

/*
 * Função: insertLineBreak
 * ----------------------------
 *   Insere uma LineBreak ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro a LineBreak vai ser colocada;
 */
void insertLineBreak(FILE* file);

/*
 * Função: fileTermination
 * ----------------------------
 *   Insere uma sequência final ao ficheiro HTML.
 *
 *   @param file: indica em que ficheiro a sequência final vai ser colocada;
 */
void fileTermination(FILE* file);

/*
 * Função: createLastFile
 * ----------------------------
 *   Cria um ficheiro HTML que porventura é o último.
 *
 *   @param num: indica o número do ficheiro a ser criado;
 *   @param pasta: indica a pasta onde o ficheiro deve ser colocado.
 */
void createLastFile(int num, char* pasta);

/*
 * Função: createLastFile
 * ----------------------------
 *   Cria um ficheiro HTML que porventura é o último e que contém um estilo.
 *
 *   @param num: indica o número do ficheiro a ser criado;
 *   @param pasta: indica a pasta onde o ficheiro deve ser colocado;
 *   @param style_file: indica o ficheiro CSS onde se encontra o style a usar.
 */
void createLastFileStyle(int num, char* pasta, char* style_file);
