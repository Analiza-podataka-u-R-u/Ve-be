# Ime:
# Prezime:
# Broj indeksa:
# Datum:
# Vežba broj: 
# ------------------------------------------------------------------------------

# Domaći zadatak broj 2

# Definisanje radnog direktorijuma
wdir <- "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Domaci_zadaci/Domaci_zadatak_broj_2/"
setwd(wdir)
getwd()

# Ucitavanje tabele sa studentima

tabela.studenti <- read.table(file = "Studenti_IG2_20_21.txt", sep = ",", header = TRUE)

tabela.studenti

class(tabela.studenti)
names(tabela.studenti)
str(tabela.studenti)

summary(tabela.studenti)

# Zadatak:
# 1. Selektovati sve studente koji su položili prvi kolokvijum.
# 2. Selektovati sve studente koji su položili drugi kolokvijum.
# 3. Selektovati sve studente kojima je godina upisa 17 i koji su položili prvi kolokvijum u junu.
# 4. Kreirati listu studenata sa dva elementa, oni koji su položili prvi kolokvijum i onih koji su položili drugi kolokvijum
# 5. Izmeniti vrednosti godine upisa tako da vrednosti budu u obliku 20xx (npr xx = 17)
# 6. Kreirati listu sa elementima po godini upisa i onih koji su položili ispit
# 7. Kreirati novu kolonu koja predstavlja vrednost ocene u zavisnoti od broja bodova (npr. student je položio ispit sa ocenom 6 ako broj bodova 51-60 itd)


