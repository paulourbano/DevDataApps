library(shiny)
load("eventNames.Rda")

shinyUI(pageWithSidebar(
      
      headerPanel("Economic and health impact of storm events"),
      
      sidebarPanel(
            
            
            radioButtons("impactType", label = h4("Type of impact"), choices = list("Economic" = 1, "Injuries and fatalities" = 2), selected = 1),
            selectInput("stormType", label=h4("Storm type"), choices = sort(eventNames), selected= "FLOOD"),
            tags$div(class="header", checked=NA,
                     tags$h5("Documentation"),
                     tags$p("This application uses data from the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database
                            to give a sense of the impact of different types of storm events. Select the type of impact (economic or 
                            injuries/fatalities) and the type of event. The resulting graph represents the cumulative data (damage
                            in billon dollars or total fatalities and injuries) of that event.")
            )
            
      ),
      
      mainPanel(
            plotOutput('response')
      )
      
 
))