getwd()
setwd("C:/Users/student/Desktop/seimi/ssemi_proj/data_seoulbike")
library(readxl)
library(stringr)
library(dplyr)
install.packages("tidyr")
library(tidyr)
library(ggplot2)

df = read_excel(path ="rentalPlace/공공자전거대여소별이용정보_201812_201905.xlsx",
                col_names = T)

altitude = read_excel(path ="rentalPlace/대여소위치정보191209.xlsx",
                      col_names = T)

df <- as.data.frame(df)
altitude <- as.data.frame(altitude)
View(df)
View(altitude)

#---- 대여소 번호 생성 -------

adf<- df %>%
  if 
  mutate(대여소ID = str_extract_all(df[,2],"[0-9]{3,4}"))

head(adf)

#------------rename ----------------

altitude %>% rename("구분" "대여소_구")


#---------------대여소 ID 생성 -----

# 
# for (i in nrow(adf)){
#   adf$대여소ID[i]<- adf$대여소ID[i][[1]][1]  
# }

str_extract_all(df[983,2],"[0-9]{3,}")

for (i in 1:nrow(adf)){
  adf[i,"대여소ID"] = adf$대여소ID[[i]][1]
}


  


# ----merge
adf$대여소ID <- unlist(adf$대여소ID)
adf$대여소ID <- as.numeric(adf$대여소ID)

together<- left_join(adf, altitude, by='대여소ID')

together <- together[-c(6,7,8)]

View(together)
class(adf$대여소ID)
class(altitude$대여소ID)


#-------------------대여소별대여건수----------------#

together<- together %>% group_by(대여소ID) %>%
  summarise(총대여건수 = sum(대여건수)) %>%
  merge(together, by= "대여소ID")

View(together)

together$temp <- 1


# --------------- 관측빈도검사 : 모든 대여소에서 6회씩임 --------------

observe_frq <- together %>% group_by(대여소ID) %>%
  summarise(sum(temp))


# ----------------거치대수 정보 이상한 값 제거 5개------------#

together <- together[!(together$거치대수 > 1000 ), ]
View(together)

# -------------------산점도 --------------

ggplot(data = together,
       aes(x=총대여건수,
           y=거치대수)) +
  geom_point()


#            어디가 많이 사용?  

frequentspot <- together[!(together$총대여건수< 20000),]
View(frequentspot)
   # 주로 하천 주변임 (대여 시작점)



# -----------------1대당 평균 이용 회수 -----------------


together <- together %>% mutate( freqByBike = round(대여건수/거치대수,1),
                     freqByBike_total = round(총대여건수/거치대수,1))

View(together)


#-------------------

library(readxl)
library(xlsx)

write.xlsx(together, file = "C:/Users/student/Desktop/seimi/ssemi_proj/data_seoulbikeediteddata/191216.xlsx")


write.csv(together, file="191216.csv")
