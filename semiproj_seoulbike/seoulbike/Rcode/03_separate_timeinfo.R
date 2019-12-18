merged<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/editeddata/wholeYearData.csv", header = T)

# ---------sample 파일 불러오기
sample<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/editeddata/sample.csv", header = T)

sample<-head(merged,50)

sample<-sample[-c(1,2)]

# --------- 날짜 자료 문자형 변경 및 잘라내기 ---------------#
library(stringr)
is.factor(sample$ren_DT)
sample$ren_DT<- as.character(sample$ren_DT)
sample$ret_DT <- as.character(sample$ret_DT)

is.character(sample$ren_DT)
is.character(sample$ret_DT)

ren_month <- as.numeric(substr(sample$ren_DT,6,7))
ren_day <- as.numeric(substr(sample$ren_DT,9,10))
ren_time <- as.numeric(substr(sample$ren_DT,12,13))

ren_month <- as.numeric(substr(sample$ret_DT,6,7))
ren_day <- as.numeric(substr(sample$ret_DT,9,10))
ret_time <- as.numeric(substr(sample$ret_DT,12,13))

#----- 대여시간과 반납시간을 둘 다 확인하기가 애매하므로 대여시간만 확인하자! ------#
df <-data.frame(ren_month, ren_day, ren_time, ren_month, ren_day, count = 1) 
View(df)

View(sample)