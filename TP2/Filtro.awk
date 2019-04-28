BEGIN                                               { "mkdir -p RESULTADOS_HTML" | getline ;}
$1=="1"                                             { extratos++; }
$9~/sn:[0-9]+\(grup-nom-ms:[0-9]+\(w-ms:[0-9]+/     { c[$2]++; }
$6 ~ /pos=verb/                                     { verbos[$3]++;}
$6 ~ /pos=adjective/                                { adjectivos[$3]++;}
$6 ~ /pos=adverb/                                   { adverbios[$3]++;}
$6 ~ /pos=noun/                                     { substantivos[$3]++;}
                                                    { palPos = $2" -> "posGenSub($6)" \n\t\t\t\t\t\t\t\t\t\t";
                                                      palavras[$3] = palavrasFunc(palPos,palavras[$3]);
                                                      res[$3] = "<p><LI>Lema: "$3"</LI></p>Palavras derivadas: "palavras[$3]; }
END                                                 { make_index_html(extratos) ;
                                                      make_page_html("personagens"); for (i in c) {list_elem_html((i" : "c[i]),"personagens")}; make_end_html("personagens");
                                                      make_page_html("verbos"); for(verbo in verbos) {list_elem_html(verbo,"verbos")}; make_end_html("verbos");
                                                      make_page_html("adjectivos"); for(adej in adjectivos) {list_elem_html(adej,"adjectivos")}; make_end_html("adjectivos");
                                                      make_page_html("adverbios"); for(adv in adverbios) {list_elem_html(adv,"adverbios")}; make_end_html("adverbios");
                                                      make_page_html("substantivos"); for(subs in substantivos) {list_elem_html(subs,"substantivos")}; make_end_html("substantivos");
                                                      asort(res); make_page_html("dicionario"); for(i in res) {write_elem_html(res[i],"dicionario")}; make_end_html("dicionario");
                                                      }

function make_index_html(extr){
    print "<html>\n" > "RESULTADOS_HTML/index.html";
    print "<title>Resultados dos Exercícios</title>" >> "RESULTADOS_HTML/index.html";
    print "<h1>Exercício 5.a)</h1>" >> "RESULTADOS_HTML/index.html";
    print "<LI> Número de Extratos: " extr " </LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<h1>Exercício 5.b)</h1>" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"personagens.html\">Personagens</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<h1>Exercício 5.c)</h1>" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"verbos.html\">Verbos</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"substantivos.html\">Substantivos</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"adjectivos.html\">Adjectivos</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"adverbios.html\">Advérbios</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "<h1>Exercício 5.d)</h1>" >> "RESULTADOS_HTML/index.html";
    print "<LI><a href=\"dicionario.html\">Dicionário</a></LI>\n" >> "RESULTADOS_HTML/index.html";
    print "</html>" >> "RESULTADOS_HTML/index.html"
}

function make_page_html(arg){
    print "<html>" > "RESULTADOS_HTML/" arg ".html" ;
    print "<title>" arg "</title>" >> "RESULTADOS_HTML/" arg ".html";
    print "<h1>" arg "</h1>" >> "RESULTADOS_HTML/" arg ".html";
}

function list_elem_html(elem,filename){
    print "<LI>" elem "</LI>" >> "RESULTADOS_HTML/" filename ".html";
}

function write_elem_html(elem,filename){
    print "<p>" elem "</p>" >> "RESULTADOS_HTML/" filename ".html";
}

function make_end_html(arg){
    print "</html>" >> "RESULTADOS_HTML/" arg ".html";
}

function palavrasFunc(pal,l) {
    if( index(l,pal)==0 )
      l=l" <p><span style=\"margin-left:8em\">"pal"</span></p>"
    return l
}

function posGenSub(p){
  gsub(/\|/," : ",p);
  return p
}
