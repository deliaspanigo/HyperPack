## app.R ##

# install.packages("remotes")
# install.packages("shiny")
# install.packages("shinydashboard")
# remotes::install_github("daattali/colourpicker")
# remotes::install_github("deliaspanigo/HyperPack")
#install.packages("shiny")

#

# Librerias
library(shiny)
library(shinydashboard)
# library(psych)
library(colourpicker)
library(HyperPack)

original_data <- Hyp_Base01




ui <- dashboardPage(
  dashboardHeader(title = "Hyper Clases"),
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
              h2("Inputs"),
              fluidRow(
                column(4,
                  numericInput(inputId = "input_CHL",
                           label = "CHL (mg/m3)",value = 2.00, step = 0.01),
                  numericInput(inputId = "input_TSS",
                           label = "TSS (g/m3)",value = 1.00, step = 0.01),
                  numericInput(inputId = "input_CDOM",
                           label = "CDOM (m-1)",value = 0.10, step = 0.01),
              br(),
              colourInput("col", "Select colour", "purple")
              ),
              column(8, plotOutput("plot01"))
              ),
              br(),
              br(),
              br(),
              h2("Full Data Set"),
              tableOutput("data")



      ),
      tabItem(tabName = "descriptiva",
      h2("Descriptiva General"),

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




final_data <- reactive({
  od <- original_data
  valor01 <- input$input_CHL
  valor02 <- input$input_TSS
  valor03 <- input$input_CDOM

  # $J5*($F5+$G5*O$1+$I5*O$2)
  part01 <- od[,6] + od[,7]*valor01 + od[,9]*valor02

  # ($B5+$C5*O$1+$D5*O$3+$E5*O$2)
  part02 <- od[,2] + od[,3]*valor01 + od[,4]*valor03 + od[,5]*valor02

  # ($F5+$G5*O$1+$I5*O$2)
  part03 <- od[,6] + od[,7]*valor01 + od[,9]*valor02

  #new var
  new_var <- od[,10]*part01/(part02 + part03)
  # new_var <- =$J5*($F5+$G5*O$1+$I5*O$2)/(($B5+$C5*O$1+$D5*O$3+$E5*O$2)+($F5+$G5*O$1+$I5*O$2))

  final_data <- cbind.data.frame(od, new_var)
  final_data
})

    output$data <- renderTable(digits = 5,{

      final_data()
    })


    output$plot01 <- renderPlot({
      plot(final_data()[,1], final_data()[,ncol(final_data())],
           cex = 1, lwd = 6, col = input$col)
    })
}


shinyApp(ui, server)
