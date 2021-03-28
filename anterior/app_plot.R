library(shiny)
library(readr)
library(tidyverse)

dados3 <- read_csv("dados3.csv")

ui <- fluidPage(
  titlePanel("Jonathan_prev_Brasil"),
  headerPanel("Previsão de LP Brasil em 08 de Junho de 2020"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x", label = "data",
                  choices = c("date", "date2", "date3"),
                  selected = "date"),
      selectInput(inputId = "y", label = "previsão",
                  choices = c("q25", "med", "q975"),
                  selected = "med")
                ),
    
    mainPanel(
      plotOutput("plot2")
    )
  )
)

library(ggplot2)
library(plotly)
library(dplyr)

server <- function(input, output) {
    output$plot2 <- renderPlotly({
      
      plt <- plot_obs(
        data = dados3,
        x = input$x, 
        y = input$y, 
        varPrefix = "New", 
        legendPrefix = "", 
        yaxisTitle = "Novos Casos por Dia/New Cases per Day"
      )
      
      return(plt)
    })
      
      
      })
}

shinyApp(ui = ui, server = server)