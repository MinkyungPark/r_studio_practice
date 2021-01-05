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