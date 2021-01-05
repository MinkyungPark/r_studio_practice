# aggregate(): 다양한 함수를 사용하여 계산 결과를 출력
# apply()
# cor(): 상관함수
# cumsum(): 누적합
# cumprom(): 누적곱
# diff(): 차이나는 부분을 찾아냄
# length()
# max()
# min()
# mean()
# median()
# order()
# prod()
# range()
# rank()
# rev:요소 역순
# sd() 표준편차
# sort() 정렬
# sum()
# summary()
# sweep(): 일괄적으로 주어진 데이터를 빼기
# tapply(): 벡터에서ㅓ 주어진 함수 연산
# var(): 분산
v1=c(1,2,3,4,5)
v2=c('a','b','c','d','e')
max(v2) # 문자도 가능
mean(v1)
sd(v1)
var(v1)
sum(v1)

# aggregate(): 데이터프레임 상대로 주어진 함수값 구한다
# aggregate(계산될컬럼~기준될컬럼, 데이터, 함수)
install.packages('googleVis')
library(googleVis)
Fruits
aggregate(Sales~Year, Fruits, sum)
# 과일별로 판매된 수량을 sum한 결과
aggregate(Sales~Fruit, Fruits, sum)
# 과일별로 가장 많이 판매된 수량
aggregate(Sales~Fruit, Fruits, max)
# 과일별로 최대 판매량에 년도를 추가해서 과일별 연도별 최대 판매량 출력
aggregate(Sales~Fruit+Year, Fruits, max)

# apply(): matrix에서 유용하게 사용된다
# 행이나 열을 대상으로 작업을 하기 때문
# apply(대상, 행/열, 적용함수)
m1=matrix(c(1,2,3,
            4,5,6,
            7,8,9),nrow=3,byrow=T)
apply(m1,1,sum) # 행별
apply(m1,2,max) # 열별
apply(m1[,c(2,3)],2,sum) # 2열 3열?

# lapply(), sapply(): list처리
# lapply/sapply(대상, 적용함수)
l1=list(Fruits$Sales)
l2=list(Fruits$Profit)
l1
l2
lapply(c(l1,l2),max) # l1의 최대값, l2의 최대값
sapply(c(l1,l2),max) # 결과는 같고 출력 형태만 다름
lapply(Fruits[,c(4,6)],max) # Sales열(4), Profit열(6)
sapply(Fruits[,c(4,6)],max)

# tapply()/mapply(): 데이터셋의 특정요소(factor)를 처리
# tapply(출력값, 기준컬럼, 적용함수)
# mapply(함수, 벡터1, 벡터2..):벡터나 리스트를 데이터프레임처럼 처리
Fruits
tapply(Sales, Fruit, sum) # 객체 'Fruit'를 찾을 수 없습니다
# 열이름을 변수처럼 사용하려고 해서 발생하는 문제
# attach이용 - 변수를 직접 사용하기 위한 함수
attach(Fruits)
tapply(Sales, Fruit, sum)
# 연도별 합계 판매량
tapply(Sales, Year, sum)
# mapply(): 마약 데이터프레임이 아닌 벡터나 리스트형태로 데이터들이 있을 때 마치 데이터프레임처럼 연산을 해주는 함수 단 벡터의 요소개수가 동일해야한다
v1=c(1,2,3,4,5)
v2=c(10,20,30,40,50)
v3=c(100,200,300,400,500)
mapply(sum, v1, v2, v3)
# v1,v2,v3에 대한 sum을 구해라. 각 열별로 합계

# sweep():한꺼번에 차이 구하기->여러 데이터들에게 일괄적으로 기준으로 적용
# 벡터, 매트릭스, 배열, 데이터프레임으로 구성된 여러 데이터들에 동일한 기준 적용
# 벡터, 매트릭스, 배열, 데이터프레임으로 구성된 여러 데이터들에 동일한 기준을 적용시켜 차이 나는 부분을 일목요연하게 보여주는 함수
m1
a=c(1,1,1)
sweep(m1,2,a) # apply와 다르게 2가 행.
# m1에서 각요소들의 1과의 차이

# ceiling() 올림 
v1=c(-1.2, 1.9, 2.1)
ceiling(v1)
# floor() 내림
floor(v1)
# trunc() 자름
trunc(v1)

# choose()
choose(5,3) # 5C3

# factorial()

