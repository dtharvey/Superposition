# ui for principle of superposition
library(shiny)
library(shinythemes)


ui = navbarPage("Analytical Chemistry 3.0",
                theme = shinytheme("journal"),
                tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
          ),
              tabPanel("Visualizing the Superposition of Waves",    
                fluidRow(
                  column(width = 6,
                    wellPanel(
                      includeHTML("superposition.html")
          )     
          ),
                  column(width = 6,
                         align = "center",
                    splitLayout(
                      selectInput("wavetype", 
                                  label = "type of wave",
                                  choices = c("sine wave",
                                              "square wave", 
                                              "triangle wave",
                                              "sawtooth wave"),
                                  selectize = FALSE, width = "150px"),
                      sliderInput("n1","number of sine waves to add",
                                  min = 0, max = 10, value = 0,
                                  width = "300px", step = 1),
                      radioButtons("waves","show individual sine waves?",
                                   choices = c("yes","no"), selected = "no",
                                   inline = TRUE, width = "150px")
          ),
                    plotOutput("squarewave", height = "550px"),
                    uiOutput("waveequation")
          )
          )
          )
        
          
          
          )# close ui
