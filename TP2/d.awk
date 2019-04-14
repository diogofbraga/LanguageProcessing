BEGIN              { print "Dicionário: \n" }
                   { palPos = $2" -> "posExplanation($5)" \n\t\t\t\t\t\t\t\t\t\t";
                     palavras[$3] = palavrasFunc(palPos,palavras[$3]);
                     res[$3] = "Lema: "$3"\nPalavras derivadas: "palavras[$3]; }
END                { asort(res); for(i in res) print res[i] }


function palavrasFunc(pal,l) {
    if( index(l,pal)==0 )
      l=l" "pal
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
