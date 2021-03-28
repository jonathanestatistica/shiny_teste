library(shiny)
library(ggplot2)

dados2 <- read.csv("dados2.csv")

ui <- fluidPage(
  titlePanel("Jonathan"),
  headerPanel("teste x versus y"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x", label = "eixo x",
                  choices = c("x1", "x2", "x3"),
                  selected = "x1"),
      selectInput(inputId = "y", label = "eixo y",
                  choices = c("y1", "y2", "y3"),
                  selected = "y1"),
      
      sliderInput(inputId = "alpha", 
                  label = "Beta:", 
                  min = 0, max = 1, 
                  value = 0.5)
                ),
    
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

server <- function(input, output) {
  output$scatterplot <- renderPlot({
    ggplot(data = dados2, aes_string(x = input$x, y = input$y)) + geom_point(alpha = input$alpha)
  })
}

shinyApp(ui = ui, server = server)