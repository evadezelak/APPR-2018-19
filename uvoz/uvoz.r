# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=".", grouping_mark=";")

# Funkcija, ki uvozi občine iz Eurostata kot HTML
uvozi.letalski_promet <- function() {
  link <- "file:///U:/APPR-2018-19/podatki/letalski_promet.html"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke turizem_glede_na_transport.csv
uvozi.turizem_glede_na_transport <- function() {
  data <- read_csv2("podatki/turizem_glede_na_transport.csv", na="..",
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="stevilo", na.rm=TRUE) %>%
    mutate(leto=parse_number(leto))
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
