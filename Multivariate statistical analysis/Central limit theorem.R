# initialize
set.seed(1)
y1<-rep(0,1000)
y2<-rep(0,1000)
y3<-rep(0,1000)
y4<-rep(0,1000)

for (i in 1:1000){
  y1[i]<-mean(runif(10,0,1))
  y2[i]<-mean(runif(100,0,1))
  y3[i]<-mean(runif(1000,0,1))
  y4[i]<-mean(runif(10000,0,1))
}
bk<-seq(0.2,0.8,0.01)

# plot
par(mfrow=c(2,2))
hist(y1,breaks=bk)
hist(y2,breaks=bk)
hist(y3,breaks=bk)
hist(y4,breaks=bk)
