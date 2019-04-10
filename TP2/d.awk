BEGIN             { print "Dicionário: \n"} # FS = Separador de campo = ‘ ‘ (valor por omissão)
                  { palavras[$2] = "Lema: "$3"\t\t\t\t\tPart Of Speech: "$5"\t\t\t\t\tPalavra derivada: "$2 }
END               { asort(palavras); for(i in palavras) print palavras[i]; }


# asort -> awk sorts the values of 'palavras' and replaces the indices of the sorted values of 'palavras' with sequential integers starting with one

#     a["last"] = "de"
#     a["first"] = "sac"
#     a["middle"] = "cul"

#           |
#           v

#     a[1] = "cul"
#     a[2] = "de"
#     a[3] = "sac"
