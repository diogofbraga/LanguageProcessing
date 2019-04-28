BEGIN                   { "mkdir -p C_HTML" | getline ; make_index_html();}
$6 ~ /pos=verb/         { verbos[$3]++;}
$6 ~ /pos=adjective/    { adjectivos[$3]++;}
$6 ~ /pos=adverb/       { adverbios[$3]++;}
$6 ~ /pos=noun/         { substantivos[$3]++;}
END                     {  make_page_html("verbos"); for(verbo in verbos) {list_elem_html(verbo,"verbos")}; make_end_html("verbos");
                           make_page_html("adjectivos"); for(adej in adjectivos) {list_elem_html(adej,"adjectivos")}; make_end_html("adjectivos");
                           make_page_html("adverbios"); for(adv in adverbios) {list_elem_html(adv,"adverbios")}; make_end_html("adverbios");
                           make_page_html("substantivos"); for(subs in substantivos) {list_elem_html(subs,"substantivos")}; make_end_html("substantivos");}

func make_index_html(){
    print "<html>\n" > "C_HTML/index.html";
    print "<title>Exercício 5.c)</title>" >> "C_HTML/index.html";
    print "<h1>Exercício 5.c)</h1>" >> "C_HTML/index.html";
    print "<LI><a href=\"verbos.html\">Verbos</a></LI>\n" >> "C_HTML/index.html";
    print "<LI><a href=\"substantivos.html\">Substantivos</a></LI>\n" >> "C_HTML/index.html";
    print "<LI><a href=\"adjectivos.html\">Adjectivos</a></LI>\n" >> "C_HTML/index.html";
    print "<LI><a href=\"adverbios.html\">Advérbios</a></LI>\n" >> "C_HTML/index.html";
    print "</html>" >> "C_HTML/index.html"
}

func make_page_html(arg){
    print "<html>" > "C_HTML/" arg ".html" ;
    print "<title>" arg "</title>" >> "C_HTML/" arg ".html";
    print "<h1>" arg "</h1>" >> "C_HTML/" arg ".html";
}

func list_elem_html(elem,filename){
    print "<LI>" elem "</LI>" >> "C_HTML/" filename ".html";
}

func make_end_html(arg){
    print "</html>" >> "C_HTML/" arg ".html";
}
