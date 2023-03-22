---
title: | 
  | Građevinski fakultet
  | Odsek za geodeziju i geoinformatiku
  |
  | Analiza podataka u R-u
  |
subtitle: | 
  | 
  | Kontrola toka i funkcije
  |
author: |
  | Milutin Pejović
  | Petar Bursać  
date: "22 March 2023"
output:
   html_document:
     keep_md: true
     theme: "simplex"
     highlight: tango
     toc: true
     toc_depth: 5
     toc_float: true
     fig_caption: yes
     code_folding: "show"
---







# Kontrola toka u R-u

U okviru ovog predavanja upoznaćemo se sa mogućnostima kontrole toka i automatizacije izvršavanja komandi primenom komandi `if` i `for`. 


 \scriptsize

<img src="C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Figures/loops_R.png" width="503" style="display: block; margin: auto;" />

 \footnotesize


## `if` - grananje toka 

Komanda `if` omogućava da postavimo uslov kojim će izvršavanje neke komande zavisiti od rezultata nekog logičkog upita. Na taj način moguće je stvoriti razgranatu strukturu toka izvršavanja komandi (algoritma). Komanda `if` se koristi na sledeći način:

$$if(condition) \quad \textrm{{true_expression}} \quad elsе \quad \textrm{{false_expression}}$$ 

Na primer, ukoliko promenljiva `x` sadrži numerički podatak, podeliti ga sa 2, a ukoliko je neki drugi podatak ispisati "Nije moguće izvršiti komandu jer x ne sadrži numerički podatak"




 \scriptsize


```r
x <- 5
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")
## [1] 2.5
```

 \footnotesize

```
## [1] 2.5
```


 \scriptsize


```r
x <- "a"
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")
## [1] "Nije moguce izvršiti komandu jer x ne sadrži numericki podatak"
```

 \footnotesize

Ukoliko ne postoji određena operacija koja se uzvršava u slučaju `else`, nije potrebno pisati taj deo. Na primer:


 \scriptsize


```r
x <- 5
if(is.numeric(x)) x/2 
## [1] 2.5
```

 \footnotesize


 \scriptsize


```r
x <- "a"
if(is(x, "numeric")) x/2 
```

 \footnotesize


Međutim, pravi smisao `if` komande se vidi tek kada očekujemo da prilikom izvršavanja niza komandi računar sam odluči šta treba uraditi u određenom trenutku u zavisnosti od ulaznih parametara. 


## Kontrola toka `else if`

Kontrola toka `else if` se koristi u slučaju da postoji određena operacija koja se uzvršava u slučaju `else`


 \scriptsize


```r

y <- 12 # obratiti paznju sta se desava ako je broj 5

if (y < 5) {
  
  print("Manje od 5")

  } else if (y < 10 & y > 5) {

    print("Manje od 10 i vece od 5")
    
} else {

  print("Broj je veci od 10")
  
}
## [1] "Broj je veci od 10"
```

 \footnotesize



## `for` petlja

`for` petlja se koristi kada želimo da automatizujemo izvršavanje neke komande ili niza komandi određeni broj puta. `for` petlja se koristi na sledeći način:

$$ for(i \quad in \quad list) \quad \textrm{{expression}} $$



 \scriptsize


```r
# Kreirati vektor slučajnih brojeva normalne raspodele
u1 <- rnorm(30)
print("Ova petlja računa kvadrat prvih deset elemenata vektora u1.")
## [1] "Ova petlja racuna kvadrat prvih deset elemenata vektora u1."

# Inicijalizacija vektora 'kv'
kv <- 0 

for (i in 1:10) {
    # i-ti element od `u1` kvadriran i sačuvan na `i`-tu poziciju vektora `kv`
    kv[i] <- u1[i] * u1[i]
    print(kv[i])
}
## [1] 0.002723654
## [1] 1.553755
## [1] 0.2909362
## [1] 0.6062769
## [1] 0.4831593
## [1] 0.1111492
## [1] 1.205354
## [1] 0.1762565
## [1] 0.04151249
## [1] 0.6259462

print(i)
## [1] 10
```

 \footnotesize

### Ugnježdena `for` petlja

Predstavlja kombinaciju dve ili više for petlji (obratiti pažnju na indekse).


 \scriptsize


