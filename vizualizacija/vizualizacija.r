# 3. faza: Vizualizacija podatkov

#Graf za turizem glede na transport za najbolj razvitih 10 držav
drzave.2016 <- turizem_glede_na_transport %>% filter(leto == 2016) %>%
  top_n(10, prihodi_turistov_preko_letalskega_prometa)

graf.turisti <- ggplot(data = turizem_glede_na_transport %>% filter(COUNTRY %in% drzave.2016$COUNTRY), 
                       aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000, label = COUNTRY)) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000 ), color = "red") +
  geom_line(aes(group = COUNTRY, x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000, color=COUNTRY)) +
  labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov (x 100.000)")  + theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(size = (9)), 
          panel.background=element_rect(fill="#F5ECCE"), plot.title = element_text(size = (15))) + 
  scale_color_manual(name = "Države", labels = c("Hrvaška", "Ciper", "Francija", "Nemčija", "Grčija", "Madžarska",
                                                "Italija", "Poljska", "Španija", "Velika Britanija"),
                     values = c("#0000b3", "#3399ff", "#00ff99", "#33cc33", "#008000", "#ff9900", 
                                "#ff3300", "#cc0000", "#993366", "#ff00ff"))

# Graf za primerjavo med dobro (Španija) in slabše (Litva) razvito državo
# Da bo graf bolj realen, bom vzela relativne podatke, zato bom število turistov, ki pridejo v državo,
# delila s število prebivalcev tiste države
prebivalci.litve1 <- prebivalstvo %>% filter(Drzava == "Lithuania")
prebivalci.litve <- prebivalci.litve1[1,"Stevilo_prebivalcev"]
prebivalci.spanije1 <- prebivalstvo %>% filter(Drzava == "Spain")
prebivalci.spanije <- prebivalci.spanije1[1,"Stevilo_prebivalcev"]
turizem.transport.span.lit <- turizem_glede_na_transport %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
turizem.span.lit <- turizem_na_splosno %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
zdruzena <- rbind(turizem.span.lit %>% rename(Prihodi=prihodi_turistov) %>% mutate(Kategorija="Vsi prihodi"),
                  turizem.transport.span.lit %>% rename(Prihodi=prihodi_turistov_preko_letalskega_prometa) %>%
                    mutate(Kategorija="Prihodi preko letalskega prometa"))

zdruzena$Prihodi[zdruzena$COUNTRY == "Spain"] <- zdruzena$Prihodi[zdruzena$COUNTRY == "Spain"] / prebivalci.spanije
zdruzena$Prihodi[zdruzena$COUNTRY == "Lithuania"] <- zdruzena$Prihodi[zdruzena$COUNTRY == "Lithuania"] / prebivalci.litve

graf.spa.lit <- ggplot(data = zdruzena, aes(x= leto, y = Prihodi, fill = Kategorija, group = COUNTRY)) +
  geom_col(position = "dodge") + ylab("Prihodi") + xlab("Leto") +
  labs(title ="Primerjava Španije in Litve") + theme(plot.title = element_text(hjust = 0.5))

#Grafa za pregled razvoja turizma in transporta v Španiji  
ustanovitve.turizem.spa <- ustanovitve_za_turizem %>% filter(COUNTRY %in% c("Spain"))
ustanovitve.transport.spa <- ustanovitve_za_transport %>% filter(COUNTRY %in% c("Spain"))
zdruzena.ustanovitve.spa <- rbind(ustanovitve.turizem.spa %>% 
        rename(Stevilo_ustanovljenih=stevilo_ustanovljenih_enot_za_turizem) %>% 
        mutate(Kategorija="Ustanovitve za turizem"), ustanovitve.transport.spa %>% 
        rename(Stevilo_ustanovljenih=stevilo_ustanovljenih_enot_za_potniski_promet) %>% 
        mutate(Kategorija="Ustanovitve za potniški promet"))

