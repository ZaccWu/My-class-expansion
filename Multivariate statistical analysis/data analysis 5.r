library(MASS)
library(ICSNP)
library(readxl)
test=read_excel("C:/Users/Tinky/Desktop/体检数据.xls",1)
train=read_excel("C:/Users/Tinky/Desktop/肝胆病患者检查数据.xls",1)
g1=train[1:108,2:5]
g2=train[109:123,2:5]
g3=train[124:182,2:5]
g4=train[183:216,2:5]
g5=train[217:344,2:5]
g1[1]=lapply(g1[1],as.numeric)
g1[2]=lapply(g1[2],as.numeric)
g1[3]=lapply(g1[3],as.numeric)
g1[4]=lapply(g1[4],as.numeric)
G1<-cbind(g1[1],g1[2],g1[3],g1[4])
g2[1]=lapply(g2[1],as.numeric)
g2[2]=lapply(g2[2],as.numeric)
g2[3]=lapply(g2[3],as.numeric)
g2[4]=lapply(g2[4],as.numeric)
G2<-cbind(g2[1],g2[2],g2[3],g2[4])
g3[1]=lapply(g3[1],as.numeric)
g3[2]=lapply(g3[2],as.numeric)
g3[3]=lapply(g3[3],as.numeric)
g3[4]=lapply(g3[4],as.numeric)
G3<-cbind(g3[1],g3[2],g3[3],g3[4])
g4[1]=lapply(g4[1],as.numeric)
g4[2]=lapply(g4[2],as.numeric)
g4[3]=lapply(g4[3],as.numeric)
g4[4]=lapply(g4[4],as.numeric)
G4<-cbind(g4[1],g4[2],g4[3],g4[4])
g5[1]=lapply(g5[1],as.numeric)
g5[2]=lapply(g5[2],as.numeric)
g5[3]=lapply(g5[3],as.numeric)
g5[4]=lapply(g5[4],as.numeric)
G5<-cbind(g5[1],g5[2],g5[3],g5[4])

# 均值显著性差异判别
MuTest=function(data1, data2)   
{
  data1=as.matrix(data1)
  data2=as.matrix(data2)
  n1=nrow(data1)
  n2=nrow(data2)
  p=ncol(data1)

  X.bar=apply(data1, 2, mean) 
  A1=(n1-1)*var(data1)
  Y.bar=apply(data2, 2, mean)
  A2=(n2-1)*var(data2) 
  A=(A1+A2)/(n1+n2-2)

  T2=(n1*n2/(n1+n2))*t(X.bar-Y.bar)%*%solve(A)%*%(X.bar-Y.bar)
  F=(n1+n2-2-p+1)/((n1+n2-2)*p)*T2
  print(X.bar)
  p.two=1-pf(F, p, (n1+n2-p-1))
  return(list(p.value=p.two))
}
HotellingsT2(G1,G2)
HotellingsT2(G1,G3)
HotellingsT2(G1,G4)
HotellingsT2(G1,G5)
HotellingsT2(G2,G3)
HotellingsT2(G2,G4)
HotellingsT2(G2,G5)
HotellingsT2(G3,G4)
HotellingsT2(G3,G5)
HotellingsT2(G4,G5)

# 协方差矩阵的检验
varcomp <- function(covmat,n) {
   if (is.list(covmat)) {
    if (length(covmat) < 2)
        stop("covmat must be a list with at least 2 elements")
    ps <- as.vector(sapply(covmat,dim))
    if (sum(ps[1] == ps) != length(ps))
        stop("all covariance matrices must have the same dimension")
    p <- ps[1]
        q <- length(covmat)
        if (length(n) == 1)
        Ng <- rep(n,q)
    else if (length(n) == q)
        Ng <- n
    else
        stop("n must be equal length(covmat) or 1")
 
    DNAME <- deparse(substitute(covmat))
   }
 
   else
    stop("covmat must be a list")
 
   ng <- Ng - 1
   Ag <- lapply(1:length(covmat),function(i,mat,n) { n[i] * mat[[i]] },mat=covmat,n=ng)
   A <- matrix(colSums(matrix(unlist(Ag),ncol=p^2,byrow=T)),ncol=p)
   detAg <- sapply(Ag,det)
   detA <- det(A)
   V1 <- prod(detAg^(ng/2))/(detA^(sum(ng)/2))
   kg <- ng/sum(ng)
   l1 <- prod((1/kg)^kg)^(p*sum(ng)/2) * V1
   rho <- 1 - (sum(1/ng) - 1/sum(ng))*(2*p^2+3*p-1)/(6*(p+1)*(q-1))
   w2 <- p*(p+1) * ((p-1)*(p+2) * (sum(1/ng^2) - 1/(sum(ng)^2)) - 6*(q-1)*(1-rho)^2) / (48*rho^2)
   f <- 0.5 * (q-1)*p*(p+1)
   STATISTIC <- -2*rho*log(l1)
   PVAL <- 1 - (pchisq(STATISTIC,f) + w2*(pchisq(STATISTIC,f+4) - pchisq(STATISTIC,f)))
   names(STATISTIC) <- "corrected lambda*"
   names(f) <- "df"
   RVAL <- structure(list(statistic = STATISTIC, parameter = f,p.value = PVAL, data.name = DNAME, method = "Equality of Covariances Matrices Test"),class="htest")
   return(RVAL)
}

s1<-cov(G1)
s2<-cov(G2)
s3<-cov(G3)
s4<-cov(G4)
s5<-cov(G5)

covmat<-list(s1,s2)
varcomp(covmat,n=16)
covmat<-list(s1,s3)
varcomp(covmat,n=16)
covmat<-list(s1,s4)
varcomp(covmat,n=16)
covmat<-list(s1,s5)
varcomp(covmat,n=16)
covmat<-list(s2,s3)
varcomp(covmat,n=16)
covmat<-list(s2,s4)
varcomp(covmat,n=16)
covmat<-list(s2,s5)
varcomp(covmat,n=16)
covmat<-list(s3,s4)
varcomp(covmat,n=16)
covmat<-list(s3,s5)
varcomp(covmat,n=16)
covmat<-list(s4,s5)
varcomp(covmat,n=16)

test<-cbind(as.numeric(unlist(test['T-BIL'])),as.numeric(unlist(test['Alb'])),as.numeric(unlist(test['ALP'])),as.numeric(unlist(test['ALT'])))
test<-scale(test)
test=test[(complete.cases(test)),]
cat<-unlist(train[,6])
train<-scale(rbind(G1,G2,G3,G4,G5))
LDA = lda(train,cat,prior=c(0.2,0.2,0.2,0.2,0.2))
LDA

result=predict(LDA,train,prior = LDA$prior,method="predictive")
table(result$class)

result=predict(LDA,test,prior = LDA$prior,method="predictive")
table(result$class)
