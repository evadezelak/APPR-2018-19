# 3. faza: Vizualizacija podatkov

graf.turizem.transport <- ggplot(data = turizem_glede_na_transport) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa), color = "blue") +
  labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov") + theme(plot.title = element_text(hjust = 0.5))

graf.turisti <- ggplot(data = turizem_glede_na_transport, 
                       aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa, label = COUNTRY)) + 
  geom_point(aes(x = leto, y = prihodi_turistov_preko_letalskega_prometa ), color = "red") +
  geom_line(aes(group = COUNTRY, x = leto, y = prihodi_turistov_preko_letalskega_prometa)) +
  geom_text(check_overlap = TRUE) + labs(title ="Prihodi turistov preko letalskega prometa za posamezno leto") +
  xlab("Leto") + ylab("Število potnikov")  + theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title = element_text(size = (10)), 
          panel.background=element_rect(fill="#F5D0A9"), plot.title = element_text(size = (15)))
 
graf.turisti

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
