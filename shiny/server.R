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
    naslov.drzave <- "Število potnikov preko letalskega prometa"
    zemljevid.letalski.promet <- ggplot() +
      geom_polygon(data = left_join(zemljevid, letalski_promet %>% filter(Cetrtletje == input$leto1), 
      by = c("NAME_LONG" = "Drzava")), aes(x = long, y = lat, group = group, fill = Stevilo_potnikov/100000), color = "black")+
      scale_fill_gradient2(low = "blanchedalmond", mid = "#e600ac", high = "#66004d", midpoint = 6) + 
      xlab("") + ylab("") + ggtitle(naslov.drzave) + theme(plot.title = element_text(hjust = 0.5)) +
      labs(fill = 'Število potnikov (x 100.000)') 
    print(zemljevid.letalski.promet)
  })  
  
  output$graf2 <- renderPlot({
    podatki <- turizem1 %>% filter(leto == input$leto)
    mls <- loess(data=podatki, prihodi_turistov_preko_letalskega_prometa ~ prihodi_turistov)
    graf.povezava <- ggplot(podatki, aes(x=prihodi_turistov/100000, 
      y=prihodi_turistov_preko_letalskega_prometa/100000)) + geom_point(shape=8) + xlab("Prihodi turistov ( x 100.000)") +
      ylab("Prihodi turistov preko letalsekga prometa (x 100.000)")  + 
      labs(title = "Povezava med prihodom vseh turistov in prihodom turistov preko letalskega prometa") +
      theme(plot.title = element_text(hjust = 0.5)) + geom_smooth(method="loess")
    print(graf.povezava)
  })
  
}
