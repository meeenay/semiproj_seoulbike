library(stringr)

t1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201911_1.csv", header = F)
t2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201911_2.csv", header = T)
t3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201911_3.csv", header = T)

head(t1)
head(t2)
head(t3)

names(t3) <- c('bikeID','ren_DT','ren_pCode', 'ren_pName', 'ren_reckNum','ret_DT', 'ret_pCode','ret_pName', 'ret_reckNum', 'ritime','dist')
names(t2) <- c('bikeID','ren_DT','ren_pCode', 'ren_pName', 'ren_reckNum','ret_DT', 'ret_pCode','ret_pName', 'ret_reckNum', 'ritime','dist')
names(t1) <- c('bikeID','ren_DT','ren_pCode', 'ren_pName', 'ren_reckNum','ret_DT', 'ret_pCode','ret_pName', 'ret_reckNum', 'ritime','dist')


# --------- 날짜 자료 문자형 변경 및 잘라내기 ---------------#

is.factor(sample$ren_DT)

t1$ren_DT<- as.character(t1$ren_DT)
t2$ren_DT<- as.character(t2$ren_DT)
t3$ren_DT<- as.character(t3$ren_DT)


is.character(t1$ren_DT)
is.character(t2$ren_DT)


# ----- 10_1,2,3 대여시간 날짜 자료 만들기 ----#
#---------대여시간과 반납시간 둘 다 보기 애매해서 대여시간기준으로 환산 ------#

month <- as.numeric(substr(t1$ren_DT,6,7))
day <- as.numeric(substr(t1$ren_DT,9,10))
time <- substr(t1$ren_DT,12,13)
time<- as.numeric(unlist(str_extract_all(time,"[0-9]{1,}")))
pcode<-t1$ren_pCode
df1 <-data.frame(month, day, time, pcode, count = 1) 


month <- as.numeric(substr(t2$ren_DT,6,7))
day <- as.numeric(substr(t2$ren_DT,9,10))
time <- substr(t2$ren_DT,12,13)
time<- as.numeric(unlist(str_extract_all(time,"[0-9]{1,}")))
pcode<-t2$ren_pCode
df2 <-data.frame(month, day, time, pcode, count = 1) 

month <- as.numeric(substr(t3$ren_DT,6,7))
day <- as.numeric(substr(t3$ren_DT,9,10))
time <- substr(t3$ren_DT,12,13)
time<- as.numeric(unlist(str_extract_all(time,"[0-9]{1,}")))
pcode<-t3$ren_pCode
df3 <-data.frame(month, day, time, pcode, count = 1) 

View(df3)

# ---------- rbind => 월 자료 통합 -----_#
library(ggplot2)

temp<- rbind(df1, df2, df3)

temp <- df1

# ----------- 출퇴근 시간 생성 ----------------#
library(dplyr)
temp <- temp %>% 
  mutate(rushhour = ifelse((time>=7 & time<=9) | (time>=18 & time <=20), TRUE ,FALSE))

unique(temp$time)

temp


# -----------월 데이터 저장 ------------------#

write.csv(temp, file="11.csv",row.names = F)



# ------------ 출퇴근 시간의 평균 이용 건수 ---------------- #

# 자는 시간대인 1-5시간은 제외한다고 생각하고 
# 러시아워 7,8,9,18,19,20 => 6시간
# 나머지시간 => 13시간


countable <-temp %>% group_by(rushhour) %>%
  summarise(sum(count))

countable <- as.data.frame(countable)

countable$usageperhour<-countable$`sum(count)`[1]/13
countable$usageperhour[2]<-countable$`sum(count)`[2]/6

  # 이용률 계산: 10월 출근-비출근 시간대별 시간당 평균 자전거 사용 빈도/자전거 수

countable["usagerate(%)"] <- countable$usageperhour/42159153*100
        #       # ---> 
        # rushhour sum(count) usageperhour usageperhou   usagerate
        # 1    other    1514717     116516.7    116516.7 0.002763734
        # 2 rushhour     826306     137717.7    137717.7 0.003266614


countable


View(countable)

# --------------------------------------


countbytime <-temp %>% group_by(time) %>%
  summarise(sum(count))

View(countbytime)

