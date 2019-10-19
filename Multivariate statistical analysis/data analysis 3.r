# 数据导入
library(openxlsx)
df=read.xlsx("C:/Users/Tinky/Desktop/sample.xlsx",2)
df<-df[-1,] # 删去中文解释行
# 数据预处理
df[,c(3:7,10:12)]=(lapply(df[,c(3:7,10:12)],as.numeric)) # 转换为数值
# 如果数据缺失weight、age，将本行删去
df=df[(complete.cases(df['weight'])),]
df=df[(complete.cases(df['age'])),]
df=df[(df['weight']<120 & df['age']>20),] # 除去异常值

# 构造向量X
X<-cbind(df[6:7],df[10],df[4:5],df[11:12])
bmi=X[,1]/(X[,2]/100)^2
bmi=as.matrix(bmi)
X=as.matrix(X[,3:7])
X<-cbind(bmi,X) 
colnames(X)<-c("BMI","FPG","sbp","dbp","TG","HDL-C")

# 相关性分析
cor(X)
# result：
# 	  BMI	      FPG	      sbp	        dbp	        TG	      HDL-C
# BMI	1.0000000	0.2975015	0.33506826	0.3819853	0.3945420	-0.34966111
# FPG	0.2975015	1.0000000	0.19962318	0.2750135	0.3906804	-0.20378978
# sbp	0.3350683	0.1996232	1.00000000	0.8035468	0.1901760	-0.06781469
# dbp	0.3819853	0.2750135	0.80354678	1.0000000	0.3167529	-0.12194851
# TG	0.3945420	0.3906804	0.19017603	0.3167529	1.0000000	-0.33519105
# HDL-C	-0.3496611	-0.2037898	-0.06781469	-0.1219485	-0.3351910	1.00000000

# 正态性分析
# BMI
qqnorm(X[,1])
qqline(X[,1])
# FPG
qqnorm(as.numeric(X[,2]))
qqline(as.numeric(X[,2]))
# sbp
qqnorm(as.numeric(X[,3]))
qqline(as.numeric(X[,3]))
# dbp
qqnorm(as.numeric(X[,4]))
qqline(as.numeric(X[,4]))
# TG
qqnorm(as.numeric(X[,5]))
qqline(as.numeric(X[,5]))
# HDL-C
qqnorm(as.numeric(X[,6]))
qqline(as.numeric(X[,6]))

# 代谢综合征
df2<-df
new<-matrix(FALSE,nrow(df2),1)
df2<-cbind(bmi,df2,new)
colnames(df2)<-c("BMI","No","gender","age","sbp","dbp","weight","height","smoke","drunk","FPG","TG","HDL-C","syn")
# 添加一列描述是否有代谢综合症
cond<-function(x){
    i=0
    if(as.numeric(x['BMI'])>=25.0) i=i+1
    if(as.numeric(x['FPG'])>=6.1) i=i+1
    if(as.numeric(x['sbp'])>=140||as.numeric(x['dbp'])>=90) i=i+1
    if(as.numeric(x['TG'])>=1.7||((as.numeric(x['HDL-C'])<0.9&&x['gender']=='男')||(as.numeric(x['HDL-C'])<1&&x['gender']=='女'))) i=i+1
    
    if(i>=3) return(TRUE)
    else return(FALSE)
}
for(i in 1:nrow(df2)){
    if(cond(df2[i,])){
        df2[i,'syn']=TRUE
    }
}
# 与性别的关系
male_synT<-nrow(df2[(df2[,'gender']=='男')&(df2[,'syn']==TRUE),])
male_synF<-nrow(df2[(df2[,'gender']=='男')&(df2[,'syn']==FALSE),])
female_synT<-nrow(df2[(df2[,'gender']=='女')&(df2[,'syn']==TRUE),])
female_synF<-nrow(df2[(df2[,'gender']=='女')&(df2[,'syn']==FALSE),])
cat("男性患者总数：",male_synT,"  男性非患者总数：",male_synF,"  男性患病率：",male_synT/(male_synT+male_synF),"\n")
cat("女性患者总数：",female_synT,"  女性非患者总数：",female_synF,"  女性患病率：",female_synT/(female_synT+female_synF),"\n")

# 均值的区间估计
df2T=df2[df2[,'syn']==TRUE,]
df2F=df2[df2[,'syn']==FALSE,]

t.test(df2T[,'FPG'],df2F[,'FPG'],mu=mean(df2T[,'FPG'])-mean(df2F[,'FPG']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "FPG"] and df2F[, "FPG"]
# t = 0, df = 31.766, p-value = 1
# alternative hypothesis: true difference in means is not equal to 1.35993
# 95 percent confidence interval:
#  0.8422791 1.8775800
# sample estimates:
# mean of x mean of y 
#   6.75500   5.39507 
t.test(df2T[,'TG'],df2F[,'TG'],mu=mean(df2T[,'TG'])-mean(df2F[,'TG']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "TG"] and df2F[, "TG"]
# t = 0, df = 31.874, p-value = 1
# alternative hypothesis: true difference in means is not equal to 1.802441
# 95 percent confidence interval:
# 0.9823776 2.6225050
# sample estimates:
# mean of x mean of y 
# 3.526667  1.724225 
t.test(df2T[,'BMI'],df2F[,'BMI'],mu=mean(df2T[,'BMI'])-mean(df2F[,'BMI']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "BMI"] and df2F[, "BMI"]
# t = 0, df = 51.161, p-value = 1
# alternative hypothesis: true difference in means is not equal to 3.784531
# 95 percent confidence interval:
#  2.900968 4.668094
# sample estimates:
# mean of x mean of y 
# 27.05387  23.26934 
t.test(df2T[,'HDL-C'],df2F[,'HDL-C'],mu=mean(df2T[,'HDL-C'])-mean(df2F[,'HDL-C']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "HDL-C"] and df2F[, "HDL-C"]
# t = 0, df = 42.678, p-value = 1
# alternative hypothesis: true difference in means is not equal to -0.2003568
# 95 percent confidence interval:
#  -0.31245500 -0.08825862
# sample estimates:
# mean of x mean of y 
# 1.434667  1.635023 
t.test(df2T[,'weight'],df2F[,'weight'],mu=mean(df2T[,'weight'])-mean(df2F[,'weight']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "weight"] and df2F[, "weight"]
# t = 0, df = 43.344, p-value = 1
# alternative hypothesis: true difference in means is not equal to 13.97549
# 95 percent confidence interval:
# 10.25541 17.69558
# sample estimates:
# mean of x mean of y 
# 77.99333  64.01784 
t.test(df2T[,'sbp'],df2F[,'sbp'],mu=mean(df2T[,'sbp'])-mean(df2F[,'sbp']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "sbp"] and df2F[, "sbp"]
# t = 0, df = 37.015, p-value = 1
# alternative hypothesis: true difference in means is not equal to 17.50235
# 95 percent confidence interval:
#  11.02365 23.98104
# sample estimates:
# mean of x mean of y 
#  134.0000  116.4977 
t.test(df2T[,'dbp'],df2F[,'dbp'],mu=mean(df2T[,'dbp'])-mean(df2F[,'dbp']),conf.level=0.95)
# Welch Two Sample t-test
# data:  df2T[, "dbp"] and df2F[, "dbp"]
# t = 0, df = 40.112, p-value = 1
# alternative hypothesis: true difference in means is not equal to 13.4615
# 95 percent confidence interval:
#  9.664766 17.258239
# sample estimates:
# mean of x mean of y 
 87.76667  74.30516 
