BEGIN                                               { "mkdir RESULTADOS_HTML" | getline ;}
$1=="1"                                             { extratos++; }
$2=="Harry" || $2=="Harry_Potter" || $2=="Potter"   { c["Harry Potter"]++; }
$2=="Hermione" || $2=="Hermione_Granger"		    { c["Hermione Ganger"]++; }
$2=="Ron" || $2=="Ron_Weasley"					    { c["Ron Weasley"]++;}
$2=="Dobby"										    { c["Dobby"]++;}
$2=="Draco" || $2=="Malfoy" || $2=="Draco_Malfoy"   { c["Draco Malfoy"]++;}
$2=="Dumbledore"								    { c["Dumbledore"]++;}
$2=="Hagrid" 									    { c["Rubeo Hagrid"]++;}
$2=="Minerva" || 	$2=="McGonagall"			    { c["Minerva McGonagall"]++;}
$2=="Snape"										    { c["Severo Snape"]++;}
$2=="Sirius" || $2=="Sirius_Black"				    { c["Sirius Black"]++;}
$2=="Neville" || $2=="Neville_Longbottom"		    { c["Neville Longbottom"]++;}
$6 ~ /pos=verb/                                     { verbos[$3]++;}
$6 ~ /pos=adjective/                                { adjectivos[$3]++;}
$6 ~ /pos=adverb/                                   { adverbios[$3]++;}
$6 ~ /pos=noun/                                     { substantivos[$3]++;}
                                                    { palPos = $2" -> "posExplanation($5)" \n\t\t\t\t\t\t\t\t\t\t";
                                                      palavras[$3] = palavrasFunc(palPos,palavras[$3]);
                                                      res[$3] = "<p><LI>Lema: "$3"</LI></p>Palavras derivadas: "palavras[$3]; }
END                                                 { make_index_html(extratos) ;
                                                      make_page_html("personagens"); for (i in c) {list_elem_html(i,"personagens")}; make_end_html("personagens");
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

function posExplanation(pos) {
    if(pos=="CC") return "CC: Conjunction Coordinating"
    if(pos=="Fc") return "Fc: Punctuation Comma"
    if(pos=="RG") return "RG: Adverb General"
    if(pos=="Z") return "Z: Number"
    if(pos=="NC") return "NC: Noun Common"
    if(pos=="AQ") return "AQ: Adjective Qualificative"
    if(pos=="VMI") return "VMI: Verb Main Indicative"
    if(pos=="VMP") return "VMP: Verb Main Pastparticiple"
    if(pos=="SP") return "SP: Adposition Preposition"
    if(pos=="PP") return "PP: Pronoun Personal"
    if(pos=="DA") return "DA: Determiner Article"
    if(pos=="VMN") return "VMN: Verb Main Infinitive"
    if(pos=="CS") return "CS: Conjunction Subordinating"
    if(pos=="DI") return "DI: Determiner Indefinite"
    if(pos=="DP") return "DA: Determiner Possessive"
    if(pos=="Fg") return "Fg: Punctuation Hyphen"
    if(pos=="PR") return "PR: Pronoun Relative"
    if(pos=="Fp") return "Fp: Punctuation Period"
    if(pos=="PD") return "PD: Pronoun Demonstrative"
    if(pos=="PR") return "PR: Pronoun Relative"
    if(pos=="Fit") return "Fit: Punctuation Questionmark"
    if(pos=="Fs") return "Fs: Punctuation Etc"
    if(pos=="Fat") return "Fat: Punctuation Exclamationmark"
    if(pos=="Fe") return "Fe: Punctuation Quotation"
    if(pos=="VMS") return "VMS: Verb Main Subjunctive"
    if(pos=="VMG") return "VMG: Verb Main Gerund"
    if(pos=="NP") return "NP: Noun Proper"
    if(pos=="VMM") return "VMM: Verb Main Imperative"
    if(pos=="PI") return "PI: Pronoun Indefinite"
    if(pos=="I") return "I: Interjection"
    if(pos=="Zp") return "Zp: Number Ratio"
    if(pos=="Fx") return "Fx: Punctuation Semicolon"
    if(pos=="Zu") return "Zu: Number Unit"
    if(pos=="Fra") return "Fra: Punctuation Quotation Open"
    if(pos=="Frc") return "Frc: Punctuation Quotation Close"
    if(pos=="RN") return "RN: Adverb Negative"
    if(pos=="Fz") return "Fz: Punctuation Other"
    if(pos=="AO") return "AO: Adjective Ordinal"
    if(pos=="Fpa") return "Fpa: Punctuation Parenthesis Open"
    if(pos=="Fpt") return "Fpt: Punctuation Parenthesis Close"
    if(pos=="W") return "W: Date"
}
