library(openxlsx)
df=read.xlsx("C:/Users/Tinky/Desktop/sample.xlsx",2)

# 数据预处理
df<-df[-1,] # 删去多余的行
value<-cbind(df[6:7],df[10],df[4:5],df[11:12])
value<-na.omit(value) # 除去空值
value=apply(value,2,as.numeric)
bmi<-(value[,2]/100)^2/value[,1]
bmi=as.matrix(bmi)
value=as.matrix(value[,3:7])
value<-cbind(bmi,value) # 构造向量X

# 相关性分析
res<-cor(value)
library(corrplot)
corrplot(res)

# 计算数字特征
colMeans(value) # 样本均值
# result:
#                     FPG         sbp         dbp          TG       HDL-C 
#   0.0426731   5.5614286 118.7539683  76.1666667   1.9332937   1.6090476 
var(value)*(nrow(value)-1)  # 样本离差阵
# result:
#                           FPG          sbp          dbp           TG      HDL-C
#        0.01137996  -0.4369921    -8.390243    -6.688799   -0.8764585  0.1592408
# FPG   -0.43699206 234.4292857   803.818571   755.210000  141.7541143  -16.4986571
# sbp   -8.39024266 803.8185714 71198.746032 39101.333333 1233.9642063  -101.0290476
# dbp   -6.68879949 755.2100000 39101.333333 33065.000000 1359.9716667  -122.3600000
# TG    -0.87645851 141.7541143  1233.964206  1359.971667  568.3279663  -42.7988095
# HDL-C  0.15924080 -16.4986571  -101.029048  -122.360000  -42.7988095  28.5599714 
var(value)  # 样本协方差阵
# result:
#                         FPG          sbp         dbp           TG         HDL-C
#        4.533849e-05 -0.001741004  -0.03342726  -0.0266486 -0.003491867  0.0006344255
# FPG   -1.741004e-03  0.933981218   3.20246443   3.0088048  0.564757427  -0.0657317018
# sbp   -3.342726e-02  3.202464428 283.66034276 155.7822045  4.916192057  -0.4025061658
# dbp   -2.664860e-02  3.008804781 155.78220452 131.7330677  5.418213811  -0.4874900398
# TG    -3.491867e-03  0.564757427   4.91619206   5.4182138  2.264254846  -0.1705131854
# HDL-C  6.344255e-04 -0.065731702  -0.40250617  -0.4874900 -0.170513185  0.1137847467
cor(value)  # 样本相关阵
# result：
#                    FPG         sbp        dbp         TG       HDL-C
#        1.0000000 -0.2675452 -0.29475960 -0.3448209 -0.3446366  0.27932195
# FPG   -0.2675452  1.0000000  0.19675054  0.2712549  0.3883562 -0.20163401
# sbp   -0.2947596  0.1967505  1.00000000  0.8058814  0.1939844 -0.07084859
# dbp   -0.3448209  0.2712549  0.80588140  1.0000000  0.3137228 -0.12591467
# TG    -0.3446366  0.3883562  0.19398443  0.3137228  1.0000000 -0.33593348
# HDL-C  0.2793219 -0.2016340 -0.07084859 -0.1259147 -0.3359335  1.00000000

# 是否服从正态分布
ks.test(value[,2], "pnorm", mean = mean(value[,2]), sd =  sqrt(value[,2]))
# result:
# One-sample Kolmogorov-Smirnov test
# data:  value[, 2]
# D = 0.33462, p-value < 2.2e-16
# alternative hypothesis: two-sided
ks.test(value[,3], "pnorm", mean = mean(value[,3]), sd =  sqrt(value[,3]))
# result:
# One-sample Kolmogorov-Smirnov test
# data:  value[, 3]
# D = 0.14491, p-value = 5.067e-05
# alternative hypothesis: two-sided