# 사용자 정의 함수
# 함수명 = function(인수 또는 입력값){
#                       계산식1
#                       계산식2
#                       return(계산 결과 반환값) }
# 함수는 중간에 엔터치면 안됨, 끝에서만
f1 = function(){
  return(10)
}
f1 # 함수 구조만 나타내는 것
f1() # 리턴 값
f2 = function(a){
  b=a^2
  return(b)
}
f2(3)

s1 = Fruits$Sales
sort(s1, decreasing=T)

# plyr() : 원본데이터를 분석하기 쉬운 형태로 나누어서 다시 새로운 형태로 만들어주는 패키지 정말 많이 사용
# plyr() 앞에 두글자 : 첫글자->입력될 데이터 유형, 두번째 글자-> 출력될 데이터유형
# d : dataframe, a : array(matrix포함), l:list 
# ddply(데이터, 기준널럼, 함수또는 결과들), alply()
setwd("c:/r_project/r_studio_practice/raw_data")
install.packages('plyr')
library(plyr)
fruits=read.csv('fruits_10.csv', header=T)
fruits

# summarise:기준 컬럼의 데이터끼리 모은 후 함수를 적용해서 출력(groub by)
ddply(fruits, 'name', summarise, sum_qty=sum(qty), sum_price=sum(price))
ddply(fruits, 'name', summarise, max_qty=max(qty), max_price=max(price))

# dplyr() 패키지 특징
# 1. filter:조건을 주어서 필터링
# 2. select:여러 컬럼이 있는 데이터셋에서 특정 컬럼만 선택해서ㅓ 사용.
# 3. arrange:데이터들을 오름, 내림차순으로 정렬
# 4. mutate:기존 변수를 활용해서 새로운 변수 생성(파생변수)
# 5. summarise:주어진 데이터를 집계해준다

# 기준이 두개 이상이면 combind함수로 묶어준다
ddply(fruits, c('year','name'), summarise, max_qty=max(qty), min_qty=min(qty))

# transform : 동일한 값의 합계가 아닌 각 행별로 연산을 수행해서 해당값을 함께 출력
ddply(fruits, 'name', transform, sum_qty=sum(qty), pct_qty=round(qty/sum(qty)*100))

library(dplyr)
data1=read.csv('2013년_프로야구선수_성적.csv')
data1
data2=filter(data1, 경기>=120 & 득점 >= 80)
data3=filter(data1, 포지션 %in% c('1루수', '3루수'))
data3

# select
select(data1, 팀, 선수명, 포지션)
select(data1, 순위:타수)
select(data1, -홈런, -타점)
# %>% 여러 문장을 조합해서 사용하는 명령어
data1 %>% select(선수명, 팀, 경기, 타수) %>% filter(타수>=400)
data1 %>% select(선수명, 팀, 경기, 타수) %>% filter(타수>=400) %>% arrange(desc(타수))
# mutate() 열추가 transform과 비슷하지만 새로 만든 열을 같은 함수에서 바로 사용가능
data1 %>% select(선수명, 팀, 경기, 타수) %>% mutate(경기X타수=경기*타수) %>% arrange(경기X타수)
data2 %>% select(선수명, 팀, 안타, 타수) %>% mutate(안타율=round(안타/타수,3)) %>% arrange(안타율)
data1 %>% group_by(팀) %>% summarise(avarage=mean(경기), na.rm=T)
data1 %>% group_by(팀) %>% summarise_each(funs(mean), 경기, 타수) # 버전오류
data1 %>% group_by(팀) %>% summarise_each(list(mean=mean), 경기, 타수) # 바뀐 것

# 결측지 NA, 누락된 값, 비어있는 값
# 함수 적용 불가, 분석 결과 왜곡
# 제거 후 분석 실시
df = data.frame(sex=c('M','F',NA,'M','F'),
                score=c(5,4,3,4,NA))
df
# 눈으로 NA확인 할 수 없을 경우 NA있는지 확인
is.na(df) # 여전히 데이터가 많으면 확인이 어려움
table(is.na(df))
# 어디에 na있는지
table(is.na(df$sex))
table(is.na(df$score))
mean(df$sex) # NA반환
df %>% filter(!is.na(score))
df %>% filter(!is.na(sex)) # 다른 열의 값까지 삭제된다.
df_filter = df %>% filter(!is.na(score))
mean(df_filter$score) # 결측 갯수 제거를 해버린다..
df_filter = df %>% filter(!is.na(score)&!is.na(sex))
df_filter # 제대로된 데이터마저 지워버린다.
df_omit = na.omit(df)
df_omit
mean(df$score, na.rm=T)

