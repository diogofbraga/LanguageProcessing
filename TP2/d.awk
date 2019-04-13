BEGIN              { print "Dicionário: \n" }
                   { palavras[$3] = palavrasFunc($2,palavras[$3]); }
                   { res[$3] = "Lema: "$3"\t\t\t\t\tPalavras derivadas: "palavras[$3]; }
END                { asort(res); for(i in res) print res[i] }


function palavrasFunc(pal,l) {
    if( index(l,pal)==0 )
      l=l" "pal
    return l
}

#BEGIN             { c = 0; print "Dicionário: \n"} # FS = Separador de campo = ‘ ‘ (valor por omissão)
#                  { palavra[c] = $2; lema[c] = $3; pos[c] = $5;}
#                  { res[c] = "Lema: "lema[c]"\t\t\t\t\tPalavra derivada: "palavra[c]"\t\t\t\t\tPart Of Speech: "pos[c] }
#                  { c++ }
#END               { asort(res); for(i in res) print res[i] }


#BEGIN             { print "Dicionário: \n"} # FS = Separador de campo = ‘ ‘ (valor por omissão)
#                  { palavras[$2] = "Lema: "$3"\t\t\t\t\tPart Of Speech: "$5"\t\t\t\t\tPalavra derivada: "$2 }
#END               { asort(palavras); for(i in palavras) print palavras[i]; }

# asort -> awk sorts the values of 'palavras' and replaces the indices of the sorted values of 'palavras' with sequential integers starting with one

#     a["last"] = "de"
#     a["first"] = "sac"
#     a["middle"] = "cul"

#           |
#           v

#     a[1] = "cul"
#     a[2] = "de"
#     a[3] = "sac"
