---
title: | 
  | Građevinski fakultet
  | Odsek za geodeziju i geoinformatiku
  |
  | Analiza podataka u R-u
  |
subtitle: | 
  | 
  | Deskriptivna statistika
  |
author: |
  | Petar Bursać
  | Milutin Pejović  
date: "29 March 2023"
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





# Ucitavanje podataka

Primer podataka sa kojima ćemo raditi danas, odnose se na cene stanova u Beogradu.


 \scriptsize


```r

# Ucitavanje podataka iz csv fajla:

stanovi <- read.csv(file = "C:/R_projects/Analiza_podataka_u_R_u/Vezbe/data/stanovi.csv", stringsAsFactors = FALSE)

head(stanovi, 10)
##              lokacija broj_soba kvadratura  sprat novogradnja
## 1           Beli dvor         2         35      P        <NA>
## 2           Beli dvor         3         52   I-II          DA
## 3           Beli dvor         2         47   I-II        <NA>
## 4           Beli dvor         2         52   I-II          DA
## 5           Beli dvor         3         80   I-II          DA
## 6  Centar, Stari grad         3         65   I-II          NE
## 7  Centar, Stari grad         2         68 III-IV          DA
## 8  Centar, Stari grad         4        160     V+        <NA>
## 9         Crveni krst         2         34 III-IV          DA
## 10        Crveni krst         1         45     V+          NE
##    centralno_grejanje lift parking uknjizen stanje cena  klasa
## 1                  DA <NA>    <NA>       DA     NA 2000 1.7-2K
## 2                  DA <NA>      NE       DA      2 2000 1.7-2K
## 3                  NE <NA>      DA       DA     NA 2000 1.7-2K
## 4                  DA <NA>      DA       DA      2 2000 1.7-2K
## 5                  DA <NA>      DA       DA      2 2000 1.7-2K
## 6                  DA   DA    <NA>       DA      1 2000 1.7-2K
## 7                  DA   DA    <NA>       DA      2 2000 1.7-2K
## 8                  DA   DA    <NA>       DA      2 2000 1.7-2K
## 9                  DA   DA      DA       DA      2 2000 1.7-2K
## 10                 DA   DA      DA       DA      1 2000 1.7-2K
##                                 adresa latitude longitude
## 1           Beli dvor, Beograd, Srbija 44.76570  20.45334
## 2           Beli dvor, Beograd, Srbija 44.76570  20.45334
## 3           Beli dvor, Beograd, Srbija 44.76570  20.45334
## 4           Beli dvor, Beograd, Srbija 44.76570  20.45334
## 5           Beli dvor, Beograd, Srbija 44.76570  20.45334
## 6  Centar, Stari grad, Beograd, Srbija 44.82532  20.47629
## 7  Centar, Stari grad, Beograd, Srbija 44.82532  20.47629
## 8  Centar, Stari grad, Beograd, Srbija 44.82532  20.47629
## 9         Crveni krst, Beograd, Srbija 44.79790  20.48664
## 10        Crveni krst, Beograd, Srbija 44.79790  20.48664
```

 \footnotesize

U prvom koraku, upoznaćemo se podacima, nazivima kolona, dimenzijama, tipovima podataka.


 \scriptsize