exam=read.csv('csv_exam.csv') # na없는 데이터
exam[c(3,8,15), 'math']=NA # na임의 추가
exam

exam %>% summarise(mean_math=mean(math, na.rm=T),
                   sum_math=sum(math, na.rm=T),
                   median_math=median(math, na.rm=T))
# 결측치 대체
# 다른 값으로 채워넣기
# 대체법 : 대표값(평균, 최빈값)으로 일괄대체
# 적용 : 통계분석기법, 예측값 추정
mean(exam$math, na.rm=T)
# 평균값 대체
# exam$math가 na면 55, 아니면 그대로
exam$math=ifelse(is.na(exam$math),55,exam$math)
table(is.na(exam$math)) # True없음

# 이상치 대체
# 이상치: 정상범주에서 크게 벗어난 값
# na만큼 많이 들어오는 값
# 이상치 포함시 분석결과 왜곡
# 이상치 자체를 결측 처리 해주고 제외하고 분석
# 후 빼거나 평균치나 최빈값으로 대체
df=data.frame(sex=c(1,2,1,3,2,1),
              score=c(5,4,3,4,2,6))
df
table(df$sex) # 1 3개, 2 2개, 3 1개 3이상치 1남자 2여자
table(df$score)
# 이상치 결측처리
boxplot(df$score)
df1=df$sex=ifelse(df$sex!=1&df$sex!=2, NA, df$sex)
df1=df$score=ifelse(df$score>5,NA,df$score)

# 결측치 포함 계산 ---> 좋지 않다
df %>% filter(!is.na(sex)&!is.na(score)) %>% group_by(sex) %>% summarise(mean_score=mean(score))
df %>% filter(!is.na(sex)&!is.na(score)) %>% group_by(sex) %>% summarise_each(funs(mean),score)

library(ggplot2)
boxplot(df$score) # 이상치 결측치 잡을때 근거!!

# 데이터 분석 (R에서 하는 것)
# 1. 패키지 준비
# 2. 데이터 준비
# 3. 데이터 검토
# 4. 변수명 바꾸기(히스토리 유지)
# 5. 데이터 분석
#     1단계 : 변수검토 및 전처리
#     2단계 : 변수간 관계분석  ((여기까지 했어요))
# 6. 시각화

install.packages('foreign')
install.packages('readxl') # 엑셀파일 읽는 라이브러리
# ggplot2, dplyr, foreign, readxl 준비
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

wf=read.spss(file = 'koweps_hpc10_2015_beta1.sav', use.value.labels = T, use.missings = T, to.data.frame = T)
wf1=wf
nrow(wf1)
wf1
nrow(wf1)
class(wf1)
head(wf1)
View(wf1)
dim(wf1)
str(wf1)
summary(wf1)
wf1=rename(wf1, sex=h10_g3,
           birth=h10_g4,
           marriage=h10_g10,
           religion=h10_g11,
           income=p1002_8aq1,
           code_job=h10_eco9,
           code_region=h10_reg7)
head(wf1)
class(wf1$sex)
table(wf1$sex)
table(is.na(wf1$sex))

# sex
wf1$sex=ifelse(wf1$sex==9,NA,wf1$sex)
table(is.na(wf1$sex))
wf1$sex=ifelse(wf1$sex==1,'male','female')
table(wf1$sex)
qplot(wf1$sex) # 단순 시각화

# income
class(wf1$income)
summary(wf1$income) # NA's 대답 안한 사람
hist(wf1$income) # qplot과 비슷
qplot(wf1$income)+xlim(0,1000)
wf1$income=ifelse(wf1$income %in% c(0,9999),NA,wf1$income)
table(is.na(wf1$income)) # FALSE 4620 // TRUE 12044

sex_in=wf1 %>% filter(!is.na(income)) %>% group_by(sex) %>% summarise(mean_income=mean(income))
sex_in
ggplot(data=sex_in, aes(x=sex, y=mean_income))+geom_col()

#birth
class(wf1$birth)
summary(wf1$birth)
qplot(wf1$birth) # 년도별 인구수
wf1$birth=ifelse(wf1$birth==9999,NA,wf1$birth)
table(is.na(wf1$birth))

wf1$age=2019-wf1$birth+1
summary(wf1$age)

# 나이에따른 월급 평균표
age_in=wf1 %>% filter(!is.na(income)) %>% group_by(age) %>% summarise(mean_income=mean(income))
head(age_in,20)
ggplot(data=age_in, aes(x=age,y=mean_income))+geom_line()

