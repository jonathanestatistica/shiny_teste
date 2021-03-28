library(shiny)
library(readr)
library(tidyverse)
library(plotly)

#leitura dos dados
dados <- readRDS("Brazil_n.rds")
dados <- dados[["lt_predict"]]
dados_1 <- read_csv("Data_Brazil_17062020.csv")
## Last date
last_date_n <- max(dados_1$date)
##reaname LP e CP
d <-dados[,c(1,5)]

d1=d[1:14,2]
d1=as.data.frame(d1)
colnames(d1) <-c("medcp")
d0=d[,1]
d2=rep(0,length(d$date)-14)
d2=as.data.frame(d2)
colnames(d2) <-c("medcp")
d12=rbind(d1,d2)
dados=cbind(dados,d12)
colnames(dados)[c(3,6)] <- c("Prev LP", "Prev CP")


ui <- fluidPage(
  titlePanel("Jonathan_prev_Brasil"),
  headerPanel("Previsões de CP e LP Brasil em 18 de Junho de 2020, incluindo sazonalidade de domingo"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "y", label = "Teste de previsões de CP e LP",
                  choices = c("Prev LP", "Prev CP"),
                  selected = "Prev LP")
                ),
    
    mainPanel(
      img(src = "BRAZIL_21_06.png", height = 72, width = 72),
      plotlyOutput("plot2")
    )
  )
)



server <- function(input, output) {
    output$plot2 <- renderPlotly({

      
fig2 <- dados %>% plot_ly() %>% add_trace(x = ~date, y = ~get(input$y), type= "scatter", name = "Prediction", mode = "lines+markers",
          marker=list(color='rgb(204,255,255)', line = list(color = 'rgb(0, 0, 0)', width = 1), dash='solid', width=2.5),
          line = list(
            color = 'rgb(230, 115, 0)',
            width = 1.5),                                 
           error_y = list(
                                            type = "data",
                                            thickness=1,
                                            width=3,
                                            color='rgb(102,102,0)',
                                            symmetric = FALSE,
                                            array = c(dados$q975 - dados$'Prev LP'),
                                            arrayminus = c(dados$'Prev LP' - dados$q25))
                                          ) 
                                                
fig2 <- fig2 %>% 
        add_trace(x = ~dados_1$date, y = ~dados_1$NewConfirmed, type = 'scatter', mode = 'lines+markers', hoverinfo = "x+y", name = "Observed Data", mode = "lines+markers", 
                  hoverinfo = "x+y",
                  marker = list(
                    color = 'rgb(100, 140, 240)',
                    line = list(color = 'rgb(0, 0, 0)', width = 1)),
                  line = list(
                    color = 'rgb(100, 140, 240)',
                    width = 1.5)
                  
                  
        )
      
      
      fig2 <- fig2 %>% layout(title = "Previsão de Novos Casos/ Pediction of New Cases", 
                              xaxis = list(title = "date"), 
                              yaxis = list(title = "Novos Casos por Dia/New Cases per Day"),
                              shapes = list(type = "line", opacity = 0.7, line = list(color = "black", width = 1),
                                            y0 = 0, y1 = 1, yref = "paper",
                                            x0 = last_date_n, x1 = last_date_n),
                              dragmode = FALSE, # to avoid zoom when the graph starts
                              legend=list(x=0.03,y=0.97, # legend position
                                          bgcolor='rgba(240,240,240,0.5)')
      )
      
                  
      fig2
      })
}

shinyApp(ui = ui, server = server)
