library(shiny)
library(shinydashboard)
library(magrittr)
library(ggplot2)
library(stringr)
library(lubridate)
library(rCharts)
library(jsonlite)
library(rHighcharts)


server <- function(input, output, session) {
	source('~/shinydash/src_encuesta.R')
	output$queryText <- renderText({
		query <- parseQueryString(session$clientData$url_search)
		paste(names(query), query, sep = "=", collapse=", ")
	})
	output$chartEscuela <- renderChart({
		chartEscuela
	})
	output$tablEscuela <- renderDataTable({
    	tablEscuela
    })
}