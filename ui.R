
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(cycloids)
library(dplyr)
library(magrittr)

shinyUI(fluidPage(

  # Application title
  titlePanel("Cycloids animation"),
  
  fluidRow(
      column(width = 12,
             "This app draws various types of epitrochoids in animated fashion. 
             An epitrochoid is a roulette traced by a point attached
             to a circle of radius r rolling around the outside of a fixed circle of radius R, where 
             the point is at a distance d (varied during animation) from the center of the exterior circle.
             The classic Spirograph toy traces out epitrochoid and hypotrochoid curves.
             Please do not chose equal values for fixed and moving radiuses, it will result in no drawing."
      )
      ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
    sliderInput("fixed",
                    "Radius of the fixed circle:",
                    min = 5,
                    max = 9,
                    value = 7),
    
    sliderInput("moving",
                "Radius of the moving circle:",
                min = 3,
                max = 7,
                value = 5),
  
    sliderInput("cycle",
                  "Number of cycles:",
                  min = 2,
                  max = 16,
                  value = 3,
                  animate = animationOptions(interval = 200))
    ), 

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

