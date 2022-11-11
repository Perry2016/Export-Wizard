library(shiny)

library(dplyr)

library(DT)

library(tidyverse)

library(xlsx)

 

shinyServer(function(input, output) {

   

    input_file <- reactive({

       

        file <- input$file1

        ext <- tools::file_ext(file$datapath)

       

        req(file)

        validate(need(ext == "xlsx", "Please upload a xlsx file"))

       

        raw_data = read.xlsx2(file$datapath, 1,header = input$header) %>%

            # filter(((Storage.Type == "104" & Inspection.Lot == 0.00 )| (ï..Material == "3005853") | (ï..Material == "3005855")) &

            filter(((Storage.Type == "104" & Inspection.Lot == 0.00 )| (Material == "3005853") | (Material == "3005855")|(Material == "3005306")

                    |(Material == "3111724") |(Material == "3111736") |(Material == "3111757") |(Material == "3005307") |(Material == "3005862")) &

                       

                       Stock.Category != "S" & Stock.Category != "Q" & Storage.Type != "916") %>%

            filter(!str_detect(Material.Description, 'TRIAL'))

        

        

    } )

   

    output$contents <- DT::renderDataTable(server = FALSE,{

       

        DT::datatable(

           

            input_file(),

            extensions = 'Buttons',options = list(

               

                dom = 'Bfrtip',

                buttons = c('copy', 'csv', 'excel'),pagelength = 10

            )

        )

       

    })

})