```r

# Dimenzije podataka
dim(stanovi)
## [1] 1901   15

# Tipovi podataka
str(stanovi)
## 'data.frame':	1901 obs. of  15 variables:
##  $ lokacija          : chr  "Beli dvor" "Beli dvor" "Beli dvor" "Beli dvor" ...
##  $ broj_soba         : int  2 3 2 2 3 3 2 4 2 1 ...
##  $ kvadratura        : int  35 52 47 52 80 65 68 160 34 45 ...
##  $ sprat             : chr  "P" "I-II" "I-II" "I-II" ...
##  $ novogradnja       : chr  NA "DA" NA "DA" ...
##  $ centralno_grejanje: chr  "DA" "DA" "NE" "DA" ...
##  $ lift              : chr  NA NA NA NA ...
##  $ parking           : chr  NA "NE" "DA" "DA" ...
##  $ uknjizen          : chr  "DA" "DA" "DA" "DA" ...
##  $ stanje            : int  NA 2 NA 2 2 1 2 2 2 1 ...
##  $ cena              : num  2000 2000 2000 2000 2000 2000 2000 2000 2000 2000 ...
##  $ klasa             : chr  "1.7-2K" "1.7-2K" "1.7-2K" "1.7-2K" ...
##  $ adresa            : chr  "Beli dvor, Beograd, Srbija" "Beli dvor, Beograd, Srbija" "Beli dvor, Beograd, Srbija" "Beli dvor, Beograd, Srbija" ...
##  $ latitude          : num  44.8 44.8 44.8 44.8 44.8 ...
##  $ longitude         : num  20.5 20.5 20.5 20.5 20.5 ...

# Nazivi kolona
names(stanovi)
##  [1] "lokacija"           "broj_soba"          "kvadratura"        
##  [4] "sprat"              "novogradnja"        "centralno_grejanje"
##  [7] "lift"               "parking"            "uknjizen"          
## [10] "stanje"             "cena"               "klasa"             
## [13] "adresa"             "latitude"           "longitude"
```

 \footnotesize

# Analiza frekvencija

Raspon cena stanova:


 \scriptsize


```r
# Koristimo funkciju range ili min i max vrednosti
min(stanovi$cena)
## [1] 900
max(stanovi$cena)
## [1] 2000

range(stanovi$cena)
## [1]  900 2000
```

 \footnotesize

## Tabela frekvencija

Jednostavna tabela frekvencija po atributima:


 \scriptsize


```r

# Jednostavan primer
table(stanovi$klasa)
## 
##  .9-1.1K 1.1-1.3K 1.3-1.5K 1.5-1.7K   1.7-2K 
##      705      494      299      217      186

# ili po broju soba

table(stanovi$broj_soba)
## 
##   1   2   3   4 
## 439 635 608 219

# ili po spratnosti

table(stanovi$sprat)
## 
##   I-II III-IV      P     V+ 
##    750    445    251    455
```

 \footnotesize

Tabela frekvencije cene stanova sa korakom od 200 eur


 \scriptsize


```r

breaks <- seq(800, 2000, by = 200)

stanovi %<>%
  dplyr::mutate(raspon_cena = cut(cena, breaks, dig.lab = 4))

table(stanovi$raspon_cena)  
## 
##  (800,1000] (1000,1200] (1200,1400] (1400,1600] (1600,1800] (1800,2000] 
##         379         532         420         251         192         127

# I da kreiramo data.frame sa rezultatima

f_table_cena <- table(stanovi$raspon_cena) %>% # pozivamo table funkciju za racunanje frekvencije
  as.data.frame() %>% # kreiramo data.frame
  dplyr::rename(raspon_cena = Var1) %>% # promena naziva atributa
  dplyr::mutate("%" = round((Freq/sum(Freq)) * 100, 0)) # kreiramo novi artribut 

f_table_cena
##   raspon_cena Freq  %
## 1  (800,1000]  379 20
## 2 (1000,1200]  532 28
## 3 (1200,1400]  420 22
## 4 (1400,1600]  251 13
## 5 (1600,1800]  192 10
## 6 (1800,2000]  127  7
```

 \footnotesize


Histogram frekvencije cene stanova


 \scriptsize


```r

hist(x = stanovi$cena, 
     xlab = "Cena stanova [eur]", 
     main = "Histogram cene stanova za Grad Beograd")
```

<img src="Uvod-u-R---vezbe---3_files/figure-html/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

 \footnotesize


Frekvencije stanova po lokaciji


 \scriptsize


