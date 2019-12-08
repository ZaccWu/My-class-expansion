# 聚类分析
library(readxl)
df=read_excel("C:/Users/Tinky/Desktop/ex4.2.xls",1)

data<-df[2:5]
dist<-dist(scale(data),method='euclidean') # 数据标准化
# 最短距离法
cluster1<-hclust(dist,method='single')
plot(cluster1,main="最短距离法",hang=-1)
# 最长距离法
cluster2<-hclust(dist,method='complete')
plot(cluster2,main="最长距离法",hang=-1)
# 类平均法
cluster3<-hclust(dist,method='average')
plot(cluster3,main="类平均法",hang=-1)
# 重心法
cluster4<-hclust(dist,method='centroid')
plot(cluster4,main="重心法",hang=-1)
# 离差平方和法
cluster4<-hclust(dist,method='ward')
plot(cluster4,main="离差平方和法",hang=-1)

df=read_excel("C:/Users/Tinky/Desktop/ex4.3.xls",1)

data<-df[2:6]
dist<-dist(scale(data),method='euclidean') # 数据标准化
# 最短距离法
cluster1<-hclust(dist,method='single')
plot(cluster1,main="最短距离法",hang=-1,xlab='城市')
# 最长距离法
cluster2<-hclust(dist,method='complete')
plot(cluster2,main="最长距离法",hang=-1,xlab='城市')
# 类平均法
cluster3<-hclust(dist,method='average')
plot(cluster3,main="类平均法",hang=-1,xlab='城市')
# 重心法
cluster4<-hclust(dist,method='centroid')
plot(cluster4,main="重心法",hang=-1,xlab='城市')
# 离差平方和法
cluster4<-hclust(dist,method='ward')
plot(cluster4,main="离差平方和法",hang=-1,xlab='城市')


# 主成分分析
df=read_excel("C:/Users/Tinky/Desktop/ex6.7.xls",1)
library(psych)
data<-scale(df[2:9]) # 数据标准化
# 主成分分析
df.pr=princomp(data,cor=TRUE)
summary(df.pr,loadings=TRUE) 
# result：
#Importance of components:
#                          Comp.1    Comp.2     Comp.3    Comp.4     Comp.5
#Standard deviation     2.3213318 1.1100881 0.72943408 0.5464987 0.47643779
#Proportion of Variance 0.6735727 0.1540369 0.06650926 0.0373326 0.02837412
#Cumulative Proportion  0.6735727 0.8276096 0.89411886 0.9314515 0.95982558
#                          Comp.6     Comp.7      Comp.8
#Standard deviation     0.4351019 0.28334611 0.227588880
#Proportion of Variance 0.0236642 0.01003563 0.006474587
#Cumulative Proportion  0.9834898 0.99352541 1.000000000
#
#Loadings:
#           Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
#食品        0.358  0.396  0.158  0.288  0.503         0.282  0.522
#衣着        0.257 -0.536  0.703        -0.130 -0.336         0.135
#居住        0.374        -0.412 -0.570 -0.112 -0.512  0.224  0.198
#医疗        0.275 -0.599 -0.336         0.600  0.148 -0.248       
#交通通讯    0.393  0.292  0.137  0.120  0.166 -0.233  0.114 -0.795
#教育        0.386         0.195 -0.466 -0.178  0.729  0.168       
#家庭服务    0.396  0.264               -0.211        -0.837  0.152
#耐用消费品  0.361 -0.205 -0.373  0.599 -0.503  0.114  0.251    

# 前三个主成分的累计贡献率
y=eigen(cor(data))
sum(y$values[1:3])/sum(y$values)
# result：
# 0.894118859611274

# 前三个主成分的载荷矩阵
df.pr$loadings[,1:3]
#Comp.1	Comp.2	Comp.3
#食品	0.3579647	0.395861355	0.15787036
#衣着	0.2571152	-0.535907030	0.70338874
#居住	0.3737026	0.034730236	-0.41231551
#医疗	0.2747190	-0.598743239	-0.33635918
#交通通讯	0.3925942	0.291608389	0.13714701
#教育	0.3864520	0.006782562	0.19472375
#家庭服务	0.3960333	0.263512984	0.03700491
#耐用消费品	0.3609864	-0.204639291	-0.37293920

# 碎石图
screeplot(df.pr,type='lines')
