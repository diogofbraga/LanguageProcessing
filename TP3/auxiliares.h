#ifndef AUXILIARES_H
#define AUXILIARES_H
#endif

FILE* createFile(int num, char* pasta);

void makeheader(int tempo, FILE* file, int num);

void makeheaderStyle(int tempo, FILE* file, int num, char* style_file);

void insertTitle(FILE* file, char* title);

void insertAudio(FILE* file, char* audio);

void insertItem(FILE* file, char* item);

void insertImage(FILE* file, char* image);

void insertImageSize(FILE* file, char* image, int width, int height);

void insertVideo(FILE* file, char* video);

void insertVideoSize(FILE* file, char* video, int width, int height);

void insertLineBreak(FILE* file);

void fileTermination(FILE* file);

void createLastFile(int num, char* pasta);

void createLastFileStyle(int num, char* pasta, char* style_file);