```r

f_table_lokacija <- table(stanovi$lokacija) %>% # pozivamo table funkciju za racunanje frekvencije
  as.data.frame() %>% # kreiramo data.frame
  dplyr::rename(Lokacija = Var1) %>% # promena naziva atributa
  dplyr::mutate("%" = round((Freq/sum(Freq)) * 100, 0)) # kreiramo novi artribut 

f_table_lokacija %>% 
  dplyr::arrange(desc(Freq))
##                           Lokacija Freq %
## 1                  Višnjicka banja   72 4
## 2                 Cukaricka padina   69 4
## 3                      Medakovic 1   56 3
## 4                      Lekino Brdo   43 2
## 5            Novi Beograd, Opština   43 2
## 6           Zemun, Save Kovacevica   41 2
## 7                    Djeram pijaca   40 2
## 8         Konjarnik, Denkova basta   40 2
## 9                      Medakovic 2   40 2
## 10                       Tašmajdan   40 2
## 11                           Cerak   39 2
## 12                    Petlovo brdo   39 2
## 13                 Cerak vinogradi   37 2
## 14                    Golf naselje   37 2
## 15                   Kanarevo brdo   37 2
## 16        Bežanijska kosa, Blokovi   36 2
## 17                    Donji Dorcol   36 2
## 18                    Filmski grad   36 2
## 19                     Medakovic 3   36 2
## 20           Novi Beograd, Fontana   36 2
## 21                  Vukov Spomenik   36 2
## 22                       Karaburma   35 2
## 23                      Mirijevo 1   35 2
## 24                      Mirijevo 2   35 2
## 25      Novi Beograd, Blokovi Sava   35 2
## 26 Novi Beograd, Hotel Jugoslavija   35 2
## 27            Profesorska kolonija   35 2
## 28              Uciteljsko naselje   35 2
## 29          Vracar, Kalenic pijaca   35 2
## 30                       Konjarnik   34 2
## 31       Novi Beograd, Sava Centar   34 2
## 32                         Žarkovo   34 2
## 33                      Kalemegdan   33 2
## 34                   Labudovo brdo   33 2
## 35                       Vidikovac   33 2
## 36                    Vracar, Hram   33 2
## 37                Zemun, Kalvarija   33 2
## 38   Novi Beograd, Studentski grad   32 2
## 39                        Rakovica   32 2
## 40            Zemun, Nova Galenika   30 2
## 41                       Beli dvor   29 2
## 42                Zemun, Novi grad   27 1
## 43                         Slavija   26 1
## 44                     Autokomanda   25 1
## 45                         Banjica   25 1
## 46                     Crveni krst   25 1
## 47                       Bele Vode   24 1
## 48              Centar, Stari grad   24 1
## 49          Bežanijska kosa, stara   23 1
## 50                       Dušanovac   22 1
## 51                     Julino brdo   21 1
## 52                       Košutnjak   19 1
## 53                     Bogoslovija   18 1
## 54                      Kumodraž 2   17 1
## 55                           Borca   16 1
## 56                         Krnjaca   16 1
## 57                      Kumodraž 1   14 1
```

 \footnotesize

Frekvencija po atributu uknjizen


 \scriptsize


```r

f_table_uknjizen <- table(stanovi$uknjizen) %>% # pozivamo table funkciju za racunanje frekvencije
  as.data.frame() %>% # kreiramo data.frame
  dplyr::rename(Uknjizen = Var1) %>% # promena naziva atributa
  dplyr::mutate("%" = round((Freq/sum(Freq)) * 100, 0)) # kreiramo novi artribut 

f_table_uknjizen %>% 
  dplyr::arrange(desc(Freq))
##   Uknjizen Freq  %
## 1       DA 1408 95
## 2       NE   68  5
```

 \footnotesize


## Odnos dve kategorijske promenljive (Contingency tables)

Novogradnja - Parking


 \scriptsize


```r

kon_table <- table(stanovi$novogradnja, stanovi$parking) 

kon_table
##     
##       DA  NE
##   DA 188  75
##   NE 172 158

mosaicplot(kon_table, 
           xlab = "Parking", 
           ylab = "Novogradnja",
           main = "Odnos Parkinga i Novogradnje za Grad Beograd")
```

