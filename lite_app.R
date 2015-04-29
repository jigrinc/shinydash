#args <- commandArgs(trailingOnly = TRUE)
library(shiny)
library(shinydashboard)
library(magrittr)
#library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(rCharts)
library(jsonlite)
library(rHighcharts)

s_programa <- "Hola"
s_fechas <- "mundo"

ui <- dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  dashboardBody( 
    fluidRow(
        box(showOutput("barsEscuela", "highcharts")),
        box(dataTableOutput('tablEscuela'))
    )
  )
)

server <- function(input, output) {
	aux <- toupper(letters) %>% expand.grid(p1=., p2=., stringsAsFactors=F) 
	aux <- paste0('Escuela ', aux$p1, aux$p2) 
	aux <- data.frame(Preparatoria=sample(aux, 234), Encuestados=rpois(234, 6), stringsAsFactors=F)
	aux <- aux[sort(aux$Encuestados, decreasing=T, index.return=T)$ix,]
	aux$Preparatoria <- factor(aux$Preparatoria, levels = aux$Preparatoria[order(aux$Encuestados)])

	n_top <- sum(aux$Encuestados[1:30])
	n_total <- sum(aux$Encuestados)

	t <- paste0('Principales 30 escuelas (representan ', n_top, ' encuestados de ', n_total,')')

	output$barsEscuela <- renderChart({
		a <- rHighcharts:::Chart$new()
		a$chart(height=900, type = "bar")
		a$plotOptions(column = list(stacking = "normal"))
		a$title(text = paste0('Principales 30 preparatorias (representan ', n_top, ' encuestados de ', n_total,')'))
		a$subtitle(text = paste(s_programa, s_fechas))
		a$yAxis(title = list(text = "Encuestados"))
		a$xAxis(categories = head(aux, 30)$Preparatoria)
		a$data(head(aux, 30)$Encuestados)
		a$legend(enabled = FALSE)
		return(a)
	})
	output$tablEscuela <- renderDataTable({
      aux
    })
}

shinyApp(ui, server)