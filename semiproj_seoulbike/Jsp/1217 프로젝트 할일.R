library(readxl)
df1 <- read_xlsx(path = "C:/Users/student/Desktop/ssemi_proj/Jsp/서울시_분류별_관광명소_좌표.xlsx")
df1 <- as.data.frame(df1)
df1[,4:5]
#내일 해야 하는일 
#1. 위도 경도 차이를 나눌 시간 변수를 구해야 한다. 
#2. + - 하는 코드를 짜야댄다. 
#3. 출력을 먼 순서로 해야 대는데 1번을 고려해서 정해야한다. 
#4. 지도창이 팝업되도록... 플라스크...? 
head(df1)  
df1 <- df1[,4:5]
df_origin <- cbind(df1[1,5],df1[1,4])
a <- cbind(df1[,5],df1[,4])

head(df_origin)
head(a)

colnames(df_origin) <- c("Longitude","Latitude")
colnames(a) <- c("Longitude","Latitude")
head(a)
long_diff <- a[,"Longitude"]-df_origin[,"Longitude"]
lat_diff <- a[,"Latitude"]-df_origin[,"Latitude"]
dis_diff <- sqrt(long_diff**2+lat_diff**2)
experiment <- cbind(df1,dis_diff)
View(dis_diff)
head(experiment)
View(experiment)
write.csv(experiment,file = "실험1.csv")
