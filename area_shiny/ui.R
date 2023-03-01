
library(shiny)
library(lubridate)
library(tidyverse)
library(rsconnect)

area_credit = read.csv("area_credit.csv")
korea_map = read.csv("korea_map.csv")
korea_map %>% 
    is.na() %>% 
    which()

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Financial Style by Area"),
    
    # Select bar - ages
    selectInput('Age', 'Select Age', unique(area_credit$ages)),
    
    # Show a plot of the generated distribution
    plotOutput("areaplot_num_opencard"),
    plotOutput("areaplot_avgscore")
        )
    )


