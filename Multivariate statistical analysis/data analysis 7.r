# 因子分析
library(readxl)
df=read_excel("C:/Users/Tinky/Desktop/ex6.7.xls",1)
# Bartlett,不做旋转
factors=3
factanal(df[2:9], factors, scores="Bartlett", rotation="none")
# result:
#Call:
#factanal(x = df[2:9], factors = factors, scores = "Bartlett",     rotation = "none")
#
#Uniquenesses:  # 特殊方差
#      食品       衣着       居住       医疗   交通通讯       教育   家庭服务 
#     0.108      0.426      0.005      0.200      0.041      0.253      0.108 
#耐用消费品 
#     0.292 
#
#Loadings:  # 因子载荷矩阵
#           Factor1 Factor2 Factor3
#食品        0.710           0.621 
#衣着        0.402   0.630   0.124 
#居住        0.993                 
#医疗        0.564   0.669  -0.186 
#交通通讯    0.821           0.533 
#教育        0.787   0.225   0.277 
#家庭服务    0.836           0.438 
#耐用消费品  0.730   0.398   0.127 
#
#               Factor1 Factor2 Factor3
#SS loadings      4.497   1.057   1.014   # 公共因子对变量的总方差贡献
#Proportion Var   0.562   0.132   0.127   # 方差贡献率
#Cumulative Var   0.562   0.694   0.821   # 累积方差贡献率
#
#Test of the hypothesis that 3 factors are sufficient.
#The chi square statistic is 9.15 on 7 degrees of freedom.
#The p-value is 0.242 


# 体检数据
library(psych)
library(readxl)
df=read_excel("C:/Users/Tinky/Desktop/体检数据.xls",1)
df[,c(3:18)]=(lapply(df[,c(3:18)],as.numeric))
# 去除缺失值
df=df[(complete.cases(df)),]
df=df[(complete.cases(df)),]
data<-scale(df[3:18]) # 数据标准化
# 主成分分析
df.pr=princomp(data,cor=TRUE)
summary(df.pr,loadings=TRUE) 
# 计算样本的主成分得分
sc=predict(df.pr)
# 聚类分析
dist<-dist(scale(sc),method='euclidean') # 标准化+计算距离
cluster<-hclust(dist,method='average')  # 类平均法
print(cluster)  # 查看聚类信息

# output：
# Call:
# hclust(d = dist, method = "average")
# Cluster method   : average 
# Distance         : euclidean 
# Number of objects: 4059 

plot(cluster,main="类平均法",cex=0.05)  # 绘图

# kmeans
library(factoextra)
k.max = 20
data = sc         
wss = sapply(1:k.max,function(k){kmeans(data,k,nstart=10)$tot.withinss})
plot(1:k.max, wss,  type='b',pch=19, frame=FALSE,xlab = 'Number of cluster K',ylab = "Total within-clusters sum of squares")
abline(v=12,lty=2)

# 因子分析
factors=5
factanal(data[,1:16], factors, scores="Bartlett", rotation="none")
# Error in solve.default(cv): 系统计算上是奇异的: 倒条件数=3.55736e-17
# Traceback:
# 1. factanal(data[, 1:16], factors, scores = "Bartlett", rotation = "none")
# 2. diag(solve(cv))
# 3. solve(cv)
# 4. solve.default(cv)
A=cor(data)
qr(A)$rank
# ooutput:15
A=cor(data[,14:16])
qr(A)$rank
# output:2
factors=5
factanal(data[,1:15], factors, scores="Bartlett", rotation="none")

# Call:
# factanal(x = data[, 1:15], factors = factors, scores = "Bartlett",     rotation = "none")

# Uniquenesses:
#      Age      Sbp      Dbp Sphygmus   Weight   Height       TC       TG 
#    0.770    0.079    0.325    0.936    0.005    0.503    0.922    0.855 
#      ALT      AST    T-BIL       IB      ALP       TP      Alb 
#    0.172    0.030    0.005    0.040    0.884    0.567    0.119 

# Loadings:
#          Factor1 Factor2 Factor3 Factor4 Factor5
# Age               0.102           0.261  -0.374 
# Sbp       0.309   0.270   0.154   0.840  -0.151 
# Dbp       0.353   0.309   0.142   0.655         
# Sphygmus                          0.195   0.104 
# Weight    0.660   0.745                         
# Height    0.517   0.429  -0.130           0.153 
# TC        0.109   0.175   0.125   0.137         
# TG        0.154   0.295   0.130           0.112 
# ALT       0.325   0.334   0.775                 
# AST       0.258   0.228   0.920                 
# T-BIL     0.830  -0.553                         
# IB        0.825  -0.528                         
# ALP       0.140   0.170   0.212   0.149         
# TP                        0.160   0.206   0.603 
# Alb       0.231                   0.221   0.878 

#                Factor1 Factor2 Factor3 Factor4 Factor5
# SS loadings      2.583   1.819   1.636   1.397   1.354
# Proportion Var   0.172   0.121   0.109   0.093   0.090
# Cumulative Var   0.172   0.293   0.403   0.496   0.586

# Test of the hypothesis that 5 factors are sufficient.
# The chi square statistic is 1717.63 on 40 degrees of freedom.
# The p-value is 0 
