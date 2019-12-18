library(dplyr)

시간변수 = 거리 /시간 <-  이건 회귀

timee = 입력받기

timee * 시간변수 = 거리 -- > 위도로 바꾸고 

##위도 차이에 따른 거리 변수 구해야 겟네 

##거리 / 위도 변수  = 위도 차이  <-  할 수 있으면 회귀 

출발점 위도 +- 한 범위 에서 max 값 3개 정도 씩 뽑기

df_exp <- read.csv(file ="C:/Users/student/Desktop/ssemi_proj/Jsp/실험1.csv")
df_exp
View(df_exp)
#최단 시간 구하기 
head(df_exp)

plot(x=df_exp$dis_diff, y=df_exp$distance)
res_dis=lm(df_exp$distance~df_exp$dis_diff)         
abline(res_dis)
summary(res_dis)
res_dis_anova <- anova(res_dis)
res_dis_anova
res_dis

plot(x=df_exp$Time, y=df_exp$dis_diff)
res_Time=lm(df_exp$dis_diff~df_exp$Time)         
abline(res_Time)
summary(res_Time)
res_Time

res_Time_anova <- anova(res_Time)
res_Time_anova

