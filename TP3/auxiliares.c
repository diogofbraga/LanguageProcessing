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

void makeheaderStyle(int tempo, FILE* file, int slide_counter, char* style_file){
    char s[1024];
    sprintf(s,"<html>\n<head>\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../CSS/%s\">\t<meta charset=\"UTF-8\"/>\n\t<meta http-equiv=\"REFRESH\" content=\"%d ;URL=diap%d.html\">\n</head>\n<body class=\"box\">\n", style_file, tempo, slide_counter+1);
    fputs(s, file);
}

void insertTitle(FILE* file, char* title){
    char s[1024];
    sprintf(s,"\t<h1 class=\"title\">%s</h1>\n\t<hr/>\n", title);
    fputs(s, file);
}

void insertAudio(FILE* file, char* audio){
    char s[1024];
    sprintf(s,"\t<audio src=\"%s\" controls autoplay loop class=\"center\">\n\t<p>Seu navegador não suporta o elemento audio.</p>\n\t</audio>\n<hr/>\n", audio);
    fputs(s, file);
}

void insertItem(FILE* file, char* item){
    char s[1024];
    sprintf(s,"\t<LI>%s</LI>\n", item);
    fputs(s, file);
}

void insertCred(FILE* file, char* cred){
    char s[1024];
    sprintf(s,"\t<p class=\"title\">%s</p>\n", cred);
    fputs(s, file);
}

void insertImage(FILE* file, char* image){
    char s[1024];
    sprintf(s,"\t<img src=\"../Images/%s\" class=\"center\">\n", image);
    fputs(s, file);
}

void insertImageSize(FILE* file, char* image, int width, int height){
    char s[1024];
    sprintf(s,"\t<img src=\"../Images/%s\" width=\"%d\" height=\"%d\" class=\"center\">\n", image, width, height);
    fputs(s, file);
}

void insertVideo(FILE* file, char* video){
    char s[1024];
    sprintf(s,"\t<iframe src=\"%s\" class=\"center\"></iframe>\n", video);
    fputs(s, file);
}

void insertVideoSize(FILE* file, char* video, int width, int height){
    char s[1024];
    sprintf(s,"\t<iframe src=\"%s\" width=\"%d\" height=\"%d\" class=\"center\"></iframe>\n", video, width, height);
    fputs(s, file);
}

void insertLineBreak(FILE* file){
    char s[7] = "\t<br>\n";
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
    sprintf(s,"</html>\n");
    fputs(s,file);
    fclose(file);
}

void createLastFileStyle(int slide_counter, char* pasta, char* style_file){
    FILE* file = createFile(slide_counter+1, pasta);
    char s[1024];
    fprintf(file,"<html>\n\t<link rel=\"stylesheet\" type=\"text/css\" href=\"../CSS/%s\">\n<body class=\"box\">", style_file);
    fputs(s,file);
    insertTitle(file, "Estatísticas do Diaporama");
    fprintf(file, "\t<LI>Número total de slides: %d</LI>\n", slide_counter );
    sprintf(s,"</body>\n</html>\n");
    fputs(s,file);
    fclose(file);
}
