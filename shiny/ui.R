library(shiny)

fluidPage(
  titlePanel(""),
  
  tabPanel("Graf",
           sidebarPanel(
             selectInput("drzava", label = "Izberi državo", 
                         choices = unique(turizem_na_splosno$COUNTRY))),
           mainPanel(plotOutput("graf1"))),
  
  tabPanel("Zemljevid",
           sidebarPanel(
             selectInput("leto1", label = "Izberi četrtletje", 
                         choices = unique(letalski_promet$Cetrtletje))),
           mainPanel(plotOutput("zemljevid1")))
)