```r
# Dodeliti broj - dimenzije matrice
my_int <- 42

nr <- as.integer(my_int)

# Kreirati `n` x `n` matricu - praznu
mymat <- matrix(0, nr, nr)

# Za svaki red i za svaku kolonu, dodeliti vrednost baziranu na poziciji
# Vrednosti su produkt dva indeksa
for (i in 1:dim(mymat)[1]) {
    for (j in 1:dim(mymat)[2]) {
        mymat[i, j] = i * j
    }
}


head(mymat)
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## [1,]    1    2    3    4    5    6    7    8    9    10    11    12    13    14
## [2,]    2    4    6    8   10   12   14   16   18    20    22    24    26    28
## [3,]    3    6    9   12   15   18   21   24   27    30    33    36    39    42
## [4,]    4    8   12   16   20   24   28   32   36    40    44    48    52    56
## [5,]    5   10   15   20   25   30   35   40   45    50    55    60    65    70
## [6,]    6   12   18   24   30   36   42   48   54    60    66    72    78    84
##      [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22] [,23] [,24] [,25] [,26]
## [1,]    15    16    17    18    19    20    21    22    23    24    25    26
## [2,]    30    32    34    36    38    40    42    44    46    48    50    52
## [3,]    45    48    51    54    57    60    63    66    69    72    75    78
## [4,]    60    64    68    72    76    80    84    88    92    96   100   104
## [5,]    75    80    85    90    95   100   105   110   115   120   125   130
## [6,]    90    96   102   108   114   120   126   132   138   144   150   156
##      [,27] [,28] [,29] [,30] [,31] [,32] [,33] [,34] [,35] [,36] [,37] [,38]
## [1,]    27    28    29    30    31    32    33    34    35    36    37    38
## [2,]    54    56    58    60    62    64    66    68    70    72    74    76
## [3,]    81    84    87    90    93    96    99   102   105   108   111   114
## [4,]   108   112   116   120   124   128   132   136   140   144   148   152
## [5,]   135   140   145   150   155   160   165   170   175   180   185   190
## [6,]   162   168   174   180   186   192   198   204   210   216   222   228
##      [,39] [,40] [,41] [,42]
## [1,]    39    40    41    42
## [2,]    78    80    82    84
## [3,]   117   120   123   126
## [4,]   156   160   164   168
## [5,]   195   200   205   210
## [6,]   234   240   246   252
```

 \footnotesize


## `while` petlja

`while` petlja se koristi kada želimo da automatizujemo izvršavanje neke komande ili niza komandi samo u slučaju da je ispunjen određeni uslov. `while` petlja se koristi na sledeći način:

$$ while \textrm{(logički uslov)} \quad \textrm{{kod koji se izvršava dok je uslov TRUE}} $$


 \scriptsize


```r
i <- 1

while (i < 6) {
  print(i)
  i = i+1
}
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
```

 \footnotesize

## Primer korišćenja for i if zajedno

Na primer, ako želimo da podacima `studenti` dodamo jednu kolonu pod nazivom "ispit" u vidu logičkog vektora koji će sadržati vrednost TRUE za studente koji su položili oba ispita (IG1 i Praksu) i FALSE za one koji nisu.



 \scriptsize


```r
studenti <- read.csv(file = "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/data/Students_IG1.csv", header = TRUE, stringsAsFactors = FALSE)

studenti$ispit <- NA # Prvo cemo kreirati kolonu "ispit" koja ima sve NA vrednosti

# Komanda dim(studenti) vraca broj dimenzija, prvi se odnosi na broj vrsta.
dim(studenti)
## [1] 35 15
```

 \footnotesize



 \scriptsize


