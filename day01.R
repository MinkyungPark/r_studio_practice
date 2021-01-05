setwd("c:/r_project/r_studio_practice/raw_data")
getwd()
txt1 = read.csv("factor_test.txt")
txt1
txt1 = factor(txt1$blood) # txt1을 가공, 
txt1 # 5 line의 txt1을 txt2로 바꾸면 원본복귀가능
summary(txt1)
txt2 = read.csv("factor_test.txt")
sex2 = factor(txt2$sex)
sex2
summary(sex2)
# 날짜 시간
Sys.Date()
Sys.time()
date()
class(as.Date('2019-12-26'))
class('2019-12-26')
as.Date('26-12-2018', format='%d-%m-%y')
as.Date('2019년 12월 26일', format='%Y년 %m월 %d일')
as.Date(-100, origin='2019-12-26')
as.Date('2019-12-26')+100
install.packages('lubridate')
library(lubridate)
date=now()
date
year(date)
month(date)
month(date, label = T)
wday(date, label = T)
date = date + days(10)
date
seq(as.Date('2020-01-01'),as.Date('2020-12-31'), 1)
seq(as.Date('2020-01-01'),as.Date('2020-12-31'), 'month')
seq(as.Date('2020-01-01'),as.Date('2020-12-31'), 'year')
a1=1:10
al
a2 = seq(as.Date('2020-01-01'),as.Date('2020-12-31'), 'month')
a1=10; b1=20
a1+b1
objects()
rm(list=ls())
### 데이터 처리 객체
## 벡터
c(1,2,3,4,5)
c('a','b','c')
c(1,2,3,'a')
v1 = c(11,22,33,44,55)
v1[-3] # 11 22 44 55
v1[1:4] # 11 22 33 44
v1[-2:-4] # 11 55
v1[2]=6 # 11  6 33 44 55
v1=c(v1,7) # 11  6 33 44 55  7
v1[9]=9 # 11  6 33 44 55  7 NA NA  9
v1 = append(v1,10,after=3) # 11  6 33 10 44 55  7 NA NA  9
append(v1, c(100,110), after=4) # (X)
v1 = append(v1, c(100,110), after=4)
v1
# 11   6  33 10  44 100 110  55   7  NA  NA   9
c(1,2,3)+c(2,3,4) # 3 5 7
v1=c(1,2,3)
v2=c('2','3','4')
v1+v2 # X
union(v1,v2) # O
setdiff(v1,v2)
fruits = c(10,20,30)
names(fruits) = c('apple','banana','peach')
fruits
v3=seq(1,5)
v4=seq(-1,-10)
v5=rep(1:3, each=3)
v3 # 1 2 3 4 5
v4 # -1  -2  -3  -4  -5  -6  -7  -8  -9 -10
v5 # 1 1 1 2 2 2 3 3 3
length(v5)
NROW(v1)
v6=c(1,3,5,7,9)
4 %in% v6 # 안에 있는지
## 행렬
m1 = matrix(c(1,2,3,4), nrow=2) # 세로입력
#        [,1] [,2]
# [1,]    1    3
# [2,]    2    4
m1 = matrix(c(1,2,3,4), nrow=2, byrow=T) # 가로 입력
#        [,1] [,2]
# [1,]    1    2
# [2,]    3    4
m1[ ,1]
m1[1,1]
m2=matrix(c(1,2,3,
            4,5,6,
            7,8,9), nrow=3, byrow=T)
m2[,2]
# 행추가 rbind()
# 열추가 cbind()
m3=rbind(m2,c(11,22,33))
m3=cbind(m3,c(111,222,333,444))
m3=cbind(m3,c(1111,2222,3333,44444))
colnames(m3)=c('1st','2nd','3rd','4th','5th')
m3
arr1=array(c(1:12),dim=c(2,2,3)) # 2*2행렬 3개 생성
arr1
arr1[1,1,2]
## list
l1=list(name='홍길동',
        addr='서울',
        tel='010-',
        pay=500)
l1$pay
l1[1:3]
l1$birth='2000-01-01'
l1$name=c('김유신','이순신') # 기존데이터 위에 덮어씌워져서 홍길동 사라짐
l1$name[length(l1$name)+1]='홍길동'
l1
l1$birth=NULL # 컬럼삭제
l1
l1$name[length(l1$name)-1]=NA # 특정위치값만 삭제(이순신만 삭제)
l1
l1$name[length(l1$name)-1]=NULL # 재배치가 이루어져야하므로 안됨
## 데이터 프레임
no=c(1,2,3,4)
name=c('apple','banana','peach','grape')
price=c(500,200,100,50)
qty=c(6,2,4,7)
sales=data.frame(No=no, Name=name, PRICE=price, QTY=qty)
sales
# 행렬로 데이터 프레임 생성
sales2=matrix(c(1,'apple',500,5,
                2,'peach',200,2,
                3,'banana',100,4,
                4,'grape',50,7),nrow=4,byrow=T) # 모든 데이터 문자열
