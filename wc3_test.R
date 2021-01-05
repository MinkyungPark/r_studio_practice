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

# 1. 데이터에서 단어만 추출
data1=readLines('remake.txt')
data1
data2=sapply(data1, extractNoun, USE.NAMES = F)
data2

# 2. 단어집합 생성
data3=unlist(data2)
data3

# 3. 단어 필터링 gsub(변경전 글자,변경후글자,원본데이터)
data3=Filter(function(x){
  nchar(x)<=10
}, data3
)
data3

data3=gsub("\\d+","",data3)
data3=gsub("쌍수","쌍커풀",data3) # 줄임말
data3=gsub("쌍커풀","쌍커풀",data3) # 맞춤법 틀린 것
data3=gsub("메부리코","매부리코",data3)
data3=gsub(" ","",data3)
data3=gsub("\\.","",data3)
data3=gsub("\\'","",data3)
data3
write(unlist(data3),'remake_2.txt')
data4=read.table('remake_2.txt') # 읽을때 공백제거 read.table
data4
nrow(data4)
wc=table(data4)
wc
head(sort(wc,decreasing = T),20)

txt=readLines('성형gsub.txt') # 이걸 이용해 data3필터링
# In readLines("성형gsub.txt") : '?깊삎gsub.txt'에서 불완전한 마지막 행이 발견되었습니다
# 데이터에 커서가 있으면 안됨 엔터쳐주기
txt
cnttxt=length(txt)
cnttxt
i=1
for(i in 1:cnttxt){
  data3=gsub((txt[i]),"",data3)
}
# txt에 있는 단어 중 data3에 있는 것 공백처리
data3
data3=Filter(function(x){
  nchar(x)>=2
},data3)
# 한글자 제외외
write(unlist(data3),"remake_2.txt")
data4=read.table("remake_2.txt")
data4
wc=table(data4)
wc
head(sort(wc,decreasing = T),20)
# 제일 많이 검색하는 데이터 볼 수 있음

# 워드클라우드 생성
pal=brewer.pal(8,'Set2')
wordcloud(names(wc), freq=wc, scale = c(5,1), rot.per=0.25, min.freq = 2, random.order = F, random.color = T, colors=pal)

txt=readLines('jeju.txt')
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
# 일출->성산일출봉 너무 쪼개져서 실제 원하는 데이터가 나오지 않음

useSejongDic()
mergeUserDic(data.frame(readLines('제주도여행지.txt'),"ncn"))
# 단어장에 txt파일 안의 단어도 추가해서 처음부터 다시 해보기 // ncn은 명사


# seoul_go.txt 파일을 이용하여 서울 명소들을 워드 클라우드로 생성
# 서울명소merge.txt와 서울명소 gsub.txt를 이용하여 단어 정제
mergeUserDic(data.frame(readLines('서울명소merge.txt'),'ncn'))
txt=readLines('seoul_go.txt')
place=sapply(txt,extractNoun, USE.NAMES = F)
place
head(unlist(place),30)
cdata=unlist(place)
place=str_replace_all(cdata,'[^[:alpha:]]','')
# 한글, 영어 외에 다 삭제
place=gsub(" ","",place)
txt=readLines("서울명소gsub.txt") # 제거할 단어 목록
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
write(unlist(place),'seoul_go_revised.txt')
rev=read.table('seoul_go_revised.txt')
nrow(rev)
wc=table(rev)
wc
head(sort(wc,decreasing = T),30)
pal=brewer.pal(9,"Set3") # 8+Set2, 9+Set3
wordcloud(names(wc),freq=wc,scale=c(3,1),rot.per=0.25,min.freq=2, random.order = F, random.color = T, colors = pal)


## 영문자 다루기
install.packages('tm')
library('tm')

data1=readLines('steve.txt')
class(data1) # vector형태, char
corp1=VCorpus(VectorSource(data1))
corp1

inspect(corp1)

tdm=TermDocumentMatrix(corp1)
tdm

m=as.matrix(tdm)
m

corp2=tm_map(corp1, stripWhitespace) # 여러개의 공백을 하나로
corp2=tm_map(corp2,tolower) # 대문자는 소문자로로
corp2=tm_map(corp2,removeNumbers) # 숫자제거거
corp2=tm_map(corp2,removePunctuation) # 마침표, 콤마, 세미콜론, 콜론 제거
corp2=tm_map(corp2,PlainTextDocument) # 일반문서 변환환
sword2=c(stopwords('en'),'and','but','not')
# 불용어를 제거하고 and, but, not이라는 단어 추가
# corp2=content_transformer(tolower)
corp2=tm_map(corp2, removeWords,sword2) # 불용어ㅓ 제거
tdm2=TermDocumentMatrix(corp2)
m2=as.matrix(tdm2)
class(m2)
colnames(m2)=c(1:59)
m2
freq1=sort(rowSums(m2),decreasing = T)
freq2=sort(colSums(m2),decreasing = T)
head(freq2,20)
findFreqTerms(tdm2,2) # 2번이상 언급된 것
findAssocs(tdm2,'apple',0.5)

pal=brewer.pal(7,'Set3')
wordcloud(names(freq1),freq=freq1, scale = c(3,1), min.freq = 1, colors = pal, random.order = F, random.color = T)

