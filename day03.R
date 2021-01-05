# plot() : 분포나 꺾은 선
# plot(y, 옵션) plot(x, y, 옵션)
v1 = c(2,2,2)
plot(v1)
plot.new() # clear
x=1:3
y=3:1
plot(x,y)
plot(x,y,xlim=c(1,10),ylim=c(1,5),xlab="x축 값",ylab="y축 값",main="PLOT CHART")
dev.new() # 새창 생성
plot(v1) # 새창에 그려진다
dev.off() # 창 사라진다

v1=c(100,130,120,160,150)
plot(v1, type = 'o') # type 그래프 선의 모양
plot(v1, type = 'o', col='red') # 선이 red
plot(v1, type = 'o', axes=F) # 외곽선이 사라진다. 새로운 모양의 그래프를 만들기위해 기본 외곽선 제거
plot(v1, type = 'o', ann=F) # 축 제목 사라짐
plot(v1, type='o',ylim=(0,200),axes=F,ann=F)
axis(1) # x축 등장
axis(2) # y축 등장
axis(1, at=1:6)
axis(1, at=1:5, lab=c('mon','tue','wed','thu','fri')) # 그래프가 계속 겹쳐진다
axis(2, ylim=c(0,200))
title(main='FRUIT', col.main='red', font.main=4)
title(xlab='DAY', col.lab='black')
title(ylab='PRICE', col.lab='blue')

# 그래프의 배치 조정 : mfrow
# par(mfrow=c(nr,nc))  partition number_row, number_col
v1
par(mfrow=c(1,3)) # 하나의 화면에 3개의 그래프를 찍겠다.
plot(v1,type='o') # 꺾은선, 점과 선을 중첩해서
plot(v1,type='s') # 계단형, 왼쪽 값을 기초로 계단식
plot(v1,type='S') # 오른쪽 값을 기초로 계단식
plot(v1,type='p') # 점모양, 기본 값
plot(v1,type='l') # 꺾은 선형
plot(v1,type='b')
plot(v1,type='c') # b에서 점을 생략
plot(v1,type='h') # 각 점에서 x축까지의 수직선
plot(v1,type='n') # 축만 그린다
pie(v1)
barplot(v1)
par(mfrow=c(1,1)) # 다시 하나에 하나로로
a=c(1,2,3)
plot(a,xlab='aaa')
# 여백 조정 mgp=c(제목위치, 지표값 위치, 지표선 위치)
par(mgp=c(0,1,0)) # 기본형태
par(mgp=c(1,1,0))
plot(a, xlab='aaa')
# oma() outside margin 그래프 전체여백 조정
# oma(bottom,left,top,right)
par(oma=c(1,3,1,1))
plot(a, xlab='aaa')
plot.new()
plot(a)

v1=c(1,2,3,4,5)
v2=c(5,4,3,2,1)
v3=c(3,4,5,6,7)
plot(v1,type='o',col='red',ylim=c(1,5)) # 이 위에다 중복해서 그릴 것임
par(new=T) # 중복해서 여기에 계속 그리겠ㄷ
plot(v2,type='l',col='blue',ylim=c(1,5))
par(new=T)
plot(v3,type='s',col='green')

plot.new()
plot(v1,type='o',col='red',ylim=c(1,5))
lines(v2,type='l',col='blue',ylim=c(1,5))
lines(v3,type='s',col='green') # limt지정 안했을 경우

plot(v1,type='o',col='red',ylim=c(1,10))
lines(v2,type='l',col='blue')
lines(v3,type='s',col='green')

# legend(x축끝위치, y축끝위치,c(범례들), cex글자크기,col,lty라인타입(0~6)) 범례 지정
legend(4,9,c('V1','V2','V3'), cex=0.9, col = c('red','blue','green'), lty=1)
barplot(x,horiz=T)
x=matrix(c(5,4,3,2),2,2, byrow=T)
x
barplot(x,names=c('1st','2nd'),col=c('green','yellow')) # 세로로
barplot(x,beside=T,names=c('1st','2nd'),col=c('green','yellow'))
barplot(x,names=c('1st','2nd'),col=c('green','yellow'),xlim=c(0,14),horiz = T) # 가로로

