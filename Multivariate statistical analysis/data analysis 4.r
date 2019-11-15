library(readxl)
library(WMDB)
df=read_excel("C:/Users/Tinky/Desktop/ex5.2.xls",1)

df['x1']=lapply(df['x1'],as.numeric)
df['x2']=lapply(df['x2'],as.numeric)
g1=df[df['G']==1,]
g2=df[df['G']==2,]

X1<-cbind(g1['G'],g1['x1'],g1['x2'])
X2<-cbind(g2['G'],g2['x1'],g2['x2'])
Xtr<-rbind(X1,X2)
Xts<-rbind(c(8.1,2.0),c(7.5,3.5))
colnames(Xts)<-c('x1','x2')

tgroup<-Xtr$G
tgroup<-as.factor(tgroup)
wmd(Xtr[2:3],tgroup,TstX=Xts)

# output:
#       1 2
# blong 1 1

df=read_excel("C:/Users/Tinky/Desktop/ex5.4.xls",1)

df['x1']=lapply(df['x1'],as.numeric)
df['x2']=lapply(df['x2'],as.numeric)
df['x3']=lapply(df['x3'],as.numeric)
df['x4']=lapply(df['x4'],as.numeric)
df['x5']=lapply(df['x5'],as.numeric)
df['x6']=lapply(df['x6'],as.numeric)
df['x7']=lapply(df['x7'],as.numeric)
g1=df[df['类别']==1,]
g2=df[df['类别']==2,]

X1<-cbind(g1['类别'],g1[3:9])
X2<-cbind(g2['类别'],g2[3:9])
Xtr<-rbind(X1,X2)

tgroup<-Xtr$'类别'
tgroup<-as.factor(tgroup)
wmd(Xtr[2:8],tgroup)

# output:
#       1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
# blong 2 2 2 2 2 2 1 1 2  1  2  1  2  2  2  2  2  2  2  2  2  2  2  2  2  1  1
#       28 29 30 31 32 33 34 35
# blong  1  1  1  1  1  1  1  2
# [1] "num of wrong judgement"
# [1]  1  2  3  4  5  6  9 11 26 27 28 29 30 31 32 33 34
# [1] "samples divided to"
# [1] 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1
# [1] "samples actually belongs to"
# [1] 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2
# Levels: 1 2
# [1] "percent of right judgement"
# [1] 0.5142857
