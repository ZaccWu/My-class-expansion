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
