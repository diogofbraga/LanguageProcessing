BEGIN             { c=0; } # FS = Separador de campo = ‘ ‘ (valor por omissão)
$1=="1"           { c++; }
END               { print "Número de extratos: " c }
