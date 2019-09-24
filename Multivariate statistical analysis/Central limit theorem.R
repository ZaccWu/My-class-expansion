# initialize
set.seed(1)
y1<-rep(0,1000)
y2<-rep(0,1000)
y3<-rep(0,1000)
y4<-rep(0,1000)

# CLT with different sample size
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

# CLT with different distributions
for (i in 1:1000){
  y1[i]<-mean(runif(100,0,1))
  y2[i]<-mean(rnorm(100,0.5,1))
  y3[i]<-mean(rnorm(100,0.5,2))
  y4[i]<-mean(rbinom(100,1,0.5))
}
bk1<-seq(0,1,0.01)
bk2<-seq(-1,2,0.01)

par(mfrow=c(2,2))
hist(y1,breaks=bk1)
hist(y2,breaks=bk1)
hist(y3,breaks=bk2)
hist(y4,breaks=bk1)

# CLT with sampling times
set.seed(1)
x1<-rep(0,10)
x2<-rep(0,100)
x3<-rep(0,1000)
x4<-rep(0,10000)
for (i in 1:10){
  x1[i]<-mean(runif(100,0,1))
}
for (i in 1:100){
  x2[i]<-mean(runif(100,0,1))
}
for (i in 1:1000){
  x3[i]<-mean(runif(100,0,1))
}
for (i in 1:10000){
  x4[i]<-mean(runif(100,0,1))
}
bk3<-seq(0,1,0.01)

par(mfrow=c(2,2))
hist(x1,breaks=bk3)
hist(x2,breaks=bk3)
hist(x3,breaks=bk3)
hist(x4,breaks=bk3)
