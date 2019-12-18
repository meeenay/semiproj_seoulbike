library(dplyr)
library(ggmap)
time_input <- 30 # 예시
# 위도로 변환하기 
long_lati_diff = (0.001365 * time_input) + 0.002378
max_dist = 164.4133*long_lati_diff/sqrt(2) + 0.7387

max_dist
long_lati_diff/sqrt(2)
map_diff = long_lati_diff/sqrt(2)
df_exp  <- as.data.frame(df_exp)
#강남구 구룡사 앞 교차로 
dep_lat <- 37.472 #위도
dep_long <- 127.051338


result <- df_exp %>% filter(Latitude>=dep_lat-map_diff &Latitude<=dep_lat+map_diff)%>% filter(Longitude>=dep_long-map_diff & Longitude<=dep_long+map_diff)%>% select(상호명,Longitude,Latitude)

time_diff <-  (sqrt((result[,"Longitude"]-dep_long)**2+(result[,"Latitude"]-dep_lat)**2)-0.002378)/0.001365

final_result <- cbind(result,time_diff)

final_result <- final_result %>% arrange(desc(time_diff))
final_result
#--------------------------------------------------------------------

