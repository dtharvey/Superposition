# server for superposition of waves

# load packages
library(shiny)
library(shinythemes)

# set colors
palette("Okabe-Ito")

# load data files and/or source scripts
squarewave = read.csv("squarewave.csv")
trianglewave = read.csv("trianglewave.csv")
sawtoothwave = read.csv("sawtoothwave.csv")

# set common variables
x = seq(0, 4*pi, 0.01*pi)

shinyServer(function(input,output,session){
  
  observe({
    wavebutton = input$wavetype
    if (wavebutton == "sine wave"){
      updateRadioButtons(session, "waves", selected = "yes")
      updateSliderInput(session, "n1", 
                        value = 0,
                        label = "increment of phase angle")
    }
    if (wavebutton != "sine wave"){
      updateRadioButtons(session, "waves", selected = "no")
      updateSliderInput(session, "n1",
                        value = 0,
                        label = "number of sine waves to add")
    }
  })
  
  output$squarewave = renderPlot({
    
    # code when selecting sine wave
    if(input$wavetype == "sine wave"){
      if (input$n1 == 0){
        plot(x = x, y = sin(x), type = "l", lty = 1, col = 8, lwd = 4, 
             ylim = c(-2,2), ylab = "y", xaxt = "n")
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-2,-1,0,1,2), col = 9, lty = 3)
      }
      if (input$n1 != 0){
        plot(x = x, y = round(sin(x) + sin(x - input$n1*2*pi/10),2), 
             type = "l", col = 8,lwd = 4, ylim = c(-2,2), 
             ylab = "y", xaxt = "n")
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        if (input$waves == "yes"){
        lines(x = x, y = sin(x), lty = 2, col = 4, lwd = 2)
        lines(x = x, y = sin(x + input$n1*2*pi/10), lwd = 2, 
              lty = 3, col = 8)
        }
        legend(x = "topright", 
               legend = c("original","phase-shifted", "sum"), 
               lwd = c(2,2,4), col = c(4,4,8), lty = c(2,3,1),
               bty = "n")
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-2,-1,0,1,2), col = 9, lty = 3)
      }
    }
    
    # code when selecting square wave
    if(input$wavetype == "square wave"){
    number_cols = input$n1
    if (number_cols == 0){
      plot(x = c(0,0,pi,pi,2*pi,2*pi,3*pi,3*pi,4*pi,4*pi), 
            y = c(0,1,1,-1,-1,1,1,-1,-1,0), 
           ylim = c(min(squarewave),max(squarewave)),
           type = "l", lwd = 4, lty = 3, col = 6,
           xlab = "x", ylab = "y", xaxt = "n")
      axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
           labels = c("0", "π", "2π", "3π", "4π"))
      abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
      abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
    }
    if (number_cols == 1){
      ysum = squarewave[,1]
      plot(x = x, y = ysum, type = "l", lty = 1, lwd = 4, 
           col = 8, xaxt = "n")
      lines(x = c(0,0,pi,pi,2*pi,2*pi,3*pi,3*pi,4*pi,4*pi), 
            y = c(0,1,1,-1,-1,1,1,-1,-1,0),lwd = 4, lty = 3, col = 6)
      axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
           labels = c("0", "π", "2π", "3π", "4π"))
      abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
      abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
    } 
    if (number_cols > 1) {
      ysum = apply(squarewave[,1:number_cols], MARGIN = 1, FUN = sum)
      plot(x = x, y = ysum, type = "l", lty = 1, lwd = 4, 
           col = 8, xaxt = "n")
      lines(x = c(0,0,pi,pi,2*pi,2*pi,3*pi,3*pi,4*pi,4*pi), 
            y = c(0,1,1,-1,-1,1,1,-1,-1,0),lwd = 4, lty = 3, col = 6)
      axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
           labels = c("0", "π", "2π", "3π", "4π"))
      abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
      abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
    }
    legend(x = "topright", 
           legend = c("square wave", "sum of sine waves"),
           col = c(6,8), lwd = 4, lty = c(3,1), bty = "n")
    if (input$waves == "yes" & number_cols != 0){
    for (i in 1:number_cols){
      lines(x = x, y = squarewave[,i], lty = 2, col = 1)
    }
    }
    } 
 
    # code when selecting triangle wave   
    if (input$wavetype == "triangle wave") {
    number_cols = input$n1
    if (number_cols == 0){
      plot(x = x, 
           y = 4*1/(2*pi) * abs((x-2*pi/4)%%(2*pi) - 2*pi/2) - 1, 
           lwd = 4, lty = 3, col = 6, type = "l", 
           ylim = c(-1,1), xaxt = "n", ylab = "y")
      axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
           labels = c("0", "π", "2π", "3π", "4π"))
      abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
      abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
    }
    if (number_cols == 1){
        ysum = trianglewave[,1]
        plot(x = x, y = ysum, type = "l", lty = 1, 
             lwd = 4, col = 8, ylim = c(-1,1), xaxt = "n", ylab = "y")
        lines(x = x, 
              y = 4*1/(2*pi) * abs((x-2*pi/4)%%(2*pi) - 2*pi/2) - 1, 
              lwd = 4, lty = 3, col = 6)
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
    }
    if (number_cols > 1) {
        ysum = apply(trianglewave[,1:number_cols], 
                     MARGIN = 1, FUN = sum)
        plot(x = x, y = ysum, type = "l", lty = 1, 
             lwd = 4, col = 8, ylim = c(-1,1), xaxt = "n", ylab = "y")
        lines(x = x, 
              y = 4*1/(2*pi) * abs((x-2*pi/4)%%(2*pi) - 2*pi/2) - 1, 
              lwd = 4, lty = 3, col = 6)
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
      }
      legend(x = "topright", 
             legend = c("triangle wave", "sum of sine waves"),
             col = c(6,8), lwd = 4, lty = c(3,1), bty = "n")
      if(input$waves == "yes" & number_cols != 0){
      for (i in 1:number_cols){
        lines(x = x, y = trianglewave[,i], lty = 2, col = 1)
    }
    }
    } 
 
