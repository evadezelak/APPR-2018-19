# 3. faza: Vizualizacija podatkov

#Graf za turizem glede na transport za najbolj razvitih 10 držav
drzave.2016 <- turizem_glede_na_transport %>% filter(leto == 2016) %>%
  top_n(10, prihodi_turistov_preko_letalskega_prometa)

graf.turisti <- ggplot(data = turizem_glede_na_transport %>% filter(COUNTRY %in% drzave.2016$COUNTRY), 
                       aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000, label = COUNTRY)) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000 ), color = "red") +
  geom_line(aes(group = COUNTRY, x = leto, y = prihodi_turistov_preko_letalskega_prometa/100000, color=COUNTRY)) +
  labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov(x100.000)")  + theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(size = (10)), 
          panel.background=element_rect(fill="#F5ECCE"), plot.title = element_text(size = (15)))
 
#Graf za primerjavo med dobro (Španija) in slabše (Litva) razvito državo
turizem.transport.span.lit <- turizem_glede_na_transport %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
turizem.span.lit <- turizem_na_splosno %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
zdruzena <- rbind(turizem.span.lit %>% rename(Prihodi=prihodi_turistov) %>% mutate(Kategorija="Vsi prihodi"),
                  turizem.transport.span.lit %>% rename(Prihodi=prihodi_turistov_preko_letalskega_prometa) %>%
                    mutate(Kategorija="Prihodi preko letalskega prometa"))

graf.spa.lit <- ggplot(data = zdruzena, aes(x= leto, y = Prihodi/1000, fill = Kategorija, group = COUNTRY)) +
  geom_col(position = "dodge") + ylab("Prihodi (x1000)") + xlab("Leto") +
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
  ylab("Število ustanovljenih enot (x1000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#f9a635')) +
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
  ylab("Izdatki v USD (x100.000.000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#f9a635')) +
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
  ylab("Število ustanovljenih enot (x100)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#f9a635')) +
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
  ylab("Izdatki v USD (x100.000.000)") + scale_fill_manual("Kategorija",values = c('#0023a0', '#f9a635')) +
  labs(title ="Izdatki v Litvi") + theme(plot.title = element_text(hjust = 0.5))

#Osredotočimo se na sam letalski promet, in sicer najprej na povprečje po državah za vsa leta
izracunaj.povprecje <- function() {
  letalski_promet <- letalski_promet %>% drop_na()
  povprecje.po.drzavah <- letalski_promet %>% group_by(Drzava) %>% 
    summarise(Povprecje.potnikov = mean(Stevilo_potnikov)) 
  return(povprecje.po.drzavah)
}

povprecje.po.drzavah <- izracunaj.povprecje()

graf.povprecje.po.drzavah <- ggplot(data=povprecje.po.drzavah, aes(x=Drzava, y=Povprecje.potnikov/10000)) + 
  geom_bar(stat = 'identity', position = 'dodge') + coord_flip() + labs(title ="Povprečje potnikov po državah") +
  ylab("Povprečje potnikov(x10.000)") + theme(plot.title = element_text(hjust = 0.5))


#Zanima me, kako se letalski promet giblje glede na cetrtletja in sicer konkretno za Španijo
letalski.promet.spa <- letalski_promet %>% filter(Drzava %in% c("Spain"))

graf.letalski.promet.spa <- ggplot(data = letalski.promet.spa, aes(x=Cetrtletje, y=Stevilo_potnikov/100000, 
  label=Drzava)) + geom_point(aes(x=Cetrtletje, y=Stevilo_potnikov/100000), color = "red") + geom_line() + 
  labs(title = "Število potnikov po četrtletjih v Španiji") + theme(plot.title = element_text(hjust = 0.5)) +
  ylab("Število potnikov(x100.000)")
graf.letalski.promet.spa
  



 #Uvozimo zemljevid.
#source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")

#zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
 #                            "ne_50m_admin_0_countries", mapa = "zemljevidi", pot.zemljevida = "", encoding = "UTF-8") %>% 
  #fortify() %>% filter(CONTINENT == "Europe" | SOVEREIGNT %in% c("Cyprus"), long < 45 & long > -45 & lat > 30 & lat < 75)

#ggplot() + geom_polygon(data=zemljevid, aes(x=long, y=lat, group=group, fill=id)) + guides(fill=FALSE)


#zemljevid <- ggplot() + geom_polygon(data=left_join(zemljevid, ujemanje, by=c("NAME"="Country")),
#  aes(x="Drzava", y="Povprecje.potnikov", group=group)) + guides(fill=guide_colorbar(title="zemljevid"))
        
