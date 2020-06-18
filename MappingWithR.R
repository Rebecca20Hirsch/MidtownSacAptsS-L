#Making maps of trends in Midtown Sacramento Apartments
#using ggplot2, ggmaps, 
#Written by Rebecca Hirsch 6/5/2020 Spafford & Lincoln, Inc.
#Sources: https://datascienceplus.com/visualising-thefts-using-heatmaps-in-ggplot2/


MTData2 <- read.csv("~/Desktop/S&L/Coding/Midtown_Apartments/MTData2.csv")
summary(MTData2)

library(ggmap)

midtown <- get_map(c(-121.481, 38.573), zoom = 15)
ggmap(midtown)

aptLocationCost <- as.data.frame(table(MTData2$Longitude, MTData2$Latitude, MTData2$X..Sqft))
names(aptLocationCost) <- c("long", "lat", "cost", "Frequency")
aptLocationCost$long <- as.numeric(as.character(aptLocationCost$long))
aptLocationCost$lat <- as.numeric(as.character(aptLocationCost$lat))
aptLocationCost$cost <- as.numeric(as.character(aptLocationCost$cost))
aptLocationCost <- subset(aptLocationCost, Frequency > 0)

png("CostPerFootMapped.png", width = 650, height = 750)
ggmap(midtown) + 
  geom_point(data = aptLocationCost, aes(x = long, y = lat, color = cost, size = cost, alpha = 0.75)) +
    scale_color_continuous(low = "green", high = "red", breaks = c(1,1.5,2,2.5,3,3.5,4,4.5)) +
    scale_size(breaks = c(1,1.5,2,2.5,3,3.5,4,4.5), range = c(1,20)) +
    labs(color = "$/sqft", title = "Cost Per Square Foot - Mapped", subtitle = "Midtown Sacramento") +
    guides(alpha = FALSE, size = FALSE) +
    theme(legend.position = c(0.05, 0.05),
          legend.justification = c("left", "bottom"),
          legend.box.just = "left",
          legend.margin = margin(6, 6, 6, 6),
          legend.key = element_rect(fill = "white"))
dev.off()

aptLocationUnits <- as.data.frame(table(MTData2$Longitude, MTData2$Latitude, MTData2$X..of.Units))
names(aptLocationUnits) <- c("long", "lat", "units", "Frequency")
aptLocationUnits$long <- as.numeric(as.character(aptLocationUnits$long))
aptLocationUnits$lat <- as.numeric(as.character(aptLocationUnits$lat))
aptLocationUnits$units <- as.numeric(as.character(aptLocationUnits$units))
aptLocationUnits <- subset(aptLocationUnits, Frequency > 0)

png("BiggestBuildings.png", width = 650, height = 750)
ggmap(midtown) + 
  geom_point(data = aptLocationUnits, aes(x = long, y = lat, alpha = 0.75, size = units), colour = "blue") +
  scale_size_continuous(breaks = c(25,50,100,200,400,800), range = c(1,20)) +
  labs(size = "Number of Units", title = "Size of Complexes - Mapped", subtitle = "Midtown Sacramento") +
  guides(alpha = FALSE, color = FALSE) +
  theme(legend.position = c(0.05, 0.05),
        legend.justification = c("left", "bottom"),
        legend.box.just = "left",
        legend.margin = margin(6, 6, 6, 6),
        legend.key = element_rect(fill = "white"))
dev.off()

aptLocationSF <- as.data.frame(table(MTData2$Longitude, MTData2$Latitude, MTData2$SF))
names(aptLocationSF) <- c("long", "lat", "SF", "Frequency")
aptLocationSF$long <- as.numeric(as.character(aptLocationSF$long))
aptLocationSF$lat <- as.numeric(as.character(aptLocationSF$lat))
aptLocationSF$SF <- as.numeric(as.character(aptLocationSF$SF))
aptLocationSF <- subset(aptLocationSF, Frequency > 0)

png("SmallestUnits.png", width = 650, height = 750)
ggmap(midtown) + 
  geom_point(data = aptLocationSF, aes(x = long, y = lat, alpha = 0.75, size = SF), colour = "orange") +
  scale_size_continuous(breaks = c(400, 550, 700, 850, 1000, 1150, 1300), range = c(1,12)) +
  labs(size = "Square Footage of Unit", title = "Size of Units - Mapped", subtitle = "Midtown Sacramento") +
  guides(alpha = FALSE, color = FALSE)
dev.off()
