
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(cycloids)
library(dplyr)
library(magrittr)

shinyServer(function(input, output) {
    
  output$distPlot <- renderPlot({

      n <- input$cycle; A <- input$fixed; B <- input$moving
      #    n <- 20; A <- 7; B <- 5
      
      lambdax <- seq(0.85, by = -0.05, length.out = n)
      z <- zykloid(A, B, lambdax[1])
      z.data <- bind_cols(z, data.frame(cycle = rep(1, nrow(z))))
      
      for (i in c(2:n)) { 
          z <- zykloid(A, B, lambdax[i])
          z.data %<>% bind_rows(bind_cols(z, data.frame(cycle = rep(i, nrow(z)))))
      }

      
    op <- par(mar = c(0,0,0,0), bg = "black") # no plot margins
    ccol <- rep(c("steelblue", "steelblue", "red", "red"), ceiling(n/4))
    par(ask=F)
    plot.new(); xmax <- max(z.data$x)*1.1; ymax <- max(z.data$y)*1.1 
    plot.window(asp = 1, xlim = c(-xmax, xmax), ylim = c(-ymax, ymax))
    for (i in c(1:n)) lines(y ~ x, data = filter(z.data, cycle == i), type = "l", col = ccol[i])    
  })
})