v1=c(100,120,140,160,180)
v2=c(120,130,150,140,170)
v3=c(140,170,120,110,160)

qty=data.frame(BANANA=v1, CHERRY=v2, ORANGE=v3)
qty # 묶음 형태로 보여주려면 dataframe => matrix
barplot(as.matrix(qty),main="FRUITS SALES", beside = T, col=rainbow(nrow(qty)),ylim=c(0,400)) # nrow(qty) qty의 갯수에 따라 레인보우 색으로
legend(14,400,c('mon','tue','wed','thu','fri'),cex=0.6,fill = rainbow(nrow(qty)))
# barchart를 그룹으로 묶어서 그릴때는 반드시 출력대상이 매트릭스
# 전치행렬 행과 열을 뒤집는다 t()
barplot(t(qty), main = 'FRUIT SALES', ylim=c(0,900), col=rainbow(length(qty)),space=0.1, cex.axis=0.8, las=1, names.arg = c('mon','tue','wed','thu','fri'), cex=0.8) # 열기준 length 행기준 nrow
# 전치행렬 된 것은 beside안됨
legend(4.5,800,c('mon','tue','wed','thu','fri'),cex=0.6,fill = rainbow(length(qty)))

# 200이상 빨강, 180이상 파랑 나머지 초록 지정
peach=c(180,200,250,198,170)
colors=c()
for(i in 1:length(peach)){
  if(peach[i]>=200){
    colors=c(colors,'red')
  } else if(peach[i]>=180){
    colors=c(colors,'yellow')
  } else {
    colors=c(colors,'green')
  }
}
barplot(peach, main='PEACH', names.arg=c('M','T','W','T','F'), col=colors)
f1=function(f2){
  pColor=NULL
  for(i in 1:length(f2)){
    if(f2[i]>=200){
      pColor=c(colors,'red')
    } else if(f2[i]>=180){
      pColor=c(colors,'yellow')
    } else {
      pColor=c(colors,'green')
    }
  }
  return(pColor)
}
barplot(peach, main='PEACH', names.arg=c('M','T','W','T','F'), col=f1(peach))
plot.new()

# 히스토그램 : 특정 데이터의 빈도수를 막대그래프로 나타낸것
h=c(182,178,167,189,182,175,166,155)
hist(h)

# pie : 전체 합이 100이 되어야 하는 경우
p1=c(10,20,30,40)
pct=p1/sum(p1)*100
lab1=c('week1','week2','week3','week4')
lab=paste(lab1,pct,"%")
pie(p1, radius=1, init.angle=90, col=rainbow(length(p1)), label=lab)
pie3D(p1, main='3D PIE', col=rainbow(length(p1)), cex=0.5, labels=lab, explode=0.05)

# 상자차트(최대, 최소, 중앙값)
v1=c(10,12,15,11,20)
v2=c(5,7,15,8,9)
v3=c(11,20,15,18,13)
boxplot(v1,v2,v3,col=c('blue','pink','yellow'),horizontal = T, names=c('BLUE','PINK','YELLOW')) # 까만줄 중간값, |--- 0~25%, ---| 75~100% 동그란 점 극단치
# 관계도 : igraph
install.packages('igraph')
library(igraph)
g1=graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6 ), directed=T)
plot(g1)
str(g1)
print_all(g1)

# 저장 첫번째 방법
name=c('홍길동 대표', '일지매 부장', '김유신 과장', '손흥민 대리', '노홍철 대리', '이순신 부장', '유관순 과장', '강감찬 부장', '신사임당 대리', '광개토 과장', '정몽주 대리')
pemp=c('홍길동 대표','홍길동 대표','일지매 부장','김유신 과장','김유신 과장','홍길동 대표','이순신 부장','유관순 과장','홍길동 대표','강감찬 부장','광개토 과장')
emp=data.frame(이름=name, 상사=pemp)
emp
g=graph.data.frame(emp,directed = T)
plot(g, layout=layout.fruchterman.reingold, vertex.size=8, edge.arrow.size=0.5, vertex.label=NA)
savePlot('network_3.png') # 저장 jpg도 가능
# 'windows'장치들로부터 복사만을 할 수 있습니다 // 이제 이 방법이 사용X
dev.new()

