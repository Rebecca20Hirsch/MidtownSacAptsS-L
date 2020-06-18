#Making maps of trends in Midtown Sacramento Apartments
#using ggplot2, ggmaps, 
#Written by Rebecca Hirsch 6/5/2020 Spafford & Lincoln, Inc.
#Sources: https://datascienceplus.com/visualising-thefts-using-heatmaps-in-ggplot2/


MTData2 <- read.csv("~/Desktop/S&L/Coding/Midtown_Apartments/MTData2.csv")
summary(MTData2)

library(ggmap)

midtown <- get_map(c(-121.481, 38.573), zoom = 15)
ggmap(midtown)

aptLocations <- as.data.frame(table(MTData2$Longitude, MTData2$Latitude, MTData2$X..Sqft))
names(aptLocations) <- c("long", "lat", "cost", "Frequency")
aptLocations$long <- as.numeric(as.character(aptLocations$long))
aptLocations$lat <- as.numeric(as.character(aptLocations$lat))
aptLocations$cost <- as.numeric(as.character(aptLocations$cost))
aptLocations <- subset(aptLocations, Frequency > 0)

png("CostPerFootMapped.png", width = 650, height = 750)
ggmap(midtown) + 
  geom_point(data = aptLocations, aes(x = long, y = lat, color = cost, size = cost, alpha = 0.5)) +
    scale_color_continuous(low = "green", high = "red", breaks = c(1,1.5,2,2.5,3,3.5,4,4.5)) +
    scale_size(breaks = c(1,1.5,2,2.5,3,3.5,4,4.5), range = c(1,15))
dev.off()
