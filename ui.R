library(shinydashboard)

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
