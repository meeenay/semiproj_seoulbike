# ------ 통합 자료 불러오기 ----- #

library(dplyr)
library(stringr)

df<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/total_year.csv", header = T)


write.csv(df, file="total_year_date.csv",row.names = F)

# ------ 요일 변수 생성 ------ #

 # step 1 year 변수 생성
df <- df %>% 
  mutate(year = ifelse(month==12, 2018 ,2019))


 # step 2 날짜 생성
  
df <- df %>% 
    mutate(date = paste(year,"-",month,"-",day))

# step 3 날짜변수의 공백 제거
df$date <-gsub(pattern = "( )",
     replacement = "",
     x = df$date)

# step 4 요일변수 생성

df$week <- weekdays(as.Date(df$date))




# -------------------------------------------------------------------
##------ 주중 출퇴근 시간 vs 일반 시간대 평균 이용 건수  비교------
  
# 자는 시간대인 1-5시간은 제외한다고 생각하고 
# 러시아워 7,8,9,18,19,20 => 6시간
# 나머지시간 => 13시간


rushcomp <- df %>% group_by(rushhour) %>% summarise(sum(count))

rushcomp <- as.data.frame(rushcomp)
names(rushcomp)[2] <- "총이용건수"

rushcomp$시간당이용건수[1] <- rushcomp$총이용건수[1]/13
rushcomp$시간당이용건수[2]<- rushcomp$총이용건수[2]/6

# 이용률 계산: 10월 출근-비출근 시간대별 시간당 평균 자전거 사용 빈도/자전거 수

rushcomp["따릉이이용률(%)"] <- rushcomp$시간당이용건수/42159153*100

        # rushhour 총이용건수 시간당이용건수 이용률(%)
        # 1    FALSE   10865357       835796.7  1.982480
        # 2     TRUE    6279509      1046584.8  2.482462


colnames(rushcomp)[4]



rushcomp[,1] <- c("비출근시간", "출근시간")


# --------------------------------주중 주말 ---------------------------------

unique(df$week)

df<- df %>% mutate(isweekend = ifelse(week == "토요일" | week == "일요일",
                                 TRUE, FALSE))
head(df)

df %>% group_by(isweekend) %>%
  summarise(sum(count))


View(countable)

# ---------------------------------평일과 주말 이용률-----------


<- df %>% group_by() %>%
  summarise(sum(count))

View(countbytime)





