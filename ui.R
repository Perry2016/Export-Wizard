library(shiny)

library(DT)

 

shinyUI(fluidPage(

    headerPanel(title = "TFDC Distribution List"),

    sidebarLayout(

        sidebarPanel(

            fileInput("file1", "Choose Excel File", accept = ".xlsx"),

            checkboxInput("header", "Header", TRUE)

        ),

        mainPanel(

            dataTableOutput("contents")

        )

    )

))
