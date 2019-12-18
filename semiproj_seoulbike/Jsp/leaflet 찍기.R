library(leaflet)
library(ggmap)
# 거리 변수  y= 0.7387+164.4133*dis_diff  


head(final_result)

central_point_coordinates <- c(lng = dep_long, lat = dep_lat)

distance_max <- max_dist

map_background <- leaflet() %>% 
  addTiles() %>% 
  setView(lng = central_point_coordinates[1], lat = central_point_coordinates[2], zoom = 13) %>%
  addCircles(lng = as.numeric(central_point_coordinates[1]), lat = as.numeric(central_point_coordinates[2]), radius = distance_max * 1000, color = "yellow")

map_background
final_result[1,2:3]
coordinates_point_two <- final_result[1,2:3]
coordinates_point_two <- as.numeric(coordinates_point_two)

distance_max_two <- 1

map <- map_background %>% 
  addCircles(lng = coordinates_point_two[1], lat = coordinates_point_two[2], radius = distance_max_two * 9, color = "red")

map

coordinates_point_3 <- c(127.0302,37.50196)

distance_max_two <- 1

map <- map%>% 
  addCircles(lng = coordinates_point_3[1], lat = coordinates_point_3[2], radius = distance_max_two * 9, color = "red")

map