<img src="Uvod-u-R---vezbe---3_files/figure-html/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

 \footnotesize



# Mere centralne tendencije

## Raspon

Minimum (min) i maksimum (max) su najjednostavnije mere lokacije naših podataka i daju nam jasan uvid u najmanju i najveću vrednost naših podataka.

Raspon cena stanova:


 \scriptsize


```r
# Koristimo funkciju range ili min i max vrednosti
min(stanovi$cena)
## [1] 900
max(stanovi$cena)
## [1] 2000

range(stanovi$cena)
## [1]  900 2000

# ili 20 najmanjih vrednosti

sort(stanovi$cena)[1:20]
##  [1] 900.0000 900.0000 900.0000 900.0000 900.0000 900.0000 900.0000 900.0000
##  [9] 900.0000 900.0000 900.0000 900.0000 900.0000 900.0000 901.5152 902.1739
## [17] 902.1739 902.3810 903.2258 903.4091

# ili 20 najvecih vrednosti

stanovi %>%
  arrange(desc(cena)) %>%
  slice(1:20) %>%
  select(cena)
##    cena
## 1  2000
## 2  2000
## 3  2000
## 4  2000
## 5  2000
## 6  2000
## 7  2000
## 8  2000
## 9  2000
## 10 2000
## 11 2000
## 12 2000
## 13 2000
## 14 2000
## 15 2000
## 16 2000
## 17 2000
## 18 2000
## 19 2000
## 20 2000
```

 \footnotesize

Raspon vrednosti kvadrature i broja soba stanova:


 \scriptsize


```r
# Koristimo funkciju range ili min i max vrednosti

range(stanovi$kvadratura) # kvadratura
## [1]  16 375

range(stanovi$broj_soba) # broj soba
## [1] 1 4
```

 \footnotesize

## Aritmeticka sredina


 \scriptsize


```r

# Aritmeticka sredina cene stanova

mean(stanovi$cena) # koristimo funkciju mean
## [1] 1279.991
```

 \footnotesize
Primer uticaja odskačućih rezultata na aritmeticku sredinu ako odaberemo 10 vrednosti cena (slučajnim izborom): 


 \scriptsize


```r

n_10 <- sample(stanovi$cena, 10)

# Sa maksimalnim rezultatom:
mean(n_10)
## [1] 1424.476

# Bez maksimalnog rezultata:

n_10_1 <- n_10[n_10 != max(n_10)]
mean(n_10_1)
## [1] 1360.529
```

 \footnotesize

## Težinska aritmetička sredina

Za razliku od proste aritmetičke sredine gde svi podaci učestvuju jednako, kod težinske aritmetičke sredine svakom podatku se daje određena težina:


 \scriptsize


```r

# Kao tezine mozemo ukljucti da li postoji ili ne lift ili je NA vrednost

unique(stanovi$lift)
## [1] NA   "DA" "NE"

stanovi %<>% 
  dplyr::mutate(lift_tezina = case_when(is.na(lift) ~ 0, 
                                        lift == "DA" ~ 2,
                                        lift == "NE" ~ 1))

weighted.mean(stanovi$cena, stanovi$lift_tezina)
## [1] 1331.93
```

 \footnotesize


> <h3>Zadatak</h3>
> + Sracunati težinska aritmetičku sredinu, gde bi se kao težine koristili atributi: uknjižen, parking, centralno grejanje i novogradnja
> + Rezultate objediniti u jedan data.frame i uporediti sa vrednosti proste aritmetičke sredine


## Zasečena aritmetička sredina
Zasečena aritmetička sredina računa se na identičan način kao i prosta aritmetička sredina, ali ne uključuje određeni broj maksimalnih i minimalnih vrednosti.


 \scriptsize


```r

# 10% zasecena srednja vrednost 

mean(stanovi$cena, trim = 0.1)
## [1] 1251.063
```

 \footnotesize

## Medijana 


 \scriptsize


