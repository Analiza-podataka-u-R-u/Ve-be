---
title: | 
  | Građevinski fakultet
  | Odsek za geodeziju i geoinformatiku
  |
  | Analiza podataka u R-u
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





# Strukture podataka u R-u

Podsetićemo se na početku osnovnih struktura podataka u R-u.


 \scriptsize

<img src="C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Figures/strukture_podataka.jpg" width="487" style="display: block; margin: auto;" />

 \footnotesize


# Osnovni tipovi i klase podataka u R-u


## Atomic vectors



 \scriptsize


```r
v1 <- c(1, 2, 3, 4, 5, 6)

v2 <- 1:6

is.vector(v1)
## [1] TRUE
```

 \footnotesize


### Tipovi podatka

R razlikuje šest osnovnih tipova podatka, a to su *doubles, integers, characters, logicals, complex, and raw*. Tip podatka je obično poznat autoru koda, međutim ukoliko ima potrebe da se sazna kojeg je tipa određeni podatak skladišten u nekom vektoru, to moguće saznati pozivom komandom `typeof`: 

#### Double


 \scriptsize


```r

typeof(v1)
## [1] "double"
```

 \footnotesize

#### Integer



 \scriptsize


```r
v3 <- c(1L, 2L, 3L, 4L, 5L, 6L)

typeof(v3)
## [1] "integer"
```

 \footnotesize



#### Characters


 \scriptsize


```r

v4 <- c("Milutin", "Vojkan", "Petar")

typeof(v4)
## [1] "character"

prof_name <- paste("Milutin", "Pejovic", sep = " ")

prof_name
## [1] "Milutin Pejovic"

v5 <- paste(c("Milutin", "Vojkan", "Petar"), "GRF", sep = "_")

typeof(v5)
## [1] "character"
```

 \footnotesize

#### Logicals


 \scriptsize


```r
v6 <-c(TRUE, FALSE, TRUE)

typeof(v6)
## [1] "logical"

v7 <-c(T, F, T)
v7
## [1]  TRUE FALSE  TRUE
typeof(v7)
## [1] "logical"
```

 \footnotesize



#### Nedostajuće vrednosti (`NA`)

Nodostajuće ili nepoznate vrednosti u R-u se predstavljaju sa `NA`. Treba imati na umu da nedostajuća vrednost nije nula vrednost, odnosno da bilo koja operacija sa nedostajućom vrednosti rezultira takođe u nedostajuću vrednost.


 \scriptsize


```r
1 > 5
## [1] FALSE

NA > 5
## [1] NA

10 * NA
## [1] NA
```

 \footnotesize



Izuzeci su samo sledeće operacije:


 \scriptsize


```r
NA ^ 0
## [1] 1

NA | TRUE # operator | znači "ili"
## [1] TRUE

NA & FALSE
## [1] FALSE
```

 \footnotesize


#### Provera tipa podataka

Provera tipa podataka se može sprovesti pozivanjem neke od funkcija iz familije `is.*()`, kao na primer `is.logical()`, `is.integer()`, `is.double()`, ili `is.character()`. Postoje i funkcije kao što su `is.vector()`, `is.atomic()`, ili `is.numeric()` ali oni ne služe toj svrsi. 


 \scriptsize


```r
is.numeric(v1)
## [1] TRUE

is.integer(v1)
## [1] FALSE

is.logical(v1)
## [1] FALSE
```

 \footnotesize

#### Prinudna konverzija imeđu tipova podataka

Kao što je poznato, `vektor`, `matrica` ili `array` su strukture podataka koje mogu sadržati samo jedan tip podataka. Stim u vezi, ukoliko se u nekom vektoru nađu dva tipa podataka, R će prema integrisanim pravilima (`character <- double <- integer <- logical`) prinudno transformisati tip podataka.  



 \scriptsize

<img src="C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Figures/prinudna_promena.jpg" width="503" style="display: block; margin: auto;" />

 \footnotesize



## Atributi

### `Names` (nazivi)


 \scriptsize


```r
names(v1) <-c("jedan", "dva", "tri", "cetiri", "pet", "sest")

v1+1 # Imena ne prepoznaju vrednost na koju se odnose
##  jedan    dva    tri cetiri    pet   sest 
##      2      3      4      5      6      7


names(v1) <- NULL # Uklanjanje atributa
```

 \footnotesize

### `Dim` (dimenzije)

Vektor se moze transformisati u dvo-dimenzionalnu strukturu podataka - matricu, dodavanjem odgovarajućih dimenzija pomoću komande `dim`:



 \scriptsize


```r
dim(v1) <- c(2, 3)

v1
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

 \footnotesize



Na isti način, vektor se može transformisati u `array`:


 \scriptsize


```r
v1 <- 1:6
dim(v1) <- c(1, 2, 3)
v1
## , , 1
## 
##      [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
##      [,1] [,2]
## [1,]    5    6
```

 \footnotesize




### Klase podataka

Jedan od najvažnijih atributa koji se vezuje za osnovne strukture podataka u R-u je `klasa`, čime se definiše jedan od objektno orijentisanih pristupa definisanja strukture podataka poznat pod imenom `S3` klase. R podržava više sistema za objeknto orijentisano struktuiranje podataka kao što su `S3`, `S4` i `R6`. `S3` je osnovni sistem i podržan je u okviru osnovne istalacije R-a.  
Dodavanjem atributa `class` R objekat postja `S3` objekat i od toga zavisi kako će se neke osnovne funkcije (`generic functions`) ophoditi prema tom objektu. Drugim rečima, rezultat neke operacije zavisi od klase podataka. 

U okviru ovog poglavlja, razmotrićemo tri osnovne klase vekorskih podataka:

#### `factors`

Faktor je vektor koji može sadržati samo određeni broj predefinisanih vrednosti i služi za skladištenje kategoričkih promenljivih. Faktorski vektor u sebi sadrži celobrojne vrednosti kojima je dodeljen naziv, odnosno nivo (`level`). Tako na primer:



 \scriptsize


```r
v7 <- factor(c("a", "b", "b", "a"))