df1=data.frame(sales2) # 데이터프레임으로 변형
names(df1)=c('NO','NAME','PRICE','QTY')
class(sales)
class(df1) # 둘다 dataframe임 하지만 데이터 형 다름
str(sales) # structure확인 , num,Factor,num,num
str(df1) # Factor,Factor,Factor,Factor
# Factor는 연산이 안됨... factor가 들어오면 모두 factor로변함
df1=data.frame(sales2, stringsAsFactors = FALSE)
str(df1) # 모두 캐릭터로 들어옴
# 원하는 조건만 사용하기 subset
subset(df1, QTY > 5)
df1$QTY=as.numeric(df1$QTY) # numeric으로 바꿔주는 것이 정석
#############안바꿔 주면#####################
df2=data.frame(sales2)
names(df2)=c('NO','NAME','PRICE','QTY')
str(df2) # Factor 컬럼들
subset(df2, QTY > 5) # (factors)에 대하여 의미있는 ‘>’가 아닙니다.
df1$QTY=as.numeric(df1$QTY)

no=c(1,2,3)
name=c('apple','banana','peach')
price=c(100,200,300)
df1=data.frame(No=no, NAME=name, PRICE=price)
df1
no=c(10,20,30)
name=c('train','car','ship')
price=c(1000,2000,3000)
df2=data.frame(No=no, Name=name, Qty=price)
df2
df3=cbind(df1,df2)
df3
df4=rbind(df1,df2) # names do not match previous names

df1=data.frame(name=c('apple','banana','peach'),price=c(300,200,100))
df2=data.frame(name=c('apple','cherry','berry'),qty=c(10,20,30))
merge(df1,df2,all=T)
new=data.frame(name='mango', price=400)
df2=rbind(df1,new)
df1
df2
df3=rbind(df2,data.frame(name='berry',price=500))
df3
df4=cbind(df3, data.frame(qty=c(10,20,30,40,50))) # 갯수가 모자라면 reculsive
df4

# 데이터 프레임에서 특정 컬럼만 골라서 새로운 형태 만들기
no = c(1,2,3,4,5)
name=c('홍길동','이순신','유관순','김유신','윤동주')
addr=c('서울','경기','부산','광주','제주')
tel=c(1111,2222,3333,4444,5555)
hobby=c('놀기','먹기','자기','놀먹','놀자')
member=data.frame(NO=no, NAME=name, ADDR=addr, TEL=tel, HOBBY=hobby)
member
mem1=subset(member, select = c(NO,NAME,ADDR))
mem1
mem2=subset(member, select=TEL)
mem2
colnames(mem2)=c('번호','이름','주소','취미')
install.packages('dplyr')
library(dplyr)
df1=data.frame(var1=c(1,2,3), var2=c(2,3,2))
df2=df1 # history생성
df2=rename(df1,v2=var2)
df2 # 파생변수수
df3=data.frame(var1=c(4,3,8), var2=c(2,6,1))
df3
df3$sum=df3$var1+df3$var2
df3$mean=df3$sum/2
df3

install.packages('ggplot2')
library('ggplot2')
mpg
mpg1=mpg
mpg1=rename(mpg1, city=cty)
mpg1=rename(mpg1, highway=hwy)
mpg1
head(mpg1,7) # 7개 가져오기기
tail(mpg1)

list.files(all.files = T) #숨겨진 파일까지
list.files('C:\r_data')
sc1=scan('scan_1.txt') # 텍스트파일을 읽어 배열에 저장
sc1
sc2=scan('scan_2.txt', what = '')
sc2
sc4=scan()
sc5=scan(what='')
# readline() 한줄 씩 읽어들이기
in1=readline()
in2=readline('R U OK?')
in2
# readLines() 파일을 읽어 배열에 저장
in3=readLines('scan_4.txt')
in3
fruits=read.table('fruits_2.txt')
fruits
fruits=read.table('fruits_2.txt', header = T) # 첫줄 없음
fruits
fruits=read.table('fruits_2.txt', header = T, skip=7)
fruits=read.table('fruits_2.txt', nrow=2)
fruits
fruits4=read.csv('fruits_4.csv', header=F)
fruits4
label=c('NO','NAME','PRICE','QTY')
fruits4=read.csv('fruits_4.csv', header=F, col.names = label)
fruits4

install.packages('googleVis')
install.packages('sqldf')
library(googleVis)
library(sqldf) # 데이터를 csv로 저장
Fruits
write.csv(Fruits, 'Fruits_sql.csv', quote=F, row.names=F)
f2=read.csv.sql('Fruits_sql.csv', sql='select * from file where Year=2008') # DB와 연동이 가능하다
f2

txt1=readLines('write_test.txt')
txt1
write(txt1, 'write_test2.txt')
txt1=read.table('table_test.txt', header=T)
txt1
write.table(txt1, 'table_test2.txt')
