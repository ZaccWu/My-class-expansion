# 判别分析
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
G1<-scale(cbind(g1[1],g1[2],g1[3],g1[4]))
g2[1]=lapply(g2[1],as.numeric)
g2[2]=lapply(g2[2],as.numeric)
g2[3]=lapply(g2[3],as.numeric)
g2[4]=lapply(g2[4],as.numeric)
G2<-scale(cbind(g2[1],g2[2],g2[3],g2[4]))
g3[1]=lapply(g3[1],as.numeric)
g3[2]=lapply(g3[2],as.numeric)
g3[3]=lapply(g3[3],as.numeric)
g3[4]=lapply(g3[4],as.numeric)
G3<-scale(cbind(g3[1],g3[2],g3[3],g3[4]))
g4[1]=lapply(g4[1],as.numeric)
g4[2]=lapply(g4[2],as.numeric)
g4[3]=lapply(g4[3],as.numeric)
g4[4]=lapply(g4[4],as.numeric)
G4<-scale(cbind(g4[1],g4[2],g4[3],g4[4]))
g5[1]=lapply(g5[1],as.numeric)
g5[2]=lapply(g5[2],as.numeric)
g5[3]=lapply(g5[3],as.numeric)
g5[4]=lapply(g5[4],as.numeric)
G5<-scale(cbind(g5[1],g5[2],g5[3],g5[4]))

# 检验协方差
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

if(0){
Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 10.008, df = 10, p-value = 0.4429

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 3.6967, df = 10, p-value = 0.9603

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 3.8138, df = 10, p-value = 0.9557

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 3.4868, df = 10, p-value = 0.9678

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 12.681, df = 10, p-value = 0.245

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 19.338, df = 10, p-value = 0.03728

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 12.565, df = 10, p-value = 0.252

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 4.4234, df = 10, p-value = 0.9269

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 6.7981, df = 10, p-value = 0.7462

	Equality of Covariances Matrices Test

data:  covmat
corrected lambda* = 4.1361, df = 10, p-value = 0.9415
}

# 检验均值
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

if(0){
Hotelling's two sample T2-test

data:  G1 and G2
T.2 = 1.4954e-30, df1 = 4, df2 = 118, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G1 and G3
T.2 = 2.3759e-30, df1 = 4, df2 = 162, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G1 and G4
T.2 = 6.5419e-31, df1 = 4, df2 = 137, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G1 and G5
T.2 = 3.9914e-30, df1 = 4, df2 = 231, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G2 and G3
T.2 = 2.1581e-31, df1 = 4, df2 = 69, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G2 and G4
T.2 = 1.3849e-30, df1 = 4, df2 = 44, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G2 and G5
T.2 = 1.6245e-31, df1 = 4, df2 = 138, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G3 and G4
T.2 = 2.4241e-30, df1 = 4, df2 = 88, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G3 and G5
T.2 = 1.2008e-31, df1 = 4, df2 = 182, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)

	Hotelling's two sample T2-test

data:  G4 and G5
T.2 = 2.8837e-30, df1 = 4, df2 = 157, p-value = 1
alternative hypothesis: true location difference is not equal to c(0,0,0,0)
}

test<-cbind(as.numeric(unlist(test['T-BIL'])),as.numeric(unlist(test['Alb'])),as.numeric(unlist(test['ALP'])),as.numeric(unlist(test['ALT'])))
test<-scale(test)
test=test[(complete.cases(test)),]
cat<-unlist(train[,6])
train<-rbind(G1,G2,G3,G4,G5)
LDA = lda(train,cat,prior=c(0.2,0.2,0.2,0.2,0.2))
LDA

if(0){
Call:
lda(train, grouping = cat, prior = c(0.2, 0.2, 0.2, 0.2, 0.2))

Prior probabilities of groups:
  1   2   3   4   5 
0.2 0.2 0.2 0.2 0.2 

Group means:
            BIL           Alb           ALP           ALT
1  2.784342e-17 -9.774352e-17 -1.464125e-16 -6.977845e-17
2  2.404580e-17 -6.624186e-16  1.831723e-16  9.807331e-17
3 -2.473451e-17 -5.494884e-16 -6.832679e-17  3.066638e-17
4  2.662035e-17  4.916618e-17  5.267309e-17 -1.012342e-16
5 -5.482230e-17 -6.039548e-16 -3.963373e-18 -2.240402e-19

Coefficients of linear discriminants:
            LD1         LD2         LD3          LD4
BIL -0.13380695  0.05272572 -0.67746998  0.769578835
Alb -0.97432390 -0.09435918 -0.08109261 -0.230042286
ALP -0.05554116 -1.07275532  0.17270353  0.003162914
ALT  0.24582662  0.22779136 -0.66449588 -0.783676249

Proportion of trace:
   LD1    LD2    LD3    LD4 
0.8772 0.1137 0.0089 0.0003 
}

result=predict(LDA,test,prior = LDA$prior,method="predictive")
table(result$class)

#   1    2    3    4    5 
#   4 1037   14   33 3014 