# code when selecting sawtooth wave   
    if (input$wavetype == "sawtooth wave") {
      number_cols = input$n1
      if (number_cols == 0){
        plot(x = c(0,pi,pi,pi,pi,3*pi,3*pi,3*pi,3*pi,4*pi), 
              y = c(0,1,1,-1,-1,1,1,-1,-1, 0), 
             type = "l", lwd = 4, lty = 3, col = 6,
             ylim = c(-1.1,1.1), xaxt = "n", ylab = "y", xlab = "x")
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
      }
      if (number_cols == 1){
        ysum = sawtoothwave[,1]
        plot(x = x, y = ysum, type = "l", lty = 1, 
             lwd = 4, col = 8, 
             ylim = c(-1.1,1.1), xaxt = "n", ylab = "y")
        lines(x = c(0,pi,pi,pi,pi,3*pi,3*pi,3*pi,3*pi,4*pi), 
              y = c(0,1,1,-1,-1,1,1,-1,-1, 0),lwd = 4, 
              lty = 3, col = 6)
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
      }
      if (number_cols > 1) {
        ysum = apply(sawtoothwave[,1:number_cols], 
                     MARGIN = 1, FUN = sum)
        plot(x = x, y = ysum, type = "l", lty = 1, 
             lwd = 4, col = 8, 
             ylim = c(-1.1,1.1), xaxt = "n", ylab = "y")
        lines(x = c(0,pi,pi,pi,pi,3*pi,3*pi,3*pi,3*pi,4*pi), 
              y = c(0,1,1,-1,-1,1,1,-1,-1, 0),lwd = 4, 
              lty = 3, col = 6)
        axis(side = 1, at = c(0,pi,2*pi,3*pi,4*pi), 
             labels = c("0", "π", "2π", "3π", "4π"))
        abline(v = c(0,pi,2*pi,3*pi,4*pi), col = 9, lty = 3)
        abline(h = c(-1,-0.5,0,0.5,1.0), col = 9, lty = 3)
      }
      legend(x = "topright", 
             legend = c("triangle wave", "sum of sine waves"),
             col = c(6,8), lwd = 4, lty = c(3,1), bty = "n")
      if(input$waves == "yes" & number_cols !=0){
        for (i in 1:number_cols){
          lines(x = x, y = sawtoothwave[,i], lty = 2, col = 1)
    }
    }
    }
    })
  
  output$waveequation = renderUI({
    if (input$wavetype == "square wave"){
    withMathJax("$$y(x) = \\frac{4}{\\pi} \\sum_{k = 1}^{\\infty}{\\frac{1}{2k-1}} \\sin{((2k-1) x)}$$")
    } else {
      if (input$wavetype == "triangle wave"){
        withMathJax("$$y(x) = -\\frac{8}{\\pi^2} \\sum_{k = i}^{\\infty}{\\frac{(-1)^k}{2k - 1}\\sin((2i-k)x)}$$")
      } else {
        if (input$wavetype == "sawtooth wave"){
          withMathJax("$$y(x) = -\\frac{2}{\\pi} \\sum_{k = 1}^{\\infty}{\\frac{(-1)^k}{k} \\sin(kx)}$$")
        } else {
          if (input$wavetype == "sine wave"){
            withMathJax("$$y(x) = \\sin(x) + \\sin \\left( x + \\frac{2 \\pi k}{10}\\right)$$")
          }
        }
      }
    }
    

  })
  
  
}) # close server
