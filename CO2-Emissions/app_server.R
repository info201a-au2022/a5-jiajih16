library(shiny)
library(dplyr)
library(plotly)
library(tidyr)


#Data cleaning
#co2_data <- read.csv(file = "owid-co2-data")
co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

co2_data_world <- co2_data %>% 
    filter(country == "World")

co2_1980_2022 <- co2_data %>%
    select(country, year, co2, population) %>%
    filter(year >= 1980 & year < 2022) %>% 
    drop_na()

#Info for intro and visual

#highest annual growth
most_growth <- co2_data_world %>%
    filter(co2_growth_abs == max(co2_growth_abs, na.rm = T)) %>%
    pull(year)

#How many percentage of CO2 emissions had increased during the past 10 years?
co2_data_world$year <- as.numeric(co2_data_world$year)
co2_growth_20yrs <- co2_data_world %>%
    filter(year >= 2001 & year <= 2021) %>%
    summarise(growth = co2[20] / co2[1])
co2_growth_20yrs <- round(co2_growth_20yrs, digits = 2)
co2_growth_20yrs

#lowest annual growth
lowest_annual_growth <- co2_data_world %>%
    filter(co2_growth_abs == min(co2_growth_abs, na.rm = T)) %>%
    pull(year)

#lowest year of co2 emission
co2_low <- co2_data_world %>%
    filter(co2 == min(co2, na.rm = T)) %>%
    pull(year)
co2_low
#highest year of co2 emission
most_co2 <- co2_data_world %>%
    filter(co2 == max(co2, na.rm = T)) %>%
    pull(year)

#Plot

min_year <- round(min(co2_1980_2022$year, na.rm = T))
max_year <- round(max(co2_1980_2022$year, na.rm = T))
total_year <- c(1980, 2022)

year_range <- c(min(co2_1980_2022$year, na.rm = T),
                max(co2_1980_2022$year, na.rm = T))

choose_your_country <- unique(co2_1980_2022$country)

widget_for_year <- sliderInput(
    inputId = "select_year",
    label = "Select the range of the year",
    min = min_year,
    max = max_year,
    value = total_year,
    step = 1
    )

widget_for_country <- selectInput(
    inputId = "choose_country",
    label = "Select a Country to Analyze",
    choices = choose_your_country)

server <- function(input, output) {
    output$scatter <- renderPlotly({
        p <- co2_1980_2022 %>%
            filter(country == input$choose_country) %>%
            filter(year >= input$select_year[1],
                   year <= input$select_year[2])
        ggplot(p) +
            geom_point(mapping = aes_string(x = p$population,
                                            y = p$co2)) +
            labs(title = paste0("Annual emissions of CO2 as the POPULATION grows after 1980 in ", input$choose_country),
                 x = "population",
                 y = "CO2 emissions")
    })
}