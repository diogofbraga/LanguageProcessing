BEGIN                                             {  }
$9~/sn:[0-9]+\(grup-nom-ms:[0-9]+\(w-ms:[0-9]+/   { c[$2]++; }
END                                               { for (i in c) {print i" : "c[i]} }
