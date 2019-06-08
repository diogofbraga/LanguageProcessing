#include <stdio.h>

FILE* createFile(int slide_counter, char* pasta){
    char file_name[100];
    sprintf(file_name, "%s/diap%d.html", pasta, slide_counter);
    return fopen(file_name, "w+");
}

void makeheader(int tempo, FILE* file, int slide_counter){
    char s[1024];
    sprintf(s,"<html>\n<head>\n\t<meta charset=\"UTF-8\"/>\n\t<meta http-equiv=\"REFRESH\" content=\"%d ;URL=diap%d.html\">\n</head>\n<body>\n", tempo, slide_counter+1);
    fputs(s, file);
}

void insertTitle(FILE* file, char* title){
    char s[1024];
    sprintf(s,"\t<h1>%s</h1>\n<hr/>\n", title);
    fputs(s, file);
}

void insertAudio(FILE* file, char* audio){
    char s[1024];
    sprintf(s,"\t<audio src=\"%s\" controls autoplay loop>\n\t<p>Seu nevegador não suporta o elemento audio.</p>\n\t</audio>\n<hr/>\n", audio);
    fputs(s, file);
}

void insertItem(FILE* file, char* item){
    char s[1024];
    sprintf(s,"\t<LI>%s</LI>\n", item);
    fputs(s, file);
}

void fileTermination(FILE* file){
    char s[1024];
    sprintf(s,"</body>\n</html>");
    fputs(s, file);
    fclose(file);
}

void createLastFile(int slide_counter, char* pasta){
    FILE* file = createFile(slide_counter+1, pasta);
    char s[1024];
    sprintf(s,"<html>\n");
    fputs(s,file);
    insertTitle(file, "Estatísticas do Diaporama");
    fprintf(file, "\t<LI>Número total de slides: %d</LI>\n", slide_counter );
    fclose(file);
}
