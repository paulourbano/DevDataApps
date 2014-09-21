load("leanStormData.Rda")
library(ggplot2)

generatePlot <- function(ImpactType, EventType) {
      
      g = NULL
      if (ImpactType == 1) {
           
            aggEventYear <- aggregate(leanStormData$Unified_PropDamage + leanStormData$Unified_CropDamage, 
                                      list(leanStormData$EVTYPE, leanStormData$year), sum, na.rm=T)
            
            evolution <- subset(aggEventYear, aggEventYear$Group.1 == EventType)
            evolution$cumulative <- cumsum(evolution$x)
            g = ggplot(data=evolution, aes(x=Group.2, y=cumulative/1000, group=Group.1, color=Group.1)) + 
                  geom_line() + geom_point() + ylim(0, max(evolution$cumulative)/1000) + 
                  xlab("Year") + ylab("Cumulative damage (US$ billions)") + ggtitle("Cumulative damages")
      }
      else {
            
            aggEventYear <- aggregate(leanStormData$FATALITIES + leanStormData$INJURIES, 
                                      list(leanStormData$EVTYPE, leanStormData$year), sum)
            evolution <- subset(aggEventYear, aggEventYear$Group.1 == EventType)
            evolution$cumulative <- cumsum(evolution$x)
            g = ggplot(data=evolution, aes(x=Group.2, y=cumulative, group=Group.1, color=Group.1)) + 
                  geom_line() + geom_point() + ylim(0, max(evolution$cumulative)) + 
                  xlab("Year") + ylab("Injuries and fatalities") + ggtitle("Cumulative injuries and fatalities")
      }
      g
      
      
}

shinyServer(function(input, output) {

      output$response = renderPlot(generatePlot(input$impactType, input$stormType))
      
})