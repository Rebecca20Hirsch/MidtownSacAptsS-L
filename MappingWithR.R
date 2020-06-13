#Making maps of trends in Midtown Sacramento Apartments
#using ggplot2, ggmaps, 
#Written by Rebecca Hirsch 6/5/2020 Spafford & Lincoln, Inc.

MTData <- read.csv("~/Desktop/S&L/Coding/Midtown_Apartments/MTData1.csv")
summary(MTData)

locations <- as_tibble(MTData)
locations_sf <- st_as_sf(locations, coords = c("Longitude", "Latitude"), crs = 4326)
mapview(locations_sf) #121.477, 38.571 zoom 15

map <- get_googlemap(center = c(-121.481, 38.573), zoom = 15,
                     style = "element:labels|visibility:off&style=feature:administrative|visibility:off")
ggmap(map) +
  geom_point(data = locations, aes(x = lon, y = lat, size = X..Sqft, color = X..Sqft), shape = 20, alpha = 0.8) +
  scale_size_continuous(range=c(1,14)) +
  scale_color_viridis(option = "A" , trans="log")

