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
setwd("c:/r_project/r_studio_practice/raw_data")

useSejongDic()
mergeUserDic(data.frame(readLines('제주도여행지.txt'),"ncn"))

txt=readLines('jeju2.txt')
txt
place=sapply(txt,extractNoun, USE.NAMES = F)
place
head(unlist(place),30)
cdata=unlist(place)
place=str_replace_all(cdata,'[^[:alpha:]]','')
# 한글, 영어 외에 다 삭제
place=gsub(" ","",place)
txt=readLines("제주도여행코스gsub.txt") # 제거할 단어 목록
cnt=length(txt)
cnt
i=1
for(i in 1:cnt){
  place=gsub((txt[i]),"",place)
}
place
place=Filter(function(x){
  nchar(x)>=2
}, place)
write(unlist(place),'jeju_2.txt')
rev=read.table('jeju_2.txt')
nrow(rev)
wc=table(rev)
wc
head(sort(wc,decreasing = T),30)
pal=brewer.pal(9,"Set3") # 8+Set2, 9+Set3
wordcloud(names(wc),freq=wc,scale=c(3,1),rot.per=0.25,min.freq=2, random.order = F, random.color = T, colors = pal)

top10=head(sort(wc, decreasing = T),10)
top10

pct=round(top10/sum(top10)*100, 1) # 1번째 까지
names(top10)
lab=paste(names(top10),'\n',pct," %")
pie(top10,main='제주도 추천 여행지 top10', col=rainbow(10),radius = 1,cex=1,labels = lab)
bchart=head(sort(wc,decreasing = T))
bchart
pct
bp=barplot(bchart, main="제주도 추천 여행지 top10", col = rainbow(10),cex.names = 1, las=2, ylim=c(0,25))
text(x=bp,y=bchart*1.05, labels=paste("(",pct,'%',")"),col = 'black', cex=1)
text(x=bp,y=bchart*0.95, labels=paste(bchart,'건'),col='black',cex=1)

bchart2=rev(bchart)
bp=barplot(bchart2, main='제주도 추천 여행지 top10', col=rainbow(10), cex.name=1, las=2, ylim=c(0,25))
text(x=bp,y=bchart2*1.05, labels=paste("(",pct,'%',")"),col = 'black', cex=1)
text(x=bp,y=bchart*0.95, labels=paste(bchart,'건'),col='black',cex=1)

barplot(bchart2, main='제주도 추천 여행지 top10', col=rainbow(10), cex.name=1, xlim=c(0,25), horiz=T)
text(x=bp,x=bchart2*0.9, labels=paste("(",pct,'%',")"),col = 'black', cex=1)
text(y=bp,x=bchart*1.15, labels=paste(bchart,'건'),col='black',cex=1)
