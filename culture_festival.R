setwd('C:/r_data')
df = read.csv('전국문화축제표준데이터.csv')
library(dplyr)
library(plyr)
library(ggplot2)
library(lubridate)
library(stringr)
library(devtools)
library(RColorBrewer)
library(foreign)
library(googleVis)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_231')
install.packages('KoNLP')
library(KoNLP)
library(wordcloud)

df
# 필요한 데이터만 추출
df=data.frame(df[1],df[3:4],df[12],df[14:15])
df
head(df)
cnt=length(df)
names(df)[cnt]='LAT' # 경도->LAT
names(df)[cnt-1]='LON' # 위도->LON
summary(df) # LON,LAT 각 65개씩 NA가지고 있다
# 위도나 경도, 주소를 다른 값으로 대체하기 애매, 삭제
df=df[complete.cases(df), ]
nrow(df) # 1191-65
summary(df)
cnt=4
# 주소의 빈 값 확인
head(table(df[cnt]))
tail(table(df[cnt]))
head(df[order(df[cnt]), ]) # order 빈값이 있는 것만 불러옴
length(df$소재지도로명주소[df$소재지도로명주소==""]) # 95개
df[df=='']=NA
summary(df)
df=df[complete.cases(df), ] # NA로 바꾼 후 삭제
nrow(df) # 1191-65-95
# 없음, 수시변동, - 처리
df[df=='-']=NA
df[df=='없음']=NA
df[df=='수시변동']=NA 
df=df[complete.cases(df), ]
# 모든 컬럼에 해주어야 한다ㅏ.

cnt=1
length(df$축제명[df$축제명==""])
df[df=='']=NA
nrow(df)
# 없음, 수시변동, - 처리
df[df=='-']=NA
df[df=='없음']=NA
df[df=='수시변동']=NA 
summary(df)
df=df[complete.cases(df), ]

cnt=5
length(df$LON[df$LON==""])
df[df=='']=NA
# 없음, 수시변동, - 처리
df[df=='-']=NA
df[df=='없음']=NA
df[df=='수시변동']=NA 
summary(df)
df=df[complete.cases(df), ]

# 컬럼명을 그대로 변수로 attach()
attach(df)
str(df) # Factor 값이 들어온다.(Fac, Fac, Fac, Fac, num, num)
df$축제시작일자=as.Date(df$축제시작일자)
df$축제종료일자=as.Date(df$축제종료일자)
str(df)
df$gigan=df$축제종료일자-df$축제시작일자+1 # 기간컬럼생성
head(df)
# df=cbind(df,gigan) 해도 같다.
df=cbind(df,gigan)
df=df[, !(names(df)%in%'gigan.1')]
length(df)
df=df[,-c(8)]
# gigan의 - 값, 종료일이 더 먼저 인것
subset(df,df$축제시작일자 > df$축제종료일자) # 제거
df=subset(df,df$gigan>=0)
table(gigan)
bigo=ifelse(df$gigan>365, "1년이상", ifelse(df$gigan>=50,'50일이상',ifelse(df$gigan==1,'1일','50일미만')))
df=cbind(df, bigo)
head(df)

df$mm=month(df$축제시작일자)
table(df$mm) # 4,5,9,10월 축제가 많다
hist(df$mm)
df$yy=year(df$축제시작일자)
hist(df$yy)
df$day_week=wday(df$축제시작일자, label=T)
df$day_week
table(df$day_week) # 금, 토 몰려있다
plot(df$day_week)
head(df)
dev.new()
savePlot('day_week_chart', type='png')

# 문자열 처리, 주소 처리 stringr패키지
주소=str_split_fixed(df$소재지도로명주소," ",2)
head(주소)
주소=주소[,1]
head(주소)
df[4]=주소
colnames(df)[4]='주소'
head(df)
summary(df$주소)
df$주소=as.factor(df$주소)
summary(df$주소) # = table(df$주소)

write.csv(df,'preprocessed축제.csv')

df = read.csv('preprocessed축제.csv')
plot(table(df$yy), type='b', lty=3, col=2, pch=10, lwd=3, cex=3, main='년간 축제 분석', sub='전국(2011~2020)', xlab='년도', ylab='횟수', ylim=c(0,800), xlim=c(2017,2020))

par(mfrow=c(1,3))
plot(table(df$yy), type='b', lty=3, col=2, pch=10, lwd=3, cex=3, main='년간 축제 분석', sub='전국(2011~2020)', xlab='년도', ylab='횟수', ylim=c(0,800), xlim=c(2017,2020))
plot(table(df$mm), type='b')
par(mfrow=c(1,1))
plot(df$주소, type='h')
abline(h=mean(df$gigan), col='green', lty=2)

boxplot(df$gigan)
mean(df$gigan)


