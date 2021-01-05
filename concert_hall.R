data = read.csv('전국등록공연장현황.csv', header=T)

data2=data.frame(data[3:11])
head(data2)
names(data2)[3]='시설구분'
names(data2)[5]='등록일'
names(data2)[6]='공연장면적'
names(data2)[7]='무대면적'
names(data2)[9]='기계수'

nrow(data2) # 984
data2=data2[complete.cases(data2), ] # na 없음
nrow(data2) # 984

cnt=length(data2)
cnt # 9
head(table(data2[cnt])) # null 71, - 6
tail(table(data2[cnt]))
data2[data2=='']='0'
data2[data2=='-']='0'
summary(data2[cnt])

cnt=8
head(table(data2[cnt])) # null 0, - 0
tail(table(data2[cnt]))

cnt=5
head(table(data2[cnt]))
tail(table(data2[cnt])) # 자료없음 3, 휴관 1
data2[data2=='자료없음']= NA
data2[data2=='휴관']= NA
data2=data2[complete.cases(data2), ]
summary(data2[cnt])

cnt=1
head(table(data2[cnt]))
tail(table(data2[cnt]))
data2[data2==' ']=NA
data2=data2[complete.cases(data2), ]

head(data2)
str(data2)


data2$등록일=as.character(data2$등록일)
data2$등록일[5]
nchar(data2$등록일[5]) # 10

len=length(data$등록일)
outlier=list()
cnt=0
for(i in 1:len){
  if(nchar(data2$등록일[i])==10){
    next
  } else {
    cnt=cnt+1
    outlier=append(outlier,data2$등록일[i])
  }
}
cnt
outlier
str_trim(data2$개관일자, side='both')
data2$개관일자=gsub("-","",data2)

data2$개관일자=as.character(data2$개관일자)
data2$개관일자[5]
nchar(data2$개관일자[5]) # 10

len=length(data$개관일자)
outlier=list()
cnt=0
for(i in 1:len){
  if(nchar(data2$개관일자[i])==10){
    next
  } else {
    cnt=cnt+1
    outlier=append(outlier,data2$개관일자[i])
  }
}
cnt
outlier
str_trim(data2$등록일, side='both')
data2$등록일=gsub("-","",data2)
data2$등록일

data2$개관일자=as.Date(data2$개관일자)
data2$등록일=as.Date(data2$등록일)
data2=data2[complete.cases(data2), ]

write.csv(data2,'preprocessed전국공연장.csv')
well_data = read.csv('preprocessed전국공연장.csv', header=T)
head(well_data)
summary(well_data)
well_data=well_data[,-c(1)]

attach(well_data)

well_data$공연장면적=gsub(",","",well_data)
well_data$무대면적=gsub(",","",well_data)


str(well_data)
well_data$개관일자=as.Date(well_data$개관일자)
well_data$등록일=as.Date(well_data$등록일)
well_data$공연장면적=as.numeric(well_data$공연장면적)
well_data$무대면적=as.numeric(well_data$무대면적)
well_data$객석수=as.numeric(well_data$객석수)
well_data$기계수=as.numeric(well_data$기계수)

summary(well_data$공연장면적)
summary(well_data$무대면적)

well_data$공연대비무대면적=well_data$공연장면적/well_data$무대면적
head(table(well_data$공연대비무대면적))

head(well_data)

nrow(well_data)
nrow(data) #984 -> 896

dd=data.frame(well_data$시설명, well_data$공연대비무대면적)
summary(dd)
dd=dd[c(order(-dd$well_data.공연대비무대면적)),]
dd
top10=head(dd,10)
top10
ggplot(top10, aes(x=well_data.시설명, y=well_data.공연대비무대면적), fill=group)+geom_bar(stat='identity',position='dodge')+theme_bw()+ggtitle('공연장 대비 무대 면적 넓은 곳')+xlab('시설명')+ylab('면적')
