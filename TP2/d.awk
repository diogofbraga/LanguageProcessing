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