# 저장 두번째 방법
install.packages('devtools')
library(devtools)
install_github('christophergandrud/d3Network')
install.packages('RCurl')
library(d3Network)
library(RCurl)
name=c('홍길동 대표', '일지매 부장', '김유신 과장', '손흥민 대리', '노홍철 대리', '이순신 부장', '유관순 과장', '강감찬 부장', '신사임당 대리', '광개토 과장', '정몽주 대리')
pemp=c('홍길동 대표','홍길동 대표','일지매 부장','김유신 과장','김유신 과장','홍길동 대표','이순신 부장','유관순 과장','홍길동 대표','강감찬 부장','광개토 과장')
emp=data.frame(이름=name, 상사=pemp)
emp
d3SimpleNetwork(emp, width = 600, height=600, file='C:/r_data/d3.html')
# 익스플로에서, 오른쪽 마우스, 인코딩 한국어

setwd("c:/r_project/r_studio_practice/raw_data")
getwd()
# 군집분석 : 데이터를 여러 집단으로 나눈 후 특성 및 차이 분석
g=read.csv('군집분석.csv', header = T)
g1=data.frame(학생=g$학생, 교수=g$교수)
g1
g2=graph.data.frame(g1, directed = T)
V(g2)$name
install.packages('stringr')
library(stringr)
guboon1=V(g2)$name
guboon1
guboon=str_sub(guboon1, start=1, end=1)
guboon

colors=c()
for(i in 1:length(guboon)){
  if(guboon[i]=='S'){
    colors=c(colors, 'red')
  } else {
    colors=c(colors, 'green')
  }
}
sizes=c()
for(i in 1:length(guboon)){
  if(guboon[i]=='S'){
    sizes=c(sizes,2)
  } else {
    sizes=c(sizes,6)
  }
}

plot(g2, layout=layout.kamada.kawai, vertex.size=sizes, edge.arrow.size=0.1, vertex.color=colors, vertex.label=NA)

# 학생과 교수의 도형을 학생은 circle, 교수는 square

shapes=c()
for(i in 1:length(guboon)){
  if(guboon[i]=='S'){
    shapes=c(shapes,'circle')
  } else {
    shapes=c(shapes,'square')
  }
}

plot(g2, layout=layout.kamada.kawai, vertex.size=3, edge.arrow.size=0.1, vertex.color=colors, vertex.shapes=shapes ,vertex.label=NA)

total=read.csv('학생별전체성적_new.txt', header=T, sep=",")
total
row.names(total)=total$이름
# 행을 가져오기 위해 행 자체마다 이름으로 라벨링
total=total[,2:7]
total
#스타형
stars(total, flip.labels=F, draw.segment=F, frame.plot=T, full=T, main="학생별 과목별 성적")
# 과목별도 나오지 않고 범례도 찍히지 않는다
lab=names(total)
value=table(lab)
value
pie(value, labe=lab, radius = 0.1, cex=0.6, col=NA)
dev.new()
savePlot('star_2.jpg',type='jpg')
stars(total, flip.labels=F, draw.segment=T, frame.plot=T, full=T, main="학생별 과목별 성적", key.loc=c(0.1,6.5), key.xpd=F)
# 결론 : 별로다
# 
# radarchart()
# 1. 샘플데이터 생성
# 2. 최대값, 최소값 지정
# 3. radarchart
install.packages('fmsb')
library(fmsb)
layout=data.frame(
  분석력=c(5,1),
  창의력=c(15,3),
  판단력=c(3,0),
  리더쉽=c(5,1),
  사교성=c(5,1)
)
set.seed(123) # 임의의 데이터 생성
# runif 균등분포에서 어쩌고 통계함수 중 하나
# rnorm 정규분포에서 추출
data1=data.frame(
  분석력=runif(3,1,5),
  창의력=rnorm(3,10,2),
  판단력=c(0.5,NA,3),
  리더쉽=runif(3,1,5),
  사교성=c(5,2.5,4)
)
data2=rbind(layout,data1)
op=par(oma=c(1,0.5,3,1), mfrow=c(2,2))
radarchart(data2, axistype = 1, seg=5, plty=1, title='1st')
radarchart(data2, axistype = 2, pcol=topo.colors(3), plty=1, title='2nd')
radarchart(data2, axistype = 3, pty=32, plty=1, axislabcol = 'grey', title='3rd')
radarchart(data2, axistype = 0, plwd =1:5, pcol=1, axislabcol = 'grey', title='4th')

