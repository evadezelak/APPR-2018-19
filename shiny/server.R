library(shiny)

function(input, output) {
  
  output$graf1 <- renderPlot({
    graf.turizem <- ggplot(turizem %>% filter(COUNTRY == input$drzava)) + 
      aes(x = leto, y = Prihodi/100000, color = Kategorija) + geom_line()+
      labs(title = "Prihodi turistov v posamezno državo") + theme(plot.title = element_text(hjust = 0.5)) +
      ylab("Prihodi (x 100.000)") + xlab("Leto")
    print(graf.turizem)
  })
  
  
  
  output$zemljevid1 <- renderPlot({
    naslov.drzave <- "Število potnikov preko letalskega prometa za posamezne države"
    zemljevid.letalski.promet <- ggplot() +
      geom_polygon(data = left_join(zemljevid, letalski_promet %>% filter(Cetrtletje == input$leto1), 
      by = c("NAME_LONG" = "Drzava")), aes(x = long, y = lat, group = group, fill = Stevilo_potnikov/100000), color = "black")+
      scale_fill_gradient2(low = "blanchedalmond", mid = "#e600ac", high = "#66004d", midpoint = 6) + 
      xlab("") + ylab("") + ggtitle(naslov.drzave) + theme(plot.title = element_text(hjust = 0.5)) +
      labs(fill = 'Število potnikov (x 100.000)') 
    print(zemljevid.letalski.promet)
  })  
  
  #output$graf2 <- renderPlot({
   # podatki <- brezposelnost_in_obsojeni2 %>% filter(obsojeni < 10 & brezposelni < 25) %>% filter(leto == input$leto2)
    #LM <- lm(obsojeni ~ brezposelni, data=podatki)
    #novi.brezposelni <- data.frame(brezposelni=c(25, 30,35))
    #predict(LM, novi.brezposelni)
    #napoved <- novi.brezposelni %>% mutate(obsojeni=predict(LM, .))
    #graf.povezava <- ggplot(podatki, aes(x = brezposelni, y = obsojeni)) + 
     # geom_point(shape=1) + 
      #geom_smooth(method=lm, se = FALSE, fullrange = TRUE) +
      #geom_point(data=napoved, aes(x = brezposelni, y = obsojeni), color='red', size=3)+
      #labs(title = "Povezava med stopnjo brezposelnih in obsojenih")
    #print(graf.povezava)
  #})
  
}