```r

# Za računanje medijane koristimo funkciju median

median(stanovi$cena)
## [1] 1217.391

# Vrednost medijane po grupama cene stanova

mean_median_grupe <- stanovi %>% dplyr::group_by(raspon_cena) %>%
  dplyr::summarize(cena_mean = mean(cena), 
                   cena_median = median(cena)) %>%
  as.data.frame()

mean_median_grupe
##   raspon_cena cena_mean cena_median
## 1  (800,1000]  959.6453     962.963
## 2 (1000,1200] 1102.6512    1086.812
## 3 (1200,1400] 1290.7044    1275.000
## 4 (1400,1600] 1488.9389    1470.588
## 5 (1600,1800] 1692.2444    1672.924
## 6 (1800,2000] 1907.2171    1900.000
```

 \footnotesize

## Prvi i treći kvartil
Prvi kvartil deli niz vrednosti tako što je 25% vrednosti manja od prvog kvartila, a 75% veća.


 \scriptsize


```r
summary(stanovi)
##    lokacija           broj_soba       kvadratura        sprat          
##  Length:1901        Min.   :1.000   Min.   : 16.00   Length:1901       
##  Class :character   1st Qu.:2.000   1st Qu.: 42.00   Class :character  
##  Mode  :character   Median :2.000   Median : 58.00   Mode  :character  
##                     Mean   :2.319   Mean   : 60.67                     
##                     3rd Qu.:3.000   3rd Qu.: 74.00                     
##                     Max.   :4.000   Max.   :375.00                     
##                                                                        
##  novogradnja        centralno_grejanje     lift             parking         
##  Length:1901        Length:1901        Length:1901        Length:1901       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##    uknjizen             stanje           cena         klasa          
##  Length:1901        Min.   :0.000   Min.   : 900   Length:1901       
##  Class :character   1st Qu.:1.000   1st Qu.:1038   Class :character  
##  Mode  :character   Median :1.000   Median :1217   Mode  :character  
##                     Mean   :1.264   Mean   :1280                     
##                     3rd Qu.:2.000   3rd Qu.:1450                     
##                     Max.   :3.000   Max.   :2000                     
##                     NA's   :551                                      
##     adresa             latitude       longitude          raspon_cena 
##  Length:1901        Min.   :44.72   Min.   :20.36   (800,1000] :379  
##  Class :character   1st Qu.:44.77   1st Qu.:20.42   (1000,1200]:532  
##  Mode  :character   Median :44.79   Median :20.46   (1200,1400]:420  
##                     Mean   :44.79   Mean   :20.45   (1400,1600]:251  
##                     3rd Qu.:44.82   3rd Qu.:20.49   (1600,1800]:192  
##                     Max.   :44.88   Max.   :20.54   (1800,2000]:127  
##                                                                      
##   lift_tezina   
##  Min.   :0.000  
##  1st Qu.:0.000  
##  Median :2.000  
##  Mean   :1.067  
##  3rd Qu.:2.000  
##  Max.   :2.000  
## 
```

 \footnotesize



## Modus

Mod je vrednost koja se najčešće pojavljuje u nizu vrednosti.


 \scriptsize


```r

# Funkcija
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Modus cena
getmode(stanovi$cena)
## [1] 1000

# Modus lokacija
getmode(stanovi$lokacija)
## [1] "Višnjicka banja"
```

 \footnotesize

# Mere varijacije

Raspon svih vrednosti (range), Interkvartilni raspon (IQR), Standardna devijacija, Varijansa, Median Absolute Error (MAE), Koeficijent varijacije (CV)



 \scriptsize


```r

mere_cena <- stanovi %>%
  dplyr::summarize(range_cena = max(cena) - min(cena),
                   iqr_cena = IQR(cena),
                   var_cena = var(cena),
                   sd_cena = sd(cena),
                   mae_cena = mad(cena), 
                   cv_cena = sd(cena) / mean(cena) * 100) %>%
  as.data.frame()


mere_cena
##   range_cena iqr_cena var_cena  sd_cena mae_cena  cv_cena
## 1       1100 411.5385 81958.87 286.2846 294.8488 22.36614
```

 \footnotesize


