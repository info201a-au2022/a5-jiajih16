library(shiny)

ui <- navbarPage(
  #tab one introduce the thesis of the analysis
    "CO2 Analysis",
    tabPanel(
      "Introductory",
      h1(style = "text-align: center;", "CO2 Emissions Analysis based on the country of your choice"),
      h3(style = "text-align: center;","Why analyze: The topic of climate change, in particular global warming, has become 
      increasingly prevalent in recent years. One of the reasons that lead to global 
      warming is the", strong("CO2 emissions"), "that increased every year."),br(),
      
      h4("Some data on annual CO2 emissions that worth look into:"),
      
      p(style = "font-size: 18px;", "- According to", em("the CO2 data published by Our World in Data(OWID)"),
        ", from the year of", strong(c(co2_low[1])), "and", strong(c(co2_low[2])), 
        "the CO2 emissions was the lowest. On the other hand, in the year of",
        strong(c(most_co2)),"the CO2 emissions was the highest."),
      
      p(style = "font-size: 18px;", "- Over the year, the CO2 emission are still gradually increase. In", 
      strong(c(lowest_annual_growth)), "we have the lowest annual change in CO2 emissions
      when comparing to the previous year; we have the highest annual change
      in CO2 emissions in", strong(c(most_growth)), "."),
      
      p(style = "font-size: 18px;", "- During the past twenty years,", strong(c(co2_growth_20yrs)), "% of
      CO2 emissions had increased. As countries around the world keep involving, 
      the country's population progressively increases each year as well. This also leads 
      to an increase in the use of transportation which could cause a 
      rise in CO2 emissions. In this analysis, I will focus on finding whether
      there is a correlation between population growth and CO2 emission."),br(),
      
      img(src = "https://media.economist.com/sites/default/files/imagecache/original-size/20101127_WOM526.gif", height="20%", width="20%", align = "right"),
      
      p(style = "font-size: 18px;", style = "text-align: center;","In the next 
      page, I will provide graphic demonstration along with different country 
      options for my audiences to explore the relatioship between population 
      growth and CO2 emission.")
    ),

  #tab two shows the visualization of CO2 and Population
    tabPanel(
      "Plot showing relationship between CO2 and Population",
      sidebarLayout(
        sidebarPanel(
          widget_for_country,
          widget_for_year
        ),
        mainPanel(
          plotlyOutput("scatter"),
          p("With an increase in population, it is reasonable to assume that
        its CO2 emissions increase correspondingly. However, as
        we look into the data, some countries have their CO2 emissions
        remained unchanged(Bahamas) or even dropped (Denmark) as their population 
        grows. The chart is interested in showing the plots of the relationship 
        between those two elements in each country. From this visualization,
        stakeholders and audiences can learn how to reduce CO2 emissions from
        countries that have done better. Because it is our opportunity to preserve our
        one and only home -- the Earth.")
        )
      )
    )
    
)