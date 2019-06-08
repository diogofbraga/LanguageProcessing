#ifndef AUXILIARES_H
#define AUXILIARES_H
#endif

FILE* createFile(int num, char* pasta);

void makeheader(int tempo, FILE* file, int num);

void insertTitle(FILE* file, char* title);

void insertAudio(FILE* file, char* audio);

void insertItem(FILE* file, char* item);

void fileTermination(FILE* file);

void createLastFile(int num, char* pasta);