install.packages('reshape2')
library(reshape2) # long <-> wide
# long(행이 많은 형태), wide(열이 많은 형태)
fruits
# melt()  wide -> long
melt(fruits, id=c('year','name')) 
melt(fruits, id=c('year','name'), variable.name='var_name', value.name='val_name')
# dcast()  long -> wide
mtest=melt(fruits, id=c('year','name'), variable.name='var_name', value.name = 'val_name')
mtest
dcast(mtest, year+name~var_name) # melt한걸 원래대로 돌리는 것만
dcast
# Using val_name as value column: use value.var to override.
# Aggregation function missing: defaulting to length 사용된 컬럼 다 사용해야

# string()패키지 : 작업할 대상 데이터가 문자일 경우 처리
install.packages('stringr') # jdk설치한 이유
library(stringr)
# str_detect() 특정 문자가 있는지 찾는 것
fruits=c('apple','Apple','banana','pineapple')
str_detect(fruits,'A') # FALSE  TRUE FALSE FALSE
str_detect(fruits, '^a') # 첫글자가 a인지
str_detect(fruits, 'e$') # 마지막 문자가 e인지지
str_detect(fruits, '^[aA]') # 첫글자가 a or A
str_detect(fruits, '[aA]') # a나A가 포함되어ㅓ 있는지
str_detect(fruits, ignore.case('a')) # 이제 사용 안됨
aa='a'
str_detect(fruits, fixed(aa, ignore_case=T)) # a 던 A 던

p='a.b'
s=c('abb','a.b')
str_detect(s,p)
str_detect(s, fixed(p))
str_detect(s, coll(p))

fruits
str_count(fruits, fixed('A', ignore_case = T)) # 1 1 3 1
str_count(fruits, 'a') # 1 0 3 1

# str_c() 문자열 합치기
str_c('apple', 'pen')
str_c('FRUITS : ', fruits) # fruits의 각 요소에 FRUITS:를 붙임
str_c(fruits, ' name  is ', fruits)
str_c(fruits, collapse='-') # 전체 요소를 -를 구분자로 합침
aaa = str_c(fruits, collapse = ',')
str_dup(fruits,3)
str_length('apple')

# str_locate() 특정 문자 위치 찾기
str_locate(fruits, 'a') # 처음 찾은 a의 위치
str_replace('apple', 'p', '*') # "처음 p 만 a*ple"
str_replace_all('apple', 'p', '*')
aaa
str_split(aaa, ',')

# str_sub() 지정된 길이 만큼 문자를 자르기
str_sub(fruits, start=1, end=3) # "app" "App" "ban" "pin"
str_sub(fruits, start=1, end=-7) # ""    ""    ""    "pin"

# str_trim() 앞 뒤 공백 제거, 중간은 공백 제거 안함
str_trim('          apple    banana cherry   ')

library(sqldf)
library(googleVis)
Fruits
sqldf('select * from Fruits')
sqldf('select * from Fruits where Fruit=\'Apples\'')
sqldf('select * from Fruits where Fruit="Apples"') # 안과 밖을 ',"다르게
sqldf('select * from Fruits limit 5')

f1=function(x){
  if(x<0){
    return(-x)
  }
  else{
    return(x)
  }
}
f1(-2)

no=scan()
ifelse(no%%2==0,'짝수','홀수')

no=0
while(no<5){
  no=no+1
  if(no==3){
    break
  }
  print(no)
}
no=0
while(no<5){
  no=no+1
  if(no==3){
    next
  }
  print(no)
}

f2=function(x){
  i=0
  for(j in 1:x){
    i=i+j
    print(i)
  }
}

c1=c('apple','Apple','APPLE','banana','grape')
c2=c('apple','Apple')

# grep()
grep(c2,c1)
grep(paste(c2, collapse='|'), c1, value = T)
# value=T가 없으면 숫자(index)로 가져온다
grep('^A',c1,value=T)
c2=c('apple','Apple2','orange','cherry')
grep('[1-9]',c2,value = T)
grep('[[:upper:]]',c2,value = T)
nchar(c1) # 각 요소의 문자열의 길이
nchar('홍길동')

# 합치다 paste()
paste('a','b','c')
paste('a','b','c', sep = '')
paste('a','b','c', sep = '/')

# substr()
substr('abc123',3,5)

strsplit('2019/12/27', split='/')
grep('-','010-1111-1111') # 위치를 찾을 수 없다
regexpr('-','010-1111-1111') # 4번째 위치, 길이1,타입은chr,바이트사용
