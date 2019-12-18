getwd()
setwd("C:/Users/student/Desktop/seimi/data_seoulbike")
library(readxl)
library(stringr)
library(dplyr)
install.packages("tidyr")
library(tidyr)
library(ggplot2)


df = read_excel(path ="대여이력/201911_2.xlsx",
                col_names = T)
altitude = read_excel(path ="rentalPlace/대여소위치정보191209.xlsx",
                      col_names = T)

#-------import data 19 06~11-------
t1911<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201911_2.csv", header = T)
t1910<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201911_1.csv", header = T)
t1910_1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201910_1.csv", header = T)
t1910_2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201910_2.csv", header = T)
t1910_3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201910_3.csv", header = T)

t1909_1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201909_1.csv", header = T)
t1909_2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201909_2.csv", header = T)
t1909_3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201909_3.csv", header = T)


t1908_1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201908_1.csv", header = T)
t1908_2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201908_2.csv", header = T)
t1908_3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201908_3.csv", header = T)

t1907_1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201907_1.csv", header = T)
t1907_2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201907_2.csv", header = T)
t1907_3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201907_3.csv", header = T)

t1906_1<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201906_1.csv", header = T)
t1906_2<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201906_2.csv", header = T)
t1906_3<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201906_3.csv", header = T)


# -------------------------merge 1차 1906~1911
colnames(t1909_1)==colnames(t1906_3)
head(t1906_3)

colnames(t1909_1)==colnames(t1910_3)

names(t1911)  <- colnames(t1909_1)


tmerge1<- rbind(t1906_1, t1906_2, t1906_3, t1907_1, t1907_2, t1907_3, t1908_1, t1908_2, t1908_3)

nrow(tmerge1)
nrow(t1906_1)



#-------------------------------import 1812-1905----------

t1905<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201905.csv", header = F)
t1904<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201904.csv", header = F)
t1903<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201903.csv", header = T)
t1902<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201902.csv", header = T)
t1901<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201901.csv", header = T)
t1812<-read.csv(file = "C:/Users/student/Desktop/seimi/data_seoulbike/대여이력/201812.csv", header = F)


# --------------------컬럼명 동일하게 변경 ------------
names(t1905)
colnames(t1812)==colnames(t1911)

head(t1812)
mode(t1905)
str(t1905)


names(t1905) <- colnames(t1911)
names(t1904) <- colnames(t1911)
names(t1903) <- colnames(t1911)
names(t1902) <- colnames(t1911)
names(t1901) <- colnames(t1911)
names(t1812) <- colnames(t1911)

# ----------------- merge2차(2018.12 -2019.11) ----------------#

tall<- rbind(tmerge1, t1905, t1904, t1903, t1902, t1901, t1812)

merged<- tall

nrow(tmerge1)
nrow(t1905)
nrow(merged)

# ----------------------- column명 변경 -------------------------#
names(merged)
names(merged) <- c('bikeID','ren_DT','ren_pCode', 'ren_pName', 'ren_reckNum','ret_DT', 'ret_pCode','ret_pName', 'ret_reckNum', 'ritime','dist')



View(merged)


write.csv(together, file="191216.csv")
