BEGIN              { print "Dicionário: \n" }
                   { palPos = $2" -> "posGenSub($6)" \n\t\t\t\t\t\t\t\t\t\t";
                     palavras[$3] = palavrasFunc(palPos,palavras[$3]);
                     res[$3] = "Lema: "$3"\nPalavras derivadas: "palavras[$3]; }
END                { asort(res); for(i in res) print res[i] }


function palavrasFunc(pal,l) {
    if( index(l,pal)==0 )
      l=l" "pal
    return l
}

function posGenSub(p){
  gsub(/\|/," : ",p);
  return p
}


# index -> Search the string in for the first occurrence of the string find, and return the position in characters where that occurrence begins in the string in.

# $ awk 'BEGIN { print index("peanut", "an") }'
# -| 3

# If find is not found, index() returns zero.


# asort -> awk sorts the values of 'palavras' and replaces the indices of the sorted values of 'palavras' with sequential integers starting with one

#     a["last"] = "de"
#     a["first"] = "sac"
#     a["middle"] = "cul"

#           |
#           v

#     a[1] = "cul"
#     a[2] = "de"
#     a[3] = "sac"