v7
## [1] a b b a
## Levels: a b


typeof(v7)
## [1] "integer"

attributes(v7)
## $levels
## [1] "a" "b"
## 
## $class
## [1] "factor"
```

 \footnotesize



Faktorski vektor je pogodan za grupisanje podataka, što nam može omogućiti analizu podataka prema grupi kojoj pripadaju.  


#### `Dates` (Datum) vektori

`Dates` ili datumski vektori vektori u sebi sadrže podatak o vremenu na dnevnoj rezoluciji i kreirani su na osnovu `double` vrednosti. Oni predstavljanju broj dana počev od `1970-01-01` 



 \scriptsize


```r
v8 <- Sys.Date()

typeof(v8)
## [1] "double"

attributes(v8)
## $class
## [1] "Date"

as.numeric(v8)
## [1] 19438

v9 <- as.Date("1983-03-30")
v9
## [1] "1983-03-30"

as.numeric(v9)
## [1] 4836
```

 \footnotesize



#### `Date-time` (datum-vreme) vektori

R podržava dva načina u okviru `S3` klasa za skladištenje informacija o datumu-vremenu POSIXct, and POSIXlt. POSIX je skraćenica od Portable Operating System Interface što je skraćenica za familiju standarda za razmenu informacija o vremenu. `ct` je skraćenica od `calendar`, a `lt` od  `local time`. POSIXct vektor je kreiran na osnovu `double` vektora i predstavlja broj sekundi od `1970-01-01`.   


 \scriptsize


```r
v10 <- as.POSIXct("2020-11-04 10:00", tz = "UTC")

typeof(v10)
## [1] "double"

attributes(v10)
## $class
## [1] "POSIXct" "POSIXt" 
## 
## $tzone
## [1] "UTC"
```

 \footnotesize

# Podešavanje radnog direktorijuma 

Ukoliko postoji potreba da se neka skripta veže za određeni set podataka koji se nalazi u određenom folderu, često je potrebno definisati radni direktorijum. Time se praktično definiše `default` putanja koju će koristiti sve funkcije koje za argument koriste putanju do određenog foldera, ukoliko se ne podesi drugačije. Podešavanje radnog direktorijuma se vrši pozivom komande `setwd()`


 \scriptsize


```r
#?setwd()

#setwd(dir = "C:/R_projects/Nauka_R/Slides")

```

 \footnotesize


Ukoliko postoji potreba da se proveri koja je aktuelna putanja, odnosno koji je aktuelni radni direktorijum, to se može učiniti pozivom komande `getwd()`.


 \scriptsize


```r
#getwd()

```

 \footnotesize


Izlistavanje fajlova koji se nalaze u nekom direktorijumu se vrši pozivom komande `ls()`

> <h3>Zadatak 1</h3>
> + Podesiti radni direktorijum.
> + Izlistati sve fajlove koji se nalaze u radnom direktorijumu.

Podešavanje radnog direktorijuma je korisno koristiti ako prilikom rada koristimo konstantno jedinstven direktorijum sa skriptama, podacima i drugim potrebnim fajlovima. Tada u radu i korišćenju funkcija možemo koristiti relativne putanje ka pod-fodlerima ako je potrebno, inače se podrazumeva data putanja kao apsolutna.


# Učitavanje podataka u R-u

Za učitavanje podataka u radno okruženje koriste se funkcije, koje rade na principu zadavanja putanje ka podacima, kao i formata podataka, koji ne mora biti eksplicitno naveden. Neke od osnovnih funkcija su `read.table` i `read.csv`.

Za definisanje putanje do podataka koje želimo da učitamo, paket `here` nam može dosta olakšati. On služi da se na lakši način kreira putanja do željenog fajla. Na primer:


 \scriptsize


```r
# install.packages("here")
# library(here)

here::here("data") # kreira putanju do foldera "data".
## [1] "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/data"
```

 \footnotesize



 \scriptsize


```r

# studenti <- read.table(file = here::here("data", "Students_IG1.txt"), sep = ",", header = TRUE)

# studenti <- read.csv(file = here::here("data", "Students_IG1.txt"), header = TRUE, stringsAsFactors = FALSE)

```

 \footnotesize


## `readxl` paket

Učitavanje excel tabela je moguće učiniti putem paketa "readxl":


 \scriptsize


```r
 
# install.packages("readxl")
library(readxl)


studenti <- readxl::read_xlsx(path = "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/data/Students_IG1.xlsx", sheet = "Students")
```

 \footnotesize



## Pregled podataka

str(studenti) # Obratite pažnju da su imena studenata skladištena kao faktorske kolone u okviru data.frame?

Ukoliko želimo da se određene kolone ne transformišu u faktorske prilikom učitavanja potrebno opciju `stringsAsFactors` podesititi da bude `FALSE`.


 \scriptsize


```r
class(studenti)
## [1] "tbl_df"     "tbl"        "data.frame"

