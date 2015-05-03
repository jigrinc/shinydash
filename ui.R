library(shinydashboard)
library(rCharts)

ui <- dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  dashboardBody( 
  	fluidRow(verbatimTextOutput("queryText")),
    fluidRow(
        box(showOutput("chrtEscuela", "highcharts")),
        box(dataTableOutput('tablEscuela'))
    )
  )
)
