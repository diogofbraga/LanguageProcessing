BEGIN             { c=0 }
$1=="1"           { c++ }
END               { print "Número de extratos: "c }
