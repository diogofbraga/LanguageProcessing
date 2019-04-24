BEGIN            															 {  } # FS = Separador de campo = ‘ ‘ (valor por omissão)

$2=="Harry" || $2=="Harry_Potter" || $2=="Potter"			  			     { c["Harry Potter"]++; }
$2=="Hermione" || $2=="Hermione_Granger"									 { c["Hermione Ganger"]++; }
$2=="Ron" || $2=="Ron_Weasley"												 { c["Ron Weasley"]++;}
$2=="Dobby"																	 { c["Dobby"]++;}
$2=="Draco" || $2=="Malfoy" || $2=="Draco_Malfoy"							 { c["Draco Malfoy"]++;}
$2=="Dumbledore"															 { c["Dumbledore"]++;}
$2=="Hagrid" 																 { c["Rubeo Hagrid"]++;}
$2=="Minerva" || 	$2=="McGonagall"										 { c["Minerva McGonagall"]++;}
$2=="Snape"																	 { c["Severo Snape"]++;}
$2=="Sirius" || $2=="Sirius_Black"										     { c["Sirius Black"]++;}
$2=="Neville" || $2=="Neville_Longbottom"									 { c["Neville Longbottom"]++;}

END               															 { for (i in c) {print i" : "c[i]}}
								