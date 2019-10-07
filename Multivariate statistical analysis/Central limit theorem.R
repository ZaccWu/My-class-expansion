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
# numerical characteristics
cat("y1 mean=",mean(y1),"\ny2 mean=",mean(y2),"\ny3 mean=",mean(y3),"\ny4 mean=",mean(y4),"\n")
# result:
# y1 mean= 0.4954792 
# y2 mean= 0.500654 
# y3 mean= 0.4999401 
# y4 mean= 0.5000066 
cat("y1 std=",sd(y1),"\ny2 std=",sd(y2),"\ny3 std=",sd(y3),"\ny4 std=",sd(y4),"\n")
# result:
# y1 std= 0.09232405 
# y2 std= 0.02883975 
# y3 std= 0.009110016 
# y4 std= 0.002926821 
# plot
bk<-seq(0.2,0.8,0.01)
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
# numerical characteristics
cat("y1 mean=",mean(y1),"\ny2 mean=",mean(y2),"\ny3 mean=",mean(y3),"\ny4 mean=",mean(y4),"\n")
# result
# y1 mean= 0.4987143 
# y2 mean= 0.5007656 
# y3 mean= 0.5109862 
# y4 mean= 0.49959 
cat("y1 std=",sd(y1),"\ny2 std=",sd(y2),"\ny3 std=",sd(y3),"\ny4 std=",sd(y4),"\n")
# result
# y1 std= 0.02874376 
# y2 std= 0.1021854 
# y3 std= 0.203062 
# y4 std= 0.04887659 
# plot
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
cat("x1 mean=",mean(x1),"\nx2 mean=",mean(x2),"\nx3 mean=",mean(x3),"\nx4 mean=",mean(x4),"\n")
# result:
# x1 mean= 0.4980591 
# x2 mean= 0.5034793 
# x3 mean= 0.5011885 
# x4 mean= 0.5002187 
cat("x1 std=",sd(x1),"\nx2 std=",sd(x2),"\nx3 std=",sd(x3),"\nx4 std=",sd(x4),"\n")
# result:
# x1 std= 0.02906032 
# x2 std= 0.02672181 
# x3 std= 0.02949015 
# x4 std= 0.02889548 
# plot
bk3<-seq(0,1,0.01)
par(mfrow=c(2,2))
hist(x1,breaks=bk3)
hist(x2,breaks=bk3)
hist(x3,breaks=bk3)
hist(x4,breaks=bk3)