graf.ustanovitve.spa <- ggplot(data = zdruzena.ustanovitve.spa, aes(x=leto, y=Stevilo_ustanovljenih/1000, 
  fill= Kategorija, group = COUNTRY)) + geom_col(position = "dodge") + xlab("Leto") +
  ylab("Število ustanovljenih enot (x 1000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#ffcc80')) +
  labs(title ="Ustanavljanje v Španiji") + theme(plot.title = element_text(hjust = 0.5))

izdatki.turizem.spa <- izdatki_za_turizem %>% filter(COUNTRY %in% c("Spain"))
izdatki.transport.spa <- izdatki_za_transport %>% filter(COUNTRY %in% c("Spain"))
zdruzena.izdatki.spa <- rbind(izdatki.turizem.spa %>% 
                            rename(Izdatki=izdatki_za_turizem_v_USD) %>% 
                            mutate(Kategorija="Izdatki za turizem"), izdatki.transport.spa %>% 
                            rename(Izdatki=izdatki_za_potniski_promet_v_USD) %>% 
                            mutate(Kategorija="Izdatki za potniški promet"))

graf.izdatki.spa <- ggplot(data = zdruzena.izdatki.spa, aes(x=leto, y=Izdatki/100000000, 
  fill= Kategorija, group = COUNTRY)) + geom_col(position = "dodge") + xlab("Leto") +
  ylab("Izdatki v USD (x 100.000.000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#ffcc80')) +
  labs(title ="Izdatki v Španiji") + theme(plot.title = element_text(hjust = 0.5)) 


#Grafa za pregled razvoja turizma in transporta v Litvi
ustanovitve.turizem.lit <- ustanovitve_za_turizem %>% filter(COUNTRY %in% c("Lithuania"))
ustanovitve.transport.lit <- ustanovitve_za_transport %>% filter(COUNTRY %in% c("Lithuania"))
zdruzena.ustanovitve.lit <- rbind(ustanovitve.turizem.lit %>% 
                                rename(Stevilo_ustanovljenih=stevilo_ustanovljenih_enot_za_turizem) %>% 
                                mutate(Kategorija="Ustanovitve za turizem"), ustanovitve.transport.lit %>% 
                                rename(Stevilo_ustanovljenih=stevilo_ustanovljenih_enot_za_potniski_promet) %>% 
                                mutate(Kategorija="Ustanovitve za potniški promet"))

graf.ustanovitve.lit <- ggplot(data = zdruzena.ustanovitve.lit, aes(x=leto, y=Stevilo_ustanovljenih/100, 
  fill= Kategorija, group = COUNTRY)) + geom_col(position = "dodge") + xlab("Leto") +
  ylab("Število ustanovljenih enot (x 100)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#ffcc80')) +
  labs(title ="Ustanavljanje v Litvi") + theme(plot.title = element_text(hjust = 0.5))

izdatki.turizem.lit <- izdatki_za_turizem %>% filter(COUNTRY %in% c("Lithuania"))
izdatki.transport.lit <- izdatki_za_transport %>% filter(COUNTRY %in% c("Lithuania"))
zdruzena.izdatki.lit <- rbind(izdatki.turizem.lit %>% 
                                rename(Izdatki=izdatki_za_turizem_v_USD) %>% 
                                mutate(Kategorija="Izdatki za turizem"), izdatki.transport.lit %>% 
                                rename(Izdatki=izdatki_za_potniski_promet_v_USD) %>% 
                                mutate(Kategorija="Izdatki za potniški promet"))

graf.izdatki.lit <- ggplot(data = zdruzena.izdatki.lit, aes(x=leto, y=Izdatki/100000000, 
  fill= Kategorija, group = COUNTRY)) + geom_col(position = "dodge") + xlab("Leto") +
  ylab("Izdatki v USD (x 100.000.000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#ffcc80')) +
  labs(title ="Izdatki v Litvi") + theme(plot.title = element_text(hjust = 0.5))

#Osredotočimo se na sam letalski promet, in sicer najprej na povprečje po državah za vsa leta
izracunaj.povprecje <- function() {
  letalski_promet <- letalski_promet %>% drop_na()
  povprecje.po.drzavah <- letalski_promet %>% group_by(Drzava) %>% 
    summarise(Povprecje.potnikov = mean(Stevilo_potnikov)) 
  return(povprecje.po.drzavah)
}

povprecje.po.drzavah <- izracunaj.povprecje()

#uredimo drzave glede na povprečno število potnikov skozi preučevano obdobje
povprecje.po.drzavah$Drzava <- factor(povprecje.po.drzavah$Drzava, levels = povprecje.po.drzavah$Drzava[order(povprecje.po.drzavah$Povprecje.potnikov)])

graf.povprecje.po.drzavah <- ggplot(data=povprecje.po.drzavah, aes(x=Drzava, y=Povprecje.potnikov/10000)) + 
  geom_bar(stat = 'identity', position = 'dodge') + coord_flip() + labs(title ="Povprečje potnikov po državah") +
  ylab("Povprečje potnikov (x 10.000)") + xlab("Država") + theme(plot.title = element_text(hjust = 0.5))



#Zanima me, kako se letalski promet giblje glede na cetrtletja in sicer konkretno za Španijo
letalski.promet.spa <- letalski_promet %>% filter(Drzava %in% c("Spain"))

graf.letalski.promet.spa <- ggplot(data = letalski.promet.spa, aes(x=Cetrtletje, y=Stevilo_potnikov/100000, 
  label=Drzava)) + geom_point(aes(x=Cetrtletje, y=Stevilo_potnikov/100000), color = "red") + geom_line() + 
  labs(title = "Število potnikov po četrtletjih v Španiji") + theme(plot.title = element_text(hjust = 0.5)) +
  ylab("Število potnikov (x 100.000)") + xlab("Četrtletje")

  



#Uvozimo zemljevid.
source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")

zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                            "ne_50m_admin_0_countries", mapa = "zemljevidi", pot.zemljevida = "", encoding = "UTF-8") %>% 
  fortify() %>% filter(CONTINENT == "Europe" | SOVEREIGNT %in% c("Cyprus"), long < 45 & long > -45 & lat > 30 & lat < 75)

colnames(zemljevid)[11] <- 'drzava'
zemljevid$drzava <- as.character(zemljevid$drzava)
zemljevid$drzava[zemljevid$drzava == "Republic of Serbia"] <- "Serbia"


#Narišimo zemljevid povprečnega števila potnikov preko letalskega prometa po državah
zemljevid.povprecje.letalskega.prometa <- ggplot() +
  geom_polygon(data = povprecje.po.drzavah %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
  aes(x = long, y = lat, group = group, fill = Povprecje.potnikov/10000), alpha = 0.8, color = "black")+
  scale_fill_gradient2(low = "green", mid = "yellow", high = "red", midpoint = 80) + 
  xlab("") + ylab("") + ggtitle("Povprečno število potnikov preko letalskega prometa (x 10.000)")+
  guides(fill=guide_legend(title="Povprečje")) + theme(plot.title = element_text(hjust = 0.5))

zemljevid.povprecje.letalskega.prometa
#Narišimo zemljevid povprečnega števila prihodov turistov v državo
izracunaj.povprecje1 <- function() {
  turizem_na_splosno <- turizem_na_splosno %>% drop_na()
  povprecje.turizma <- turizem_na_splosno %>% group_by(COUNTRY) %>% 
    summarise(Povprecje.turistov = mean(prihodi_turistov)) 
  return(povprecje.turizma)
}

povprecje.turizma <- izracunaj.povprecje1()
povprecje.turizma$COUNTRY[povprecje.turizma$COUNTRY == "Czech Republic"] <- "Czechia"
povprecje.turizma$COUNTRY[povprecje.turizma$COUNTRY == "Russian Federation"] <- "Russia"

zemljevid.turisti <- ggplot() +
  geom_polygon(data = povprecje.turizma %>% right_join(zemljevid, by = c("COUNTRY" = "drzava")),
  aes(x = long, y = lat, group = group, fill = Povprecje.turistov/100000), alpha = 0.8, color = "black")+
  scale_fill_gradient2(low = "yellow", mid = "green", high = "blue", midpoint = 80) + 
  xlab("") + ylab("") + ggtitle("Povprečno število turistov (x 100.000)")+
  guides(fill=guide_legend(title="Povprečje")) + theme(plot.title = element_text(hjust = 0.5))
        

# Naredimo zemljevid, ki bo države razvrstil v skupine
drzave.2017 <- letalski_promet %>% filter(Cetrtletje == "2017-01-01")
drzave.2017 <- drzave.2017[, ! names(drzave.2017) %in% c("Cetrtletje"), drop = F]
drzave.2017 <- drzave.2017[-c(34),]
drzave.norm <- drzave.2017 %>% select(-Drzava) %>% scale()
rownames(drzave.norm) <- drzave.2017$Drzava
k <- kmeans(na.omit(drzave.norm), 2, nstart = 100000)
skupine <- data.frame(Drzava=drzave.2017$Drzava, skupina=factor(k$cluster))

zemljevid.skupine <- ggplot() + geom_polygon(data=zemljevid %>% left_join(skupine, by=c("NAME_LONG"="Drzava")),
            aes(x=long, y=lat, group=group, fill=skupina)) + xlab("") + ylab("") + 
            ggtitle("Države po skupinah")+ guides(fill=guide_legend(title="Skupine")) + 
            theme(plot.title = element_text(hjust = 0.5)) 

