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
