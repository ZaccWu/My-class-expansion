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
# result：
#                    FPG         sbp        dbp         TG       HDL-C
#        1.0000000 -0.2675452 -0.29475960 -0.3448209 -0.3446366  0.27932195
# FPG   -0.2675452  1.0000000  0.19675054  0.2712549  0.3883562 -0.20163401
# sbp   -0.2947596  0.1967505  1.00000000  0.8058814  0.1939844 -0.07084859
# dbp   -0.3448209  0.2712549  0.80588140  1.0000000  0.3137228 -0.12591467
# TG    -0.3446366  0.3883562  0.19398443  0.3137228  1.0000000 -0.33593348
# HDL-C  0.2793219 -0.2016340 -0.07084859 -0.1259147 -0.3359335  1.00000000
library(corrplot)
corrplot(res)
