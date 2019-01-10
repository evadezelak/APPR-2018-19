# 3. faza: Vizualizacija podatkov

graf.turizem.transport <- ggplot(data = turizem_glede_na_transport) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa), color = "blue") +
  labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov") + theme(plot.title = element_text(hjust = 0.5))

drzave.2016 <- turizem_glede_na_transport %>% filter(leto == 2016) %>%
  top_n(10, prihodi_turistov_preko_letalskega_prometa)

graf.turisti <- ggplot(data = turizem_glede_na_transport %>% filter(COUNTRY %in% drzave.2016$COUNTRY), 
                       aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa, label = COUNTRY)) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa ), color = "red") +
  geom_line(aes(group = COUNTRY, x = leto, y = prihodi_turistov_preko_letalskega_prometa, color=COUNTRY)) +
  labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov")  + theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(size = (10)), 
          panel.background=element_rect(fill="#F5D0A9"), plot.title = element_text(size = (15)))
 
graf.turisti

turizem.transport.span.lit <- turizem_glede_na_transport %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
turizem.span.lit <- turizem_na_splosno %>% filter(COUNTRY %in% c("Spain", "Lithuania"))
#zdruzena <- join(turizem.transport.span.lit, turizem.span.lit, type = "inner")
zdruzena <- rbind(turizem.span.lit %>% rename(Prihodi=prihodi_turistov) %>% mutate(Kategorija="Vsi prihodi"),
                  turizem.transport.span.lit %>% rename(Prihodi=prihodi_turistov_preko_letalskega_prometa) %>%
                    mutate(Kategorija="Prihodi preko letalskega prometa"))

graf.spa.lit <- ggplot(data = zdruzena, aes(x= leto, y = Prihodi/1000, fill = Kategorija, group = COUNTRY)) +
  geom_col(position = "dodge") + ylab("Prihodi (x1000)") + xlab("Leto") +
  labs(title ="Primerjava Španije in Litve") + theme(plot.title = element_text(hjust = 0.5))
    
graf.spa.lit

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
 #                            pot.zemljevida="OB", encoding="Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
 # { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))
#zemljevid <- fortify(zemljevid)

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
 # summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))
