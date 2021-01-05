### propose.txt
# 프로포즈 선물로 받고 싶은 건수가 50 이상이면 'red', 30이상이면 'yellow', 10이상이면 'blue', 그 외에는 pink

txt=readLines('propose.txt')
txt
propose=sapply(txt,extractNoun, USE.NAMES = F)
propose
head(unlist(propose),30)
cdata=unlist(propose)
propose=str_replace_all(cdata,'[^[:alpha:]]','')
# 한글, 영어 외에 다 삭제
propose=gsub("\\d+","",propose)
propose=gsub("돈","돈다발",propose) # 줄임말
propose=gsub("링","반지",propose) # 맞춤법 틀린 것
propose=gsub("꽃","꽃다발",propose)
propose=gsub("꽃다발다발","꽃다발",propose)
propose=gsub("말","마음",propose)
propose=gsub("\\.","",propose)
propose=gsub("\\'","",propose)
propose=gsub(" ","",propose)
txt=readLines("proposegsub.txt") # 제거할 단어 목록
cnt=length(txt)
cnt
i=1
for(i in 1:cnt){
  propose=gsub((txt[i]),"",propose)
}
propose
propose=Filter(function(x){
  nchar(x)>=2
}, propose) # 꽃, 돈, 곰 있음...?
write(unlist(propose),'propose_2.txt')
rev=read.table('propose_2.txt')
nrow(rev)

### 워드클라우드 #####################
wc=table(rev)
wc
head(sort(wc,decreasing = T),30)
pal=brewer.pal(9,"Set3") # 8+Set2, 9+Set3
wordcloud(names(wc),freq=wc,scale=c(2,1),rot.per=0.25,min.freq=2, random.order = F, random.color = T, colors = pal)
top11=head(sort(wc, decreasing = T),11)
top11


#### 그래프 ##########################
plot.new()
par(mfrow=c(2,2))

colors=c()
for(i in 1:length(top11)){
  if(top11[i]>=50){
    colors=c(colors,'red')
  } else if(top11[i]>=30){
    colors=c(colors,'yellow')
  } else if(top11[i]>=10){
    colors=c(colors,'blue')
  } else {
    colors=c(colors,'pink')
  }
}

pct=round(top11/sum(top11)*100, 1) # 1번째 까지
names(top11)
lab=paste(names(top11),'\n',pct," %")

### 1. 평면 파이
pie(top11,main='프로포즈 선물 top11', col=colors,radius = 0.5,cex=0.6,labels = lab)

install.packages('plotrix')
library(plotrix)

### 2. 3d 파이
pie3D(top11,main='프로포즈 선물 top11', col=colors,radius = 1 ,labelcex=0.6,labels = lab)

### 3. 바차트
bp=barplot(top11, main="프로포즈 선물 top11", col = colors, cex.names = 1, las=1, ylim=c(0,60))
text(x=bp,y=75, labels=paste("(",pct,'%',")"),col = 'black', cex=1)
text(x=bp,y=70, labels=paste(bchart,'건'),col='black',cex=1)


barplot(top11, main='프로포즈 선물 top11', col=colors, cex.name=1, xlim=c(0,80), horiz=T)
text(y=bp,x=75, labels=paste("(",pct,'%',")"),col = 'black', cex=1)
text(y=bp,x=70, labels=paste(bchart,'건'),col='black',cex=1)