# 저수준 작도
# 점 : point()
# 직선 : lines(), segment(), abline()
# 격자 : grid()
# 화살표 : arrows()
# 직사각형 : rect()
# 문자 : text(), mtext(), title()
# 테두리, 축 : box(), axis()
# 범례 : legend()
# 다각형 : polygon()
par(mfrow=c(1,1))
plot(1:15)
abline(h=8)
rect(1,6,3,8)
arrows(1,1,5,5)
text(8,9,'TEXT')
title("TEST")

# ggplot2
install.packages('ggplot2')
library(ggplot2)

ko=read.table('학생별국어성적_new.txt', header=T, sep=',')
ko
ggplot(ko, aes(x=이름,y=점수))+geom_point()
# ggplot(dataframe, aes(x=x축데이터, y=y축데이터))+geom_함수()
# geom() 설정값
# - stat : 주어진 데이터에서 geom에 필요한 데이터를 생성
# - stat_bin : 
#     - count : 각 항목의 빈도 수
#     - density : 각 항목의 밀도 수
#     - ncount : count와 같지만, 값의 범위가 (0,1)로 스케일
#     - ndensity : density와 같지만 값의 범위가 (0,1)로 스케일
#     - 위 설정값을 지정하지 않으면 디폴트는 count
gg=ggplot(ko, aes(x=이름,y=점수))+geom_bar(stat='identity', fill='green', color='red')
# theme은 ggplot2에 주로 글자와 관련된 기능
gg+theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1,color='blue',size=8))

library(plyr)
kem = read.csv('학생별과목별성적_국영수_new.csv', header=T)
sort_kem = arrange(kem, 이름, 과목)
sort_kem
s_kem=ddply(sort_kem,'이름', transform, 누적합계=cumsum(점수)) 
# 이름기준,입력을 데이터프레임으로 출력을 데이터프레임으로
# 같은행 통합 summarise, 다른행 통합 transform
s_kem
ss_kem=ddply(s_kem, '이름', transform, 누적합계=cumsum(점수),label=cumsum(점수)-0.5*점수)
# 라벨을 점수50%되는 위치에 찍는다
ss_kem
ggplot(ss_kem, aes(x=이름, y=점수, fill=과목))+geom_bar(stat='identity')+geom_text(aes(y=label,label=paste(점수,'점')),color='black',size=4)
# 국->수->영 순으로 넣어주려했지만 그래프는 영->수->국으로 그려짐 범례와 맞지 않음
gg=ggplot(ss_kem, aes(x=이름, y=점수, fill=과목))+geom_bar(stat='identity', position=position_stack(reverse = T))+geom_text(aes(y=label,label=paste(점수,'점')),color='black',size=4)+guides(fill=guide_legend(reverse = T))
# 스택 문제 꼭 확인.
gg+theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1,color='blue',size=8))
gradle 깃허브
# geom_segment():클리블랜드 점 그래프
score=read.table('학생별전체성적_new.txt',header=T,sep=',')
score
class(score)
score[,c('이름','영어')]
gg=ggplot(score, aes(x=영어,y=reorder(이름, 영어)))
gg+geom_point(size=5)+theme_bw() # black&white theme
gg+geom_point(size=5)+theme_bw()+theme(panel.grid.major.x = element_blank())
# x축 값을 가진 선들 없앰
gg=gg+geom_point(size=5, color='red')+theme_bw()+theme(panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color='red', linetype='dashed'), panel.grid.minor.x = element_blank())
gg+geom_segment(aes(yend=이름),xend=0, color='blue')