```r
for(i in 1:dim(studenti)[1]) { 
  # Sekvenca `1:dim(studenti)[1]` sadrzi niz brojeva od 1 do ukupnog broja vrsta u data.frame-u studenti.
  # i ide kroz svaku vrstu data.frame-a `studenti`
  
  studenti$ispit[i] <- if(is.na(studenti$Ocena[i]) | is.na(studenti$Praksa[i])){
    FALSE
  } else {
      TRUE
    }
}  

head(studenti, 15)
##    ID         Prezime        Ime br.ind god.upisa kol.1 kol.2 kol.1.1 kol.2.2
## 1   1       Antonijev      Boris   1035        16    NA    NA      NA      NA
## 2   2          Arvaji       Luka   1020        17    NA    NA      NA      NA
## 3   3           Babi?     Stefan   1051        16     0    NA      NA      NA
## 4   4          Beljin      Miloš   1019        17     0    NA      NA      NA
## 5   5 Boži? Krajišnik     Stefan   1041        16     0    NA      NA      NA
## 6   6           Brki? Aleksandar   1038        17     0    60      55      NA
## 7   7         Vasovi? Aleksandar   1031        17    40    85     100      NA
## 8   8           Vu?i?      Boban   1018        17    NA    NA      NA      NA
## 9   9       Garibovi?      Tarik   1027        17     0    NA      NA      NA
## 10 10          Gordi?     Nataša   1015        17     0    NA      NA      NA
## 11 11        Grujovi?   Katarina   1042        15    NA    NA      NA      NA
## 12 12    Dimitrijevi?      Jovan   1040        17    45    95      10      NA
## 13 13         Jovi?i?  Andrijana   1012        17    30    NA      NA      NA
## 14 14           Koci?     Danilo   1024        17     0    90     100      NA
## 15 15           Koci?     Stefan   1035        17     0    NA      NA      NA
##    Januar Februar Jun Ocena Praksa ispit
## 1      NA      40  51     7      9  TRUE
## 2      NA      NA  NA    NA     NA FALSE
## 3      NA      NA 100     7      8  TRUE
## 4      NA      10 100     8      8  TRUE
## 5      NA     100  NA     7      8  TRUE
## 6      NA      NA  NA     7     NA FALSE
## 7      NA      NA  NA     8      9  TRUE
## 8      NA       8  70     6      8  TRUE
## 9      NA      NA 100     6     NA FALSE
## 10     NA      82  NA     8      7  TRUE
## 11     NA      NA  90     8      8  TRUE
## 12     NA      80  NA     8      8  TRUE
## 13     NA      92  NA     8      8  TRUE
## 14     NA      NA  NA     9      9  TRUE
## 15     NA      24 100     9      8  TRUE
```

 \footnotesize



 \scriptsize


```r
sum(studenti$ispit) # Koliko studenata je polozilo oba ispita
## [1] 31
```

 \footnotesize


# Kreiranje funkcija

R omogućava kreranje funkcija koje nam omogućavaju da automatizujemo određene korake u našem algoritmu. Kreiranje funkcija je poželjno u slučajevima kada imamo određeni deo koda koji je potrebno ponoviti više puta. Na taj način, umesto da kopiramo kod više puta, moguće je kreirati funkciju koja će izvršiti taj deo koda pozivanjem kreirane funkcije. Generalno, kreiranje funkcija se sastoji iz tri koraka:

+ Dodeljivanje `imena`
+ Definisanje `argumenata`
+ Programiranje `tela` funckije (body) koje se sastoji od koda koji treba da se izvrši

Na primer ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u stepenima u radijane, to ćemo učiniti na sledeći način




 \scriptsize


```r
step2rad <- function(ang_step){
  ang_step*pi/180
}

step2rad(180)
## [1] 3.141593
```

 \footnotesize


Ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u zapis step-min-sec to ćemo uraditi na sledeći način:



 \scriptsize


```r
dec2dms <- function(ang){ # ime funkcije je `dec2dms`, a argument `ang`
  deg <- floor(ang) 
  minut <- floor((ang-deg)*60)
  sec <- ((ang-deg)*60-minut)*60
  return(paste(deg, minut, round(sec, 0), sep = " "))
}

dec2dms(ang = 35.26589)
## [1] "35 15 57"
```

 \footnotesize


 \scriptsize


```r
dec2dms(45.52658)
## [1] "45 31 36"
```

 \footnotesize


Primer korišćenja while kontrole toka sa funkcijom:


 \scriptsize


```r

# Korisnicki definisana funkcija
readinteger <- function(){
  n <- readline(prompt="Molim vas, unesite vas broj: ")
}

response <- as.integer(readinteger())

while (response!=42) {   
  print("Izvinite, odgovor na pitanje mora biti 42!");
  response <- as.integer(readinteger());
}

print(response)

```

 \footnotesize


> <h3>Zadatak</h3>
> + Ucitati csv fajl koji sadrži koordinate prelomnih tačaka jedne parcele [**parcela.csv**]. 
> + Podatke učitati tako da se formira objekat klase data.frame.
> + Preimenovati kolone data.frame tako da odgovaraju nazivima kolona u Gauss-Kruger-ovoj projekciji (ovde naziv kolone X odgovara Easting koordinati, dok naziv kolone Y odgovara Northing koordinati)
> + Dodati atribut ID - jedinstveni identifikator svake prelomne tačke
> + Napisati funkciju koja računa broj prelomnih tačaka parcele
> + Ulaz za funkciju je potrebno da bude data.frame.




