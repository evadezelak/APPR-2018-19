# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=".", grouping_mark=";")

# Funkcija, ki uvozi občine iz Eurostata kot HTML
uvozi.letalski_promet <- function() {
  link <- "file:///C:/FAKS/2.%20letnik/analiza%20podatkov%20s%20programom%20r/projekt/APPR-2018-19/podatki/letalski_promet1.html"
  stran <-  read_html(link)
  tabela <- stran %>% html_nodes(xpath="//table[@class='neki']")
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
}

# Funkcija, ki uvozi podatke iz datoteke turizem_glede_na_transport.csv
uvozi.turizem_glede_na_transport <- function() {
  data <- read_csv2("podatki/turizem_glede_na_transport.csv", na="..",
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", 
         value.name="prihodi_turistov_preko_letalskega_prometa", na.rm=TRUE) 
  data$prihodi_turistov_preko_letalskega_prometa <- data$prihodi_turistov_preko_letalskega_prometa * 1000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke turizem_na_splosno.csv
uvozi.turizem_na_splosno <- function() {
  data <- read_csv2("podatki/turizem_na_splosno.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="prihodi_turistov", na.rm=TRUE)
  data$prihodi_turistov <- data$prihodi_turistov * 1000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke izdatki_za_turizem.csv
uvozi.izdatki_za_turizem <- function() {
  data <- read_csv2("podatki/izdatki_za_turizem.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="izdatki_za_turizem_v_USD", na.rm=TRUE)
  data$izdatki_za_turizem_v_USD <- data$izdatki_za_turizem_v_USD * 1000000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke izdatki_za_transport.csv
uvozi.izdatki_za_transport <- function() {
  data <- read_csv2("podatki/izdatki_za_transport.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="izdatki_za_potniski_promet_v_USD", na.rm=TRUE)
  data$izdatki_za_potniski_promet_v_USD <- data$izdatki_za_potniski_promet_v_USD * 1000000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke ustanovitve_za_turizem.csv
uvozi.ustanovitve_za_turizem <- function() {
  data <- read_csv2("podatki/ustanovitve_za_turizem.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="stevilo_ustanovljenih_enot_za_turizem", na.rm=TRUE)
}

# Funkcija, ki uvozi podatke iz datoteke ustanovitve_za_transport.csv
uvozi.ustanovitve_za_transport <- function() {
  data <- read_csv2("podatki/ustanovitve_za_transport.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="stevilo_ustanovljenih_enot_za_potniski_promet", na.rm=TRUE)
}

# Zapišimo podatke v razpredelnico
turizem_glede_na_transport <- uvozi.turizem_glede_na_transport()
turizem_na_splosno <- uvozi.turizem_na_splosno()
izdatki_za_turizem <- uvozi.izdatki_za_turizem()
izdatki_za_transport <- uvozi.izdatki_za_transport()
ustanovitve_za_turizem <- uvozi.ustanovitve_za_turizem()
ustanovitve_za_transport <- uvozi.ustanovitve_za_transport()
letalski_promet <-  uvozi.letalski_promet()


# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