# Analiza korelacije


## Pearson-ov koeficijent korelacije

Pirsonov koeficijent korelacije kvantifikuje nivo linearne korelacije između dve numeričke (kontinualne) promenljive.
Može imati vrednosti od -1 do 1.


 \scriptsize


```r

cor(stanovi$cena, stanovi$broj_soba, method = c("pearson"))
## [1] 0.0005657823

cor.test(stanovi$cena, stanovi$broj_soba, method = c("pearson"))
## 
## 	Pearson's product-moment correlation
## 
## data:  stanovi$cena and stanovi$broj_soba
## t = 0.024655, df = 1899, p-value = 0.9803
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.04439336  0.04552264
## sample estimates:
##          cor 
## 0.0005657823

# Vrednost oko nule nam ukazuje na slabu korelaciju!
```

 \footnotesize
Vrednost oko nule nam ukazuje na slabu korelaciju!


 \scriptsize


```r

# Cena - kvadratura
cor.test(stanovi$cena, stanovi$kvadratura, method = c("pearson"))
## 
## 	Pearson's product-moment correlation
## 
## data:  stanovi$cena and stanovi$kvadratura
## t = 2.7197, df = 1899, p-value = 0.006593
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.0173807 0.1069486
## sample estimates:
##        cor 
## 0.06229004


# Cena - stanje
cor.test(stanovi$cena, stanovi$stanje, method = c("pearson"))
## 
## 	Pearson's product-moment correlation
## 
## data:  stanovi$cena and stanovi$stanje
## t = 5.2188, df = 1348, p-value = 2.083e-07
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.08803685 0.19263379
## sample estimates:
##      cor 
## 0.140728
```

 \footnotesize

## Spearman-ov koeficijent korelacije

Spearman-ov koeficijent kvantifikuje broj uzoraka koju nisu u uređenom redosledu.


 \scriptsize


```r

cor(stanovi$cena, stanovi$broj_soba, method = c("spearman"))
## [1] -0.007807316
cor.test(stanovi$cena, stanovi$broj_soba, method = c("spearman"))
## 
## 	Spearman's rank correlation rho
## 
## data:  stanovi$cena and stanovi$broj_soba
## S = 1153911461, p-value = 0.7337
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##          rho 
## -0.007807316


# Vrednost oko nule nam ukazuje na slabu korelaciju!
```

 \footnotesize

 \scriptsize


```r

# Cena - kvadratura
cor.test(stanovi$cena, stanovi$kvadratura, method = c("spearman"))
## 
## 	Spearman's rank correlation rho
## 
## data:  stanovi$cena and stanovi$kvadratura
## S = 1126629343, p-value = 0.4851
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##        rho 
## 0.01602044


# Cena - stanje
cor.test(stanovi$cena, stanovi$stanje, method = c("spearman"))
## 
## 	Spearman's rank correlation rho
## 
## data:  stanovi$cena and stanovi$stanje
## S = 352558457, p-value = 2.3e-07
## alternative hypothesis: true rho is not equal to 0
## sample estimates:
##       rho 
## 0.1402319
```

 \footnotesize


## Korelacija dve kategorijske promenljive

Hi-kvadrat (eng. chi-squared) test nam kvantifikuje korelaciju dve kategorijske promenljive.
Primer: parking/novogradnja

Ako postavimo test hipoteze:
- Ho - Ne postoji veza između promenljive parking i novogradnja
- Ha - Postoji veza između promenljive parking i novogradnja


Za rezultat se dobija p vrednost, koja predstavlja verovatnoću događaja pod nultom hipotezom.
df predstavlja broj stepeni slobode, dok je X-squared vrednost kvantila X-sqaured raspodele.



 \scriptsize


```r

chisq.test(stanovi$parking, stanovi$novogradnja)
## 
## 	Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  stanovi$parking and stanovi$novogradnja
## X-squared = 22.197, df = 1, p-value = 2.461e-06
```

 \footnotesize




