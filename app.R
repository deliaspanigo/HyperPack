## app.R ##


# Librerias
library(shiny)
library(shinydashboard)
library(psych)
library(colourpicker)






ui <- dashboardPage(
  dashboardHeader(title = "Kevin Consultora"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs", tabName = "inputs", icon = icon("house")),
      menuItem("Descriptiva General", tabName = "descriptiva", icon = icon("house")),
      menuItem("PCA", tabName = "pca", icon = icon("house")),
      menuItem("Filtrado de Datos", tabName = "filtrado", icon = icon("house")),
      menuItem("Semivariograma\n Experimental", tabName = "ase01", icon = icon("house")),
      menuItem("Krigin Ordinario", tabName = "ase02", icon = icon("house"))


    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      tabItem(tabName = "inputs",
              h2("Inputs")



      ),
      tabItem(tabName = "descriptiva",
      h2("Descriptiva General")
      ),


      # First tab content
      tabItem(tabName = "pca",
              h2("PCA")

      ),

      # Second tab content
      tabItem(tabName = "filtrado",
              h2("Filtrado de Datos")

      ),
    tabItem(tabName = "ase01",
            h3("Semivariograma Experimental")
            )

    )
  )
)

server <- function(input, output) {








}


shinyApp(ui, server)
