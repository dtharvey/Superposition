# ui for principle of superposition
library(shiny)
library(shinythemes)


ui = navbarPage("AC 3.0: Superposition of Waves",
                theme = shinytheme("journal"),
                header= tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css",
                            href = "style.css")
          ),
          
          # introduction tabPanel
          tabPanel("Introduction",
                   fluidRow(
                     withMathJax(),
                     column(width = 6,
                            wellPanel(
                              includeHTML("text/introduction.html")
                            )),
                     column(width = 6,
                            plotOutput("introplot", height = "700px"))
                   )),
          
              tabPanel("Superposition of Two Sine Waves",
                fluidRow(
                  column(width = 6,
                         wellPanel(
                           includeHTML("text/twosinewaves.html")
                         )),
                  column(width = 6,
                         align = "center",
                    splitLayout(
                      sliderInput("A", "Amplitude (A) for y2",
                                  min = -2, max = 2, value = 2,
                                  step = 0.25, width = "175px", ticks = FALSE),
                      sliderInput("a", "periodicity (a) for y2",
                                  min = 1, max = 5, value = 2,
                                  step = 1, width = "175px", ticks = FALSE),
                      sliderInput("phase", "phase angle (nπ) for y2",
                                  min = 0, max = 2, value = 0.5,
                                  step = 0.25, width = "175px", ticks = FALSE),
                      radioButtons("showy3", "display sum (y3)?", 
                                   choices = c("yes", "no"), 
                                   selected = "no", inline = TRUE)
                    ),
                    plotOutput("twosinewaves", height = "600px"))
                )),
          
              tabPanel("Superposition of Many Sine Waves",    
                fluidRow(
                  column(width = 6,
                    wellPanel(
                      includeHTML("text/complexwaves.html")
          )     
          ),
                  column(width = 6,
                         align = "center",
                    splitLayout(
                      selectInput("wavetype", 
                                  label = "type of wave",
                                  choices = c("square wave", 
                                              "triangle wave",
                                              "sawtooth wave"),
                                  selectize = FALSE, width = "150px"),
                      sliderInput("n1","number of sine waves",
                                  min = 0, max = 15, value = 0,
                                  step = 1, ticks = FALSE),
                      radioButtons("waves","show individual sine waves?",
                                   choices = c("yes","no"), selected = "no",
                                   inline = TRUE)
          ),
                    plotOutput("complexwaves", height = "550px"),
                    uiOutput("waveequation")
          )
          )
          ),
          tabPanel("Wrapping Up",
            fluidRow(
              column(width = 6,
                     wellPanel(id = "wrapuppanel",
                               style = "overflow-y:scroll; max-height: 750px",
                       includeHTML("text/wrapup.html")
                     )),
              column(width = 6,
                     align = "center",
                     splitLayout(
                       downloadButton("sq", "download square wave"),
                       downloadButton("tr", "download triangular wave"),
                       downloadButton("saw", "download sawtooth wave")
                     ),
                     plotOutput("wrapup", height = "550px"))
            ))
        
          
          
          )# close ui
