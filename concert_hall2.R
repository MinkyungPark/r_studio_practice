# .- 등으로 통일되지 않은 날짜 포맷 맞추기
conv0date = function(strings,ptrn) {
  if (str_detect(strings,ptrn)) {
    temp = str_split(strings,ptrn)
    print(length(temp))
    if (nchar(temp[[1]][2]) < 2) {
      # str_split 으로 패턴을 이용해 리스트로 만들수 있으며, 반환되는 리스트의 접근은 [[1]][1] 이 첫번째 인덱스임.
      temp[[1]][2] = paste("0", temp[[1]][2], sep="")
    }
    if (length(temp) > 2) {
      if (nchar(temp[[1]][3]) < 2) {
        temp[[1]][3] = paste("0", temp[[1]][3], sep="")
      }
      temp1 = paste(temp[[1]][2], temp[[1]][3], sep="")  
    } else {
      # 일자가 없고 년월 포맷일 경우 일 부분에 01이 들어가도록 함.
      temp1 = paste(temp[[1]][2], "01", sep="")  
    }
    temp2 = paste(temp[[1]][1], temp1, sep="")
    return(temp2)
  } else {
    return(strings)
  }
}

i=1
nrow(df)
df$개관일자 = as.character(df$개관일자)
for (i in 1:nrow(df)) {
  df$개관일자[i] = conv0date(df$개관일자[i],"[:punct:]")
}
df$개관일자 = str_replace_all(df$개관일자, "\n","")
df$개관일자 = str_replace_all(df$개관일자, " ","")
str(df)
table(df$개관일자)