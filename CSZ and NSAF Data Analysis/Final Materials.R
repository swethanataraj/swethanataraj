

## loading the required libraries:
library(maps)
library(leaflet)
library(dplyr)
library(shiny)


masterNSAF <-read.csv("C:\\Users\\sweth\\Documents\\HON 499 Final\\masterNSAF.csv", header = TRUE)
# subsetting: 
masterNSAF <- subset(masterNSAF, select = c("time", "latitude", "longitude", "depth", "mag", "magType", "nst", "gap", "dmin", "rms", "net", "place", "type",  "magNst"))


ui <- fluidPage(
  titlePanel("NSAF Earthquakes from 2011-2021"),
  leafletOutput("mymap"),
  
)

#mymap is the id of the ui that we can use in the server
server <- function(input, output, session) {
  output$mymap <- renderLeaflet({
    masterNSAF %>%
      leaflet() %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
      addLayersControl(baseGroups = c("Toner Lite", "World Imagery")) %>%
      addMarkers(label = masterNSAF$mag)
      
    
    
  })
}

shinyApp(ui, server)

#we can first compare number of eq events
#and then average magnitude between the two. assumptions for poisson include indepedents homogeneity. 
#questions we can ask here: what is the probability that the next earthquake with a seismic intensity over 5.0 will hit cascadia in the next year?
  
  ## 
  
  
#  Before the 18th: r markdown docu set up with normal leaflet visuals, two sample t test on each data sets with process written out because our data follows a distribution (power law) risks in testing
