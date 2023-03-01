
library(shiny)
library(lubridate)
library(tidyverse)
library(rsconnect)

area_credit = read.csv("area_credit.csv")
korea_map = read.csv("korea_map.csv")
korea_map %>% 
    is.na() %>% 
    which()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$areaplot_num_opencard <- renderPlot({
        area = area_credit %>% 
            filter(ages==input$Age)
        map_area = area %>% left_join(korea_map, by="id")
        
        #plot
        plot_opencard = map_area %>% 
            ggplot(aes(x=long, y=lat, group=group)) +
            geom_polygon(aes(fill=num_opencard), colour="grey40") +
            scale_fill_gradient(low="grey",high="darkslategray") 
        plot_opencard + ggtitle("Open card Count")
    })
    output$areaplot_avgscore <- renderPlot({
        area = area_credit %>% 
            filter(ages==input$Age)
        map_area = korea_map %>% left_join(area, by="id")
        
        #plot
        map_area %>% 
            ggplot(aes(x=long, y=lat, group=group)) +
            geom_polygon(aes(fill=avg_score), colour="grey40") +
            scale_fill_gradient(low="grey",high="darkslategray") +
            ggtitle("Average Score")

    })

})