head(studenti, 5)
## # A tibble: 5 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1     1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40
## 2     2 Arvaji   Luka    1020      17    NA    NA      NA      NA     NA      NA
## 3     3 Babic    Stef~   1051      16     0    NA      NA      NA     NA      NA
## 4     4 Beljin   Miloš   1019      17     0    NA      NA      NA     NA      10
## 5     5 Božic K~ Stef~   1041      16     0    NA      NA      NA     NA     100
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa

tail(studenti, 5)
## # A tibble: 5 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1    31 Stojano~ Marta   1048      16     0    NA      NA      NA     20      51
## 2    32 Stojano~ Mitar   1058      17     0    NA      NA      NA     NA      10
## 3    33 Tomic    Filip   1029      17     0    NA      NA      NA     65      NA
## 4    34 Cvetkov~ Boži~   1006      17     0    NA      NA      NA     NA      40
## 5    35 Cvetkov~ Nema~   1039      17    15   100      60      NA     NA      NA
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa

dim(studenti)
## [1] 35 14
```

 \footnotesize

## Selektovanje podataka

U okviru R-a postoji poseban sistem notacije kojim je moguće pristupiti vrednostima objekta. Kako bi pristupili podatku ili setu podataka (red-u i/ili kolona-ma), koristi se sledeće notacija sa [] zagradama:


 \scriptsize


```r
studenti[ , ]

```

 \footnotesize


U okviru zagrada pišu se dva indeksa odvojena zarezom, pri predstavlja broj **reda** i drugi predstavlja broj **kolone**. Indeksi mogu biti napisani na veći broj načina, i to:
 
- Pozitivne celobrojne vrednosti
- Negativne celobrojne vrednosti
- Nula
- Razmak
- Logičke vrednosti
- Nazivi   

#### Pozitivne celobrojne vrednosti



 \scriptsize


```r
studenti[1, ]
## # A tibble: 1 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1     1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa

studenti[, 2]
## # A tibble: 35 x 1
##    Prezime        
##    <chr>          
##  1 Antonijev      
##  2 Arvaji         
##  3 Babic          
##  4 Beljin         
##  5 Božic Krajišnik
##  6 Brkic          
##  7 Vasovic        
##  8 Vucic          
##  9 Garibovic      
## 10 Gordic         
## # ... with 25 more rows

studenti[1, 2]
## # A tibble: 1 x 1
##   Prezime  
##   <chr>    
## 1 Antonijev
```

 \footnotesize


Na ovaj način izvršena je selekcija prvog reda i druge kolone. Pored zadavanja jedne vrednosti, možemo izvržiti selekciju podataka skupom indeksa.


 \scriptsize


```r
studenti[1, c(2,3)]
## # A tibble: 1 x 2
##   Prezime   Ime  
##   <chr>     <chr>
## 1 Antonijev Boris
studenti[1, c(2:5)]
## # A tibble: 1 x 4
##   Prezime   Ime   br.ind god.upisa
##   <chr>     <chr>  <dbl>     <dbl>
## 1 Antonijev Boris   1035        16
```

 \footnotesize


Rezultat upita je samo prikaz - kopija vrednosti. Rezultat možemo dodeliti novoj promenljivoj:


 \scriptsize


```r
Boris <- studenti[1, c(1:14)]
Boris
## # A tibble: 1 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1     1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa
```

 \footnotesize



Isti sistem notacije se koristi i kod drugih tipova podataka, npr. kod vektora:


 \scriptsize


```r
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
## [1] 6 1 3
```

 \footnotesize


Bitno je zapamtiti da indeksiranje u R-u **uvek počinje od 1**, dok za razliku od nekih drugih programskih jezika počinje od 0.      
   
#### Negativne celobrojne vrednosti
Negativne vrednosti daju suprotni rezultat u odnosu na pozitivne celobrojne vrednosti. Rezultat je sve osim elemenata navedenih indeksom:


 \scriptsize


```r
studenti[-c(2:35), 2:5]
## # A tibble: 1 x 4
##   Prezime   Ime   br.ind god.upisa
##   <chr>     <chr>  <dbl>     <dbl>
## 1 Antonijev Boris   1035        16
```

 \footnotesize



Kombincija pozitivnih i negativnih indeksa je moguća, dok nije moguće postaviti pozitivnu i negativnu vrednost u okviru istog inndeksa:


 \scriptsize


```r
# studenti[-c(-1,1), 2]
# Error in x[i] : only 0's may be mixed with negative subscripts

