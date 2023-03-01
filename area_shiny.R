
library(shiny)
library(tidyverse)
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
library(lubridate)


# area_credit data
area_credit = read.csv("area_credit.csv")
area_credit$id = as.factor(area_credit$id)

# map data
korea = shapefile("C:\\Users\\eunju\\Desktop\\graduate school\\T09.00 SCM\\Final project\\map\\TL_SCCO_CTPRVN.shp")
korea = spTransform(korea, CRS("+proj=longlat"))
korea_map = fortify(korea)
korea_map$id = as.factor(korea_map$id)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Financial Style by Area"),
   
   # Select bar - ages
   selectInput('Age', 'Select Age', unique(area_credit$ages)),
      
   # Show a plot of the generated distribution
   plotOutput("areaplot_num_opencard"),
   plotOutput("areaplot_avgscore"),
   plotOutput("areaplot_cardspend"),
   plotOutput("areaplot_loan")
   
)


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$areaplot_num_opencard <- renderPlot({
      area_credit %>% 
         filter(ages==input$Age) %>% 
         right_join(korea_map, by="id") %>% 
         ggplot(aes(x=long, y=lat, group=group)) +
         geom_polygon(aes(fill=num_usecard), colour="grey40") +
         scale_fill_gradient(low="grey",high="darkslategray") + 
         ggtitle("Use Card Count")
   })
   
   output$areaplot_avgscore <- renderPlot({
      area_credit %>% 
         filter(ages==input$Age) %>% 
         right_join(korea_map, by="id") %>% 
         ggplot(aes(x=long, y=lat, group=group)) +
         geom_polygon(aes(fill=avg_score), colour="grey40") +
         scale_fill_gradient(low="grey",high="darkslategray") +
         ggtitle("Credit Average Score")
   })
   
   output$areaplot_cardspend <- renderPlot({
      area_credit %>% 
         filter(ages==input$Age) %>% 
         right_join(korea_map, by="id") %>% 
         ggplot(aes(x=long, y=lat, group=group)) +
         geom_polygon(aes(fill=monthly_card_spend), colour="grey40") +
         scale_fill_gradient(low="grey",high="darkslategray") +
         ggtitle("Monthly Card Spend")
   })
   
   output$areaplot_loan <- renderPlot({
      area_credit %>% 
         filter(ages==input$Age) %>% 
         right_join(korea_map, by="id") %>% 
         ggplot(aes(x=long, y=lat, group=group)) +
         geom_polygon(aes(fill=monthly_loan), colour="grey40") +
         scale_fill_gradient(low="grey",high="darkslategray") +
         ggtitle("Monthly Loan")
   })

}

# Run the application 
shinyApp(ui = ui, server = server)

