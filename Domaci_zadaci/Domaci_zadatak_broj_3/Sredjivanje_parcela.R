library(sf)
library(dplyr)
library(magrittr)
library(writexl)

parc <- sf::st_read("data/Parcels_SOC_new.gpkg")

parc.list <- list()
for(i in 1:10){
  
  parcc <- parc[i, ]
  
  parcc %<>% st_transform(3909) %>%
    st_coordinates() %>%
    as.data.frame() %>%
    dplyr::select(X, Y)
  parc.list[[i]] <- parcc
}

parc.list

for(i in 1:length(parc.list)){
  
  write.csv(parc.list[[i]], paste0("Domaci_zadaci/Domaci_zadatak_broj_3/Parcele/Parcela_", i, ".csv"))
  
}