studenti[1:5, -1]
## # A tibble: 5 x 13
##   Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar   Jun
##   <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl> <dbl>
## 1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40    51
## 2 Arvaji   Luka    1020      17    NA    NA      NA      NA     NA      NA    NA
## 3 Babic    Stef~   1051      16     0    NA      NA      NA     NA      NA   100
## 4 Beljin   Miloš   1019      17     0    NA      NA      NA     NA      10   100
## 5 Božic K~ Stef~   1041      16     0    NA      NA      NA     NA     100    NA
## # ... with 2 more variables: Ocena <dbl>, Praksa <dbl>, and abbreviated
## #   variable name 1: god.upisa
```

 \footnotesize



#### Nula
Kao što je rečeno indeksiranje elemenata počinje od 1, dok indeks 0 nije greška, već je rezultat objekat bez elemenata:


 \scriptsize


```r
studenti[0, 0]
## # A tibble: 0 x 0
```

 \footnotesize



#### Razmak
Korišćenem razmaka - praznog indeksa, dobija se rezultat koji podrazumeva sve elemente datog reda ili kolone:


 \scriptsize


```r
studenti[1, ]
## # A tibble: 1 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1     1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa
```

 \footnotesize



#### Logičke vrednosti          
Vrednost indeksa može biti i logička vrednost i tom služaju rezultat je red i/ili kolona koja odgovara vrednosti TRUE:


 \scriptsize


```r
studenti[1, c(FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]
## # A tibble: 1 x 3
##   Prezime   Ime   br.ind
##   <chr>     <chr>  <dbl>
## 1 Antonijev Boris   1035
```

 \footnotesize


Vektor logičkih vrednosti moguće je kreirati primenom logičkih upita. Odnosno kreiranjem logičkog upita dobija se vektor sa vrednostima TRUE i FALSE koji se mogu koristiti za određivanje pozicije vrednosti koju želimo izmeniti:



 \scriptsize


```r
generacija_2017 <- studenti$god.upisa == 2017
generacija_2017 # vektor logičkih vrednosti
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

studenti[generacija_2017, ]
## # A tibble: 0 x 14
## # ... with 14 variables: ID <dbl>, Prezime <chr>, Ime <chr>, br.ind <dbl>,
## #   god.upisa <dbl>, kol.1 <dbl>, kol.2 <dbl>, kol.1.1 <dbl>, kol.2.2 <dbl>,
## #   Januar <dbl>, Februar <dbl>, Jun <dbl>, Ocena <dbl>, Praksa <dbl>
```

 \footnotesize
  


Logički operatori su veoma efikasan način selekcije i u okviru R-a definisani su na sledeći način:


#### Bulovi operatori

Bulovi operatori nam omogućuju da kombinujemo logičke izraze. Međutim, tu treba imati na umu da `NA` vrednosti mogu uticati na rezultat izraza. Bilo koji izraz sa `NA`vrednošću nam kao rezultat vraća `NA` vrednost.



 \scriptsize

<img src="C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Figures/logicki operatori.jpg" width="452" style="display: block; margin: auto;" />

 \footnotesize


Na primer, ako želimo pogledati  koji studenti su imali 100 bodova junskom roku i kranju ocenu 9, nećemo dobiti željeni rezultat, upravo zbog prisustva `NA` vrednosti


 \scriptsize


```r
studenti[studenti$Jun == 100 & studenti$Ocena == 9, ]
## # A tibble: 9 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 2    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 3    15 Kocic    Stef~   1035      17     0    NA      NA      NA     NA      24
## 4    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 5    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 6    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 7    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 8    NA <NA>     <NA>      NA      NA    NA    NA      NA      NA     NA      NA
## 9    32 Stojano~ Mitar   1058      17     0    NA      NA      NA     NA      10
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa

studenti[!is.na(studenti$Jun) & !is.na(studenti$Ocena) & studenti$Jun == 100 & studenti$Ocena == 9, ]
## # A tibble: 2 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1    15 Kocic    Stef~   1035      17     0    NA      NA      NA     NA      24
## 2    32 Stojano~ Mitar   1058      17     0    NA      NA      NA     NA      10
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa
```

 \footnotesize


 
   
#### Nazivi 

Selekcija podataka - elementa je moguća i putem naziva kolona i/ili redova ako su dostupni:



 \scriptsize


```r
names(studenti) 
##  [1] "ID"        "Prezime"   "Ime"       "br.ind"    "god.upisa" "kol.1"    
##  [7] "kol.2"     "kol.1.1"   "kol.2.2"   "Januar"    "Februar"   "Jun"      
## [13] "Ocena"     "Praksa"
studenti[, "Prezime"]
## # A tibble: 35 x 1
##    Prezime        
##    <chr>          
##  1 Antonijev      
##  2 Arvaji         
##  3 Babic          
##  4 Beljin         
##  5 Božic Krajišnik
##  6 Brkic          
##  7 Vasovic        
##  8 Vucic          
##  9 Garibovic      
## 10 Gordic         
## # ... with 25 more rows
studenti[1:5, c("Prezime", "Ime", "br.ind", "god.upisa")]
## # A tibble: 5 x 4
##   Prezime         Ime    br.ind god.upisa
##   <chr>           <chr>   <dbl>     <dbl>
## 1 Antonijev       Boris    1035        16
## 2 Arvaji          Luka     1020        17
## 3 Babic           Stefan   1051        16
## 4 Beljin          Miloš    1019        17
## 5 Božic Krajišnik Stefan   1041        16
```

 \footnotesize


Kao i kombinacija navedenog:


 \scriptsize


```r
studenti[1:5, c(names(studenti[, c(2:5)]))]
## # A tibble: 5 x 4
##   Prezime         Ime    br.ind god.upisa
##   <chr>           <chr>   <dbl>     <dbl>
## 1 Antonijev       Boris    1035        16
## 2 Arvaji          Luka     1020        17
## 3 Babic           Stefan   1051        16
## 4 Beljin          Miloš    1019        17
## 5 Božic Krajišnik Stefan   1041        16
```

 \footnotesize



### Selektovanje podataka putem $ sintakse
Putem prethodnih primera pokazan je osnovni način selekcije elementa iz skupa podataka. Način selekcije podataka koji se najčešće koristi predstavlja upotrebu $ sintakse.      
Potrebno je napisati naziv objekta - data frame-a a zatim napisati naziv kolone odvojen znakom "$":


 \scriptsize


```r
studenti$Prezime
##  [1] "Antonijev"       "Arvaji"          "Babic"           "Beljin"         
##  [5] "Božic Krajišnik" "Brkic"           "Vasovic"         "Vucic"          
##  [9] "Garibovic"       "Gordic"          "Grujovic"        "Dimitrijevic"   
## [13] "Jovicic"         "Kocic"           "Kocic"           "Lazic"          
## [17] "Lazic"           "Milijaševic"     "Milic"           "Milic"          
## [21] "Milosavljevic"   "Mladenovic"      "Nikolic"         "Paunic"         
## [25] "Popovic"         "Radovancev"      "Smiljanic"       "Srejic"         
## [29] "Stanojevic"      "Stanojkovic"     "Stojanovic"      "Stojanovic"     
## [33] "Tomic"           "Cvetkovic"       "Cvetkovic"
```

 \footnotesize


*Tips: Nakon napisanog znaka "$" moguće je pritisnuti taster TAB na tastaturi kako bi dobili listu naziva kolona.*      
Kako bi izvršili upit po redu, potrebno je napisati [] zagrade i navesti indeks reda.



 \scriptsize


```r
studenti$Prezime[1]
## [1] "Antonijev"
studenti$Prezime[1:5]
## [1] "Antonijev"       "Arvaji"          "Babic"           "Beljin"         
## [5] "Božic Krajišnik"
```

 \footnotesize




### Selektovanje podataka u okviru `list` - e

Selektovanje podataka u okviru liste vrši se korišćenjem operatora `[]` i `[[]]` ili prema nazivu elementa liste. 
Na primer, kreiraćemo listu studenata sa dva elementa, oni koji su poloćili praksu i onih koji nisu položili praksu.



 \scriptsize


```r
praksa_list <- list(polozili = studenti[!is.na(studenti$Praksa), ], nisu_polozili = studenti[is.na(studenti$Praksa), ])
```

 \footnotesize


Ukoliko želimo selektovati prvi član liste primenom operatora `[]`, za rezultat ćemo takođe dobiti listu!


 \scriptsize


```r
praksa_list[1]
## $polozili
## # A tibble: 31 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1     1 Antoni~ Boris   1035      16    NA    NA      NA      NA     NA      40
##  2     3 Babic   Stef~   1051      16     0    NA      NA      NA     NA      NA
##  3     4 Beljin  Miloš   1019      17     0    NA      NA      NA     NA      10
##  4     5 Božic ~ Stef~   1041      16     0    NA      NA      NA     NA     100
##  5     7 Vasovic Alek~   1031      17    40    85     100      NA     NA      NA
##  6     8 Vucic   Boban   1018      17    NA    NA      NA      NA     NA       8
##  7    10 Gordic  Nata~   1015      17     0    NA      NA      NA     NA      82
##  8    11 Grujov~ Kata~   1042      15    NA    NA      NA      NA     NA      NA
##  9    12 Dimitr~ Jovan   1040      17    45    95      10      NA     NA      80
## 10    13 Jovicic Andr~   1012      17    30    NA      NA      NA     NA      92
## # ... with 21 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa

class(praksa_list[1])
## [1] "list"
```

 \footnotesize


 \scriptsize

<img src="C:/R_projects/Analiza_podataka_u_R_u/Vezbe/Figures/selektovanje_liste.jpg" width="469" style="display: block; margin: auto;" />

 \footnotesize



Međutim, ukoliko želimo selektovati prvi član liste primenom operatora `[[]]`, za rezultat žemo takođe dobiti `data.frame`!


 \scriptsize


```r
praksa_list[[1]]
## # A tibble: 31 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1     1 Antoni~ Boris   1035      16    NA    NA      NA      NA     NA      40
##  2     3 Babic   Stef~   1051      16     0    NA      NA      NA     NA      NA
##  3     4 Beljin  Miloš   1019      17     0    NA      NA      NA     NA      10
##  4     5 Božic ~ Stef~   1041      16     0    NA      NA      NA     NA     100
##  5     7 Vasovic Alek~   1031      17    40    85     100      NA     NA      NA
##  6     8 Vucic   Boban   1018      17    NA    NA      NA      NA     NA       8
##  7    10 Gordic  Nata~   1015      17     0    NA      NA      NA     NA      82
##  8    11 Grujov~ Kata~   1042      15    NA    NA      NA      NA     NA      NA
##  9    12 Dimitr~ Jovan   1040      17    45    95      10      NA     NA      80
## 10    13 Jovicic Andr~   1012      17    30    NA      NA      NA     NA      92
## # ... with 21 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa
class(praksa_list[[1]])
## [1] "tbl_df"     "tbl"        "data.frame"
```

 \footnotesize



Element liste moguće je selektovati i naznačavanjem imena liste u okviru operatora `[]`:



 \scriptsize


```r
praksa_list["polozili"]
## $polozili
## # A tibble: 31 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1     1 Antoni~ Boris   1035      16    NA    NA      NA      NA     NA      40
##  2     3 Babic   Stef~   1051      16     0    NA      NA      NA     NA      NA
##  3     4 Beljin  Miloš   1019      17     0    NA      NA      NA     NA      10
##  4     5 Božic ~ Stef~   1041      16     0    NA      NA      NA     NA     100
##  5     7 Vasovic Alek~   1031      17    40    85     100      NA     NA      NA
##  6     8 Vucic   Boban   1018      17    NA    NA      NA      NA     NA       8
##  7    10 Gordic  Nata~   1015      17     0    NA      NA      NA     NA      82
##  8    11 Grujov~ Kata~   1042      15    NA    NA      NA      NA     NA      NA
##  9    12 Dimitr~ Jovan   1040      17    45    95      10      NA     NA      80
## 10    13 Jovicic Andr~   1012      17    30    NA      NA      NA     NA      92
## # ... with 21 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa

praksa_list[["polozili"]]
## # A tibble: 31 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1     1 Antoni~ Boris   1035      16    NA    NA      NA      NA     NA      40
##  2     3 Babic   Stef~   1051      16     0    NA      NA      NA     NA      NA
##  3     4 Beljin  Miloš   1019      17     0    NA      NA      NA     NA      10
##  4     5 Božic ~ Stef~   1041      16     0    NA      NA      NA     NA     100
##  5     7 Vasovic Alek~   1031      17    40    85     100      NA     NA      NA
##  6     8 Vucic   Boban   1018      17    NA    NA      NA      NA     NA       8
##  7    10 Gordic  Nata~   1015      17     0    NA      NA      NA     NA      82
##  8    11 Grujov~ Kata~   1042      15    NA    NA      NA      NA     NA      NA
##  9    12 Dimitr~ Jovan   1040      17    45    95      10      NA     NA      80
## 10    13 Jovicic Andr~   1012      17    30    NA      NA      NA     NA      92
## # ... with 21 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa


praksa_list[1]
## $polozili
## # A tibble: 31 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1     1 Antoni~ Boris   1035      16    NA    NA      NA      NA     NA      40
##  2     3 Babic   Stef~   1051      16     0    NA      NA      NA     NA      NA
##  3     4 Beljin  Miloš   1019      17     0    NA      NA      NA     NA      10
##  4     5 Božic ~ Stef~   1041      16     0    NA      NA      NA     NA     100
##  5     7 Vasovic Alek~   1031      17    40    85     100      NA     NA      NA
##  6     8 Vucic   Boban   1018      17    NA    NA      NA      NA     NA       8
##  7    10 Gordic  Nata~   1015      17     0    NA      NA      NA     NA      82
##  8    11 Grujov~ Kata~   1042      15    NA    NA      NA      NA     NA      NA
##  9    12 Dimitr~ Jovan   1040      17    45    95      10      NA     NA      80
## 10    13 Jovicic Andr~   1012      17    30    NA      NA      NA     NA      92
## # ... with 21 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa
class(praksa_list[1])
## [1] "list"
```

 \footnotesize


> <h3>Zadatak</h3>
> + Kreirati listu tako što da studenti upisani iste godine čine jedan član liste. Za te potrebe koristiti komandu `list(prvi data.frame, drugi data.frame, treci data.frame)`





## Modifikovanje podataka


### Promena vrednosti

Modifikacija vrednosti podataka odnosi se na promenu vrednosti nekog podatka. Da bi neku vrednost bilo moguce promeniti, potrebno je prvo specificirati tačnu poziciju vrednosti koju želimo promeniti. Na primer, ako želimo da upišemo kao godinu upisa broj 2017 umesto 17, i 2016 umesto 16, to cemo uraditi na sledeci nacin:


 \scriptsize


```r
studenti[studenti$god.upisa == 17, "god.upisa"] <- 2017

studenti[studenti$god.upisa == 16, "god.upisa"] <- 2016

studenti$god.upisa
##  [1] 2016 2017 2016 2017 2016 2017 2017 2017 2017 2017   15 2017 2017 2017 2017
## [16] 2017 2017 2017 2017 2017 2017 2016 2017 2017 2016 2017 2016 2016 2017 2017
## [31] 2016 2017 2017 2017 2017
```

 \footnotesize


Ukoliko žeilimo da svim studentima koji su upisali fakultet 2017 godine dodelimo ocenu 5 iz IG1, to možemo uraditi na sledeći način:


 \scriptsize


```r
studenti[studenti$god.upisa == 2017, "Ocena"] <- 5

# studenti <- read.csv(file = here::here("data", "Students_IG1.txt"), header = TRUE, stringsAsFactors = FALSE)

studenti <- readxl::read_xlsx(path = "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/data/Students_IG1.xlsx", sheet = "Students")
```

 \footnotesize



> <h3>Zadatak</h3>
> + Izmeniti rezultate krajnje ocene i prakse za svoje ime tako sto cete dodeliti ocenu 10.


#### Modifikovanje tipa podataka



 \scriptsize


```r
str(studenti)
## tibble [35 x 14] (S3: tbl_df/tbl/data.frame)
##  $ ID       : num [1:35] 1 2 3 4 5 6 7 8 9 10 ...
##  $ Prezime  : chr [1:35] "Antonijev" "Arvaji" "Babic" "Beljin" ...
##  $ Ime      : chr [1:35] "Boris" "Luka" "Stefan" "Miloš" ...
##  $ br.ind   : num [1:35] 1035 1020 1051 1019 1041 ...
##  $ god.upisa: num [1:35] 16 17 16 17 16 17 17 17 17 17 ...
##  $ kol.1    : num [1:35] NA NA 0 0 0 0 40 NA 0 0 ...
##  $ kol.2    : num [1:35] NA NA NA NA NA 60 85 NA NA NA ...
##  $ kol.1.1  : num [1:35] NA NA NA NA NA 55 100 NA NA NA ...
##  $ kol.2.2  : num [1:35] NA NA NA NA NA NA NA NA NA NA ...
##  $ Januar   : num [1:35] NA NA NA NA NA NA NA NA NA NA ...
##  $ Februar  : num [1:35] 40 NA NA 10 100 NA NA 8 NA 82 ...
##  $ Jun      : num [1:35] 51 NA 100 100 NA NA NA 70 100 NA ...
##  $ Ocena    : num [1:35] 7 NA 7 8 7 7 8 6 6 8 ...
##  $ Praksa   : num [1:35] 9 NA 8 8 8 NA 9 8 NA 7 ...

unique(studenti$god.upisa)
## [1] 16 17 15

studenti$god.upisa <- factor(studenti$god.upisa, labels = c("2015", "2016", "2017"))
```

 \footnotesize


#### Modifikovanje redosleda podataka

Ukoliko želimo da poređamo vrste u `data.frame`-u prema vrednostima u nekoj koloni, to možemo učiniti na sledeći način:


 \scriptsize


```r
studenti[order(studenti$Ocena, studenti$Praksa),] 
## # A tibble: 35 x 14
##       ID Prezime Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##    <dbl> <chr>   <chr>  <dbl> <fct>   <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
##  1    31 Stojan~ Marta   1048 2016        0    NA      NA      NA     20      51
##  2     8 Vucic   Boban   1018 2017       NA    NA      NA      NA     NA       8
##  3    21 Milosa~ Nema~   1003 2017       30    NA      NA      NA     30     100
##  4    22 Mladen~ Niko~   1053 2016        0    NA      NA      NA     NA      NA
##  5    28 Srejic  Alek~   1037 2016       NA    NA      NA      NA     NA      NA
##  6    33 Tomic   Filip   1029 2017        0    NA      NA      NA     65      NA
##  7    34 Cvetko~ Boži~   1006 2017        0    NA      NA      NA     NA      40
##  8     9 Garibo~ Tarik   1027 2017        0    NA      NA      NA     NA      NA
##  9     3 Babic   Stef~   1051 2016        0    NA      NA      NA     NA      NA
## 10     5 Božic ~ Stef~   1041 2016        0    NA      NA      NA     NA     100
## # ... with 25 more rows, 3 more variables: Jun <dbl>, Ocena <dbl>,
## #   Praksa <dbl>, and abbreviated variable name 1: god.upisa
```

 \footnotesize


#### Kombinovanje podataka

Kombinovanjem podataka se odnosi na mogućnost spajanja dve tabele. Za te potrebe učitaćemo rezultate (konačne ocene) studenata postignute na predmetima IG1, Praksa i IG2. 



 \scriptsize


```r
ig1 <- readxl::read_xlsx(path = here::here("data", "Students_IG1.xlsx"), sheet = "Students")
head(ig1)
## # A tibble: 6 x 14
##      ID Prezime  Ime   br.ind god.u~1 kol.1 kol.2 kol.1.1 kol.2.2 Januar Februar
##   <dbl> <chr>    <chr>  <dbl>   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1     1 Antonij~ Boris   1035      16    NA    NA      NA      NA     NA      40
## 2     2 Arvaji   Luka    1020      17    NA    NA      NA      NA     NA      NA
## 3     3 Babic    Stef~   1051      16     0    NA      NA      NA     NA      NA
## 4     4 Beljin   Miloš   1019      17     0    NA      NA      NA     NA      10
## 5     5 Božic K~ Stef~   1041      16     0    NA      NA      NA     NA     100
## 6     6 Brkic    Alek~   1038      17     0    60      55      NA     NA      NA
## # ... with 3 more variables: Jun <dbl>, Ocena <dbl>, Praksa <dbl>, and
## #   abbreviated variable name 1: god.upisa
ig1 <- ig1[, c("Prezime", "Ime", "Ocena", "Praksa")] # Selektovali smo samo kolone koje nas zanimaju.
names(ig1) <- c("prezime", "ime", "ocena_ig1", "ocena_praksa")

ig2 <- readxl::read_xlsx(path = here::here("data", "Students_IG2.xlsx"), sheet = "Students")
head(ig1)
## # A tibble: 6 x 4
##   prezime         ime        ocena_ig1 ocena_praksa
##   <chr>           <chr>          <dbl>        <dbl>
## 1 Antonijev       Boris              7            9
## 2 Arvaji          Luka              NA           NA
## 3 Babic           Stefan             7            8
## 4 Beljin          Miloš              8            8
## 5 Božic Krajišnik Stefan             7            8
## 6 Brkic           Aleksandar         7           NA
ig2 <- ig2[, c("Prezime", "Ime", "Ocena")] # Selektovali smo samo kolone koje nas zanimaju.
names(ig2) <- c("prezime", "ime", "ocena_ig2")
```

 \footnotesize


Komanda `cbind` spaja dve tabele tako što drugu "nalepi" na prvu. Kao rezultat se dobija tabela sa ponovljenih kolonama koje su zajedničke. Uslov za korišćenje komande `cbind` je da dve tabele imaju isti broj vrsta. 


 \scriptsize


```r
ig <- cbind(ig1, ig2)
ig
##            prezime        ime ocena_ig1 ocena_praksa        prezime        ime
## 1        Antonijev      Boris         7            9      Antonijev      Boris
## 2           Arvaji       Luka        NA           NA         Arvaji       Luka
## 3            Babic     Stefan         7            8          Babic     Stefan
## 4           Beljin      Miloš         8            8         Beljin      Miloš
## 5  Božic Krajišnik     Stefan         7            8 BožicKrajišnik     Stefan
## 6            Brkic Aleksandar         7           NA          Brkic Aleksandar
## 7          Vasovic Aleksandar         8            9        Vasovic Aleksandar
## 8            Vucic      Boban         6            8          Vucic      Boban
## 9        Garibovic      Tarik         6           NA      Garibovic      Tarik
## 10          Gordic     Nataša         8            7         Gordic     Nataša
## 11        Grujovic   Katarina         8            8       Grujovic   Katarina
## 12    Dimitrijevic      Jovan         8            8   Dimitrijevic      Jovan
## 13         Jovicic  Andrijana         8            8        Jovicic  Andrijana
## 14           Kocic     Danilo         9            9          Kocic     Danilo
## 15           Kocic     Stefan         9            8          Kocic     Stefan
## 16           Lazic      Darko         7            8          Lazic      Darko
## 17           Lazic      Dušan         9            9          Lazic      Dušan
## 18     Milijaševic     Vojkan        10           10    Milijaševic     Vojkan
## 19           Milic    Nemanja         9            9          Milic    Nemanja
## 20           Milic       Saša        10           10          Milic       Saša
## 21   Milosavljevic    Nemanja         6            8  Milosavljevic    Nemanja
## 22      Mladenovic     Nikola         6            8     Mladenovic     Nikola
## 23         Nikolic      Ratko         8            9        Nikolic      Ratko
## 24          Paunic     Stefan         7            8         Paunic     Stefan
## 25         Popovic      Filip         7            8        Popovic      Filip
## 26      Radovancev      Miloš         9            8     Radovancev      Miloš
## 27       Smiljanic      Vojin        NA           NA      Smiljanic      Vojin
## 28          Srejic Aleksandar         6            8         Srejic Aleksandar
## 29      Stanojevic Aleksandar         9            9     Stanojevic Aleksandar
## 30     Stanojkovic      Ðorde         7            9    Stanojkovic      Ðorde
## 31      Stojanovic      Marta         6            7     Stojanovic      Marta
## 32      Stojanovic      Mitar         9           10     Stojanovic      Mitar
## 33           Tomic      Filip         6            8          Tomic      Filip
## 34       Cvetkovic    Božidar         6            8      Cvetkovic    Božidar
## 35       Cvetkovic    Nemanja         7            8      Cvetkovic    Nemanja
##    ocena_ig2
## 1         NA
## 2         NA
## 3         NA
## 4         NA
## 5         NA
## 6         NA
## 7          6
## 8          6
## 9         NA
## 10        NA
## 11        NA
## 12        NA
## 13        NA
## 14         8
## 15        NA
## 16         8
## 17         8
## 18         8
## 19         9
## 20        10
## 21         9
## 22        NA
## 23         8
## 24         6
## 25        NA
## 26         8
## 27        NA
## 28        NA
## 29         7
## 30        NA
## 31        NA
## 32         8
## 33        NA
## 34        NA
## 35        NA
```

 \footnotesize


Analogno komandi `cbind`, postoji komanda `rbind` koja spaja dve tabele tako što ih nadovezuje jednu ispod druge. Uslov za korišćenje komande `rbind` je da dve tabele imaju isti broj kolona. 

Ukoliko postoje zajedničke kolone poželjno je da se one ne ponavljaju. U tu svrhu koristićemo komandu `merge`:


 \scriptsize


```r

ig <- merge(ig1, ig2, by = c("prezime", "ime"))

ig
##          prezime        ime ocena_ig1 ocena_praksa ocena_ig2
## 1      Antonijev      Boris         7            9        NA
## 2         Arvaji       Luka        NA           NA        NA
## 3          Babic     Stefan         7            8        NA
## 4         Beljin      Miloš         8            8        NA
## 5          Brkic Aleksandar         7           NA        NA
## 6      Cvetkovic    Božidar         6            8        NA
## 7      Cvetkovic    Nemanja         7            8        NA
## 8   Dimitrijevic      Jovan         8            8        NA
## 9      Garibovic      Tarik         6           NA        NA
## 10        Gordic     Nataša         8            7        NA
## 11      Grujovic   Katarina         8            8        NA
## 12       Jovicic  Andrijana         8            8        NA
## 13         Kocic     Danilo         9            9         8
## 14         Kocic     Stefan         9            8        NA
## 15         Lazic      Darko         7            8         8
## 16         Lazic      Dušan         9            9         8
## 17         Milic    Nemanja         9            9         9
## 18         Milic       Saša        10           10        10
## 19   Milijaševic     Vojkan        10           10         8
## 20 Milosavljevic    Nemanja         6            8         9
## 21    Mladenovic     Nikola         6            8        NA
## 22       Nikolic      Ratko         8            9         8
## 23        Paunic     Stefan         7            8         6
## 24       Popovic      Filip         7            8        NA
## 25    Radovancev      Miloš         9            8         8
## 26     Smiljanic      Vojin        NA           NA        NA
## 27        Srejic Aleksandar         6            8        NA
## 28    Stanojevic Aleksandar         9            9         7
## 29   Stanojkovic      Ðorde         7            9        NA
## 30    Stojanovic      Marta         6            7        NA
## 31    Stojanovic      Mitar         9           10         8
## 32         Tomic      Filip         6            8        NA
## 33       Vasovic Aleksandar         8            9         6
## 34         Vucic      Boban         6            8         6
```

 \footnotesize