install.packages('gridExtra')
library(gridExtra)
vmt=mtcars
vmt

g1=ggplot(vmt,aes(x=hp, y=mpg))
g1+geom_point(color='blue')
g1+geom_point(aes(color=factor(am), size=wt, shape=factor(am)))+scale_color_manual(values = c('red','green'))
g2=g1+geom_point(color='red')+geom_line()+labs(x='마력',y='연비')
g2

library(ggplot2)
th=read.csv('학생별과목별성적_3기_3명.csv', header=T)
th
sort_th=arrange(th, 이름, 과목)
sort_th
ggplot(sort_th,aes(x=과목, y=점수, color=이름, group=이름))+geom_line()+geom_point(size=6,shape=17)
# color=이름, group=이름  범례를 준 것
# shape 0~25

dis=read.csv('1군전염병발병현황_년도별.csv', stringsAsFactors=F)
dis
ggplot(dis, aes(x=년도별, y=장티푸스, group=1))+geom_line()
ggplot(dis, aes(x=년도별, y=장티푸스, group=1))+geom_area()
ggplot(dis, aes(x=년도별, y=장티푸스, group=1))+geom_area(fill='cyan',alpha=0.4)+geom_line()



# 워드 클라우드
# 1. 데이터에서 단어만 추출
# 2. 단어집합 생성
# 3. 단어 필터링
# 4. 단어 핸들링
# 5. xtx파일로 저장하고 table로 읽어 들이면서 공백 제거
# 6. 단어빈도수 저장
# 7. wordclound 출력
# 8. 자바로딩 안될 때
#     Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_231')
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_231')

install.packages('KoNLP')
library(KoNLP)
install.packages('wordcloud')
library(wordcloud)
install.packages('RColorBrewer')
library(dplyr)
library(plyr)
library(RColorBrewer)
useSejongDic()
setwd("c:/r_project/r_studio_practice/raw_data")
getwd
data1=readLines('BTS유엔연설_국문.txt') # 인코딩 ANSI로 저장
data1
# 1. 데이터에서 단어만 추출, 원본데이터 컬럼 사용 X
data2=sapply(data1, extractNoun, USE.NAMES = F)
data2
head(unlist(data2),30) # unlist 리스트를 벡터로
# 2. 단어집합 생성
data3=unlist(data2)
data3
# 3. 단어 필터링 gsub(변경 전 글자, 변경 후 글자, 원본 데이터)
# 4. 단어 핸들링
data3=gsub("\\d+","",data3) # 공백제거
data3=gsub('돌','',data3) # 돌 제거
data3=gsub('저','나',data3)
data3=gsub('내','나',data3)
data3=gsub('하게','',data3)
data3=gsub('해서','',data3)
data3=gsub(' ','',data3)
data3=gsub('-','',data3)
data3=gsub('것것','',data3)
data3
# 5. xtx파일로 저장하고 table로 읽어 들이면서 공백 제거
write(unlist(data3),"BTS_국.txt")
# 중간중간 들어와 있는 공백 읽어들이면서
data4=read.table('BTS_국.txt')
data4 # 사라짐
nrow(data4)
# 단어 빈도수 저장
wc=table(data4)
wc
head(sort(wc,decraesing=T),20)
# wordcloud 출력
pal=brewer.pal(9,'Set3')
wordcloud(names(wc),freq=wc,scale = c(5,1), rot.per=0.25, min.freq=1, random.order = F, random.color = T, colors=pal)
lengend(0.3,1,"BTS유엔 연설문", cex=0.8, fill=NA, border=NA, bg='white', text.col='red', text.front=2, box.col='red')