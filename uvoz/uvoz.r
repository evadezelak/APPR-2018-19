# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=".", grouping_mark=",")



# Funkcija, ki uvozi podatke iz datoteke turizem_glede_na_transport.csv
uvozi.turizem_glede_na_transport <- function() {
  data <- read_csv("podatki/turizem_glede_na_transport.csv", col_names=c("turizem_glede_na_transport"),
                    locale=locale(encoding="Windows-1250"))
  data <- data[-c(1),]
  #colnames(data)[1] <- "leto"
  #data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    #strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
  #data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  #data <- data %>% melt(id.vars="obcina", variable.name="velikost.druzine",
              #          value.name="stevilo.druzin")
  #data$velikost.druzine <- parse_number(data$velikost.druzine)
  #data$obcina <- factor(data$obcina, levels=obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico
turizem_glede_na_transport <- uvozi.turizem_glede_na_transport()

# Zapišimo podatke v razpredelnico druzine.
#druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
