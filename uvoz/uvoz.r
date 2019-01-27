# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark=".", grouping_mark=";")

# Funkcija, ki uvozi občine iz Eurostata kot HTML
uvozi.letalski_promet <- function() {
  link <- "podatki/letalski_promet.html"
  stran <-  read_html(link)
  tabela <- stran %>% html_nodes(xpath="//table") %>% .[[1]] %>% html_table()
  names(tabela) <- c("Drzava", outer(2008:2018, 1:4, paste, sep="Q") %>% t() %>% .[-c(43, 44)])
  tabela <- tabela %>% melt(id.vars="Drzava", value.name="Stevilo_potnikov") %>%
    separate("variable", c("leto", "Cetrtletje"), sep="Q") %>%
    transmute(Drzava, Cetrtletje=parse_date(paste(leto, (parse_number(Cetrtletje)-1)*3+1, 1, sep="-"),
                                            format="%Y-%m-%d"),
              Stevilo_potnikov=parse_number(Stevilo_potnikov, na=":", locale=locale(grouping_mark=","))) %>%
    filter(Drzava != "TIMEGEO")
  return(tabela)
}

# Funkcija, ki uvozi število prebivalcev po državah iz Wikipedije
uvozi.prebivalstvo <- function() {
  link <- "https://en.wikipedia.org/wiki/Demographics_of_Europe"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% 
    html_table(fill = TRUE, dec = ",") %>% .[[1]]
  # V tabeli želimo imeti le stolpec držav in število prebivalcev, zato ostale odstranimo
  tabela <- tabela[, ! names(tabela) %in% c("Area(km2)", "Population density(per km2)", "Capital"), drop = F]
  colnames(tabela) <- c("Drzava", "Stevilo_prebivalcev")
  tabela <- tabela %>% transmute(Drzava, Stevilo_prebivalcev=parse_number(Stevilo_prebivalcev, na=":", 
                                              locale=locale(grouping_mark=",")))
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke turizem_glede_na_transport.csv
uvozi.turizem_glede_na_transport <- function() {
  data <- read_csv2("podatki/turizem_glede_na_transport.csv", na="..",
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", 
         value.name="prihodi_turistov_preko_letalskega_prometa", na.rm=TRUE) %>%
    mutate(leto=parse_number(as.character(leto))) 
  data$prihodi_turistov_preko_letalskega_prometa <- data$prihodi_turistov_preko_letalskega_prometa * 1000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke turizem_na_splosno.csv
uvozi.turizem_na_splosno <- function() {
  data <- read_csv2("podatki/turizem_na_splosno.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="prihodi_turistov", na.rm=TRUE) %>% 
    mutate(leto=parse_number(as.character(leto)))
  data$prihodi_turistov <- data$prihodi_turistov * 1000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke izdatki_za_turizem.csv
uvozi.izdatki_za_turizem <- function() {
  data <- read_csv2("podatki/izdatki_za_turizem.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="izdatki_za_turizem_v_USD", na.rm=TRUE)%>% 
    mutate(leto=parse_number(as.character(leto)))
  data$izdatki_za_turizem_v_USD <- data$izdatki_za_turizem_v_USD * 1000000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke izdatki_za_transport.csv
uvozi.izdatki_za_transport <- function() {
  data <- read_csv2("podatki/izdatki_za_transport.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="izdatki_za_potniski_promet_v_USD", na.rm=TRUE) %>% 
    mutate(leto=parse_number(as.character(leto)))
  data$izdatki_za_potniski_promet_v_USD <- data$izdatki_za_potniski_promet_v_USD * 1000000
  return(data)
}

# Funkcija, ki uvozi podatke iz datoteke ustanovitve_za_turizem.csv
uvozi.ustanovitve_za_turizem <- function() {
  data <- read_csv2("podatki/ustanovitve_za_turizem.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="stevilo_ustanovljenih_enot_za_turizem", na.rm=TRUE) %>% 
    mutate(leto=parse_number(as.character(leto)))
}

# Funkcija, ki uvozi podatke iz datoteke ustanovitve_za_transport.csv
uvozi.ustanovitve_za_transport <- function() {
  data <- read_csv2("podatki/ustanovitve_za_transport.csv", na="..", 
                    locale=locale(encoding="Windows-1250"), skip=5) %>% .[-1, -1] %>%
    melt(id.vars="COUNTRY", variable.name="leto", value.name="stevilo_ustanovljenih_enot_za_potniski_promet", na.rm=TRUE) %>% 
    mutate(leto=parse_number(as.character(leto)))
}

# Zapišimo podatke v razpredelnico
turizem_glede_na_transport <- uvozi.turizem_glede_na_transport()
turizem_na_splosno <- uvozi.turizem_na_splosno()
izdatki_za_turizem <- uvozi.izdatki_za_turizem()
izdatki_za_transport <- uvozi.izdatki_za_transport()
ustanovitve_za_turizem <- uvozi.ustanovitve_za_turizem()
ustanovitve_za_transport <- uvozi.ustanovitve_za_transport()
letalski_promet <-  uvozi.letalski_promet()
prebivalstvo <- uvozi.prebivalstvo()


#V tabeli letalski_promet nas moti, da sta Nemčija in Makedonija zapisano z dodatnim opisom
letalski_promet$Drzava <- gsub("^Germany.*$", "Germany", letalski_promet$Drzava)
letalski_promet$Drzava <- gsub("^Former.*$", "Macedonia", letalski_promet$Drzava)

#Ker so podatki za ostale tabele za cel svet, izločimo samo evropske države
turizem_glede_na_transport <- turizem_glede_na_transport %>% filter(COUNTRY %in% c("Albania", 
    "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
    "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
    "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
    "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
    "United Kingdom", "Cyprus"))

turizem_na_splosno <- turizem_na_splosno %>% filter(COUNTRY %in% c("Albania", 
  "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
  "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
  "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
  "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
  "United Kingdom", "Cyprus"))

izdatki_za_turizem <- izdatki_za_turizem %>% filter(COUNTRY %in% c("Albania", 
  "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
  "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
  "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
  "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
  "United Kingdom", "Cyprus"))

izdatki_za_transport <- izdatki_za_transport %>% filter(COUNTRY %in% c("Albania", 
  "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
  "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
  "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
  "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
  "United Kingdom", "Cyprus"))

ustanovitve_za_turizem <- ustanovitve_za_turizem %>% filter(COUNTRY %in% c("Albania", 
  "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
  "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
  "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
  "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
  "United Kingdom", "Cyprus"))

ustanovitve_za_transport <- ustanovitve_za_transport %>% filter(COUNTRY %in% c("Albania", 
  "Austria", "Belarus", "Belgium", "Bosnia And Herzegovina", "Bulgaria", "Croatia", "Czech Republic",
  "Denmark", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Italy", "Latvia", "Lithuania", 
  "Luxembourg", "Malta", "Monaco", "Montenegro", "Netherlands", "Norway", "Poland", "Portugal", "Romania", 
  "Russian Federation", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Ukraine",
  "United Kingdom", "Cyprus"))



# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
