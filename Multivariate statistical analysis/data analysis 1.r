library(openxlsx)
data<-read.xlsx("C:/Users/Tinky/Desktop/公民素质.xlsx",1)
maxmin<-data.frame(公民科学素质建设能力指数=c(100,0),科普人员能力指数=c(100,0),科普基础设施能力指数=c(100,0),科普经费能力指数=c(100,0),大众传媒能力指数=c(100,0),科学教育与培训能力指数=c(100,0))

library(fmsb) 
value<-data.frame(df[1,2:7])
hangzhou<-rbind(maxmin,value)
radarchart(hangzhou,axistype=0,seg=4,centerzero=TRUE,plwd=4 ,
  pcol=rgb(91,155,213,155,maxColorValue = 255) ,
  pfcol=rgb(91,155,213,155,maxColorValue = 255)
)

value<-data.frame(df[2,2:7])
ningbo<-rbind(maxmin,value)
radarchart(ningbo,axistype=0,seg=4,centerzero=TRUE,plwd=4 ,
  pcol=rgb(91,155,213,155,maxColorValue = 255) ,
  pfcol=rgb(91,155,213,155,maxColorValue = 255)
)

value<-data.frame(df[3,2:7])
wenzhou<-rbind(maxmin,value)
radarchart(wenzhou,axistype=0,seg=4,centerzero=TRUE,plwd=4 ,
  pcol=rgb(91,155,213,155,maxColorValue = 255) ,
  pfcol=rgb(91,155,213,155,maxColorValue = 255)
)

value<-data.frame(df[1:3,2:7])
value<-rbind(rep(100,6),rep(0,6),value)
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
radarchart( value  , axistype=1 , 
   pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
   cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,100,6), cglwd=0.8,
   vlcex=0.8 
   )
legend(x=0.7, y=1, legend = list('hangzhou','ningbo','wenzhou'), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1, pt.cex=3)

value<-data.frame(df[1:11,2:7])
value<-rbind(rep(100,6),rep(0,6),value)
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9),rgb(0.3,0.4,0.6,0.9),
               rgb(0.2,0.7,0.3,0.9),rgb(0.4,0.6,0.1,0.9),rgb(0.6,0.2,0.3,0.9),rgb(0.2,0.7,0.8,0.9),
                rgb(0.7,0.4,0.6,0.9),rgb(0.8,0.5,0.2,0.9),rgb(0.7,0.3,0.5,0.9))
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4),rgb(0.3,0.4,0.6,0.4),
               rgb(0.2,0.7,0.3,0.4),rgb(0.4,0.6,0.1,0.4),rgb(0.6,0.2,0.3,0.4),rgb(0.2,0.7,0.8,0.4),
                rgb(0.7,0.4,0.6,0.4),rgb(0.8,0.5,0.2,0.4),rgb(0.7,0.3,0.5,0.4))
radarchart( value  , axistype=1 , 
   pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
   cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,100,6), cglwd=0.8,
   vlcex=0.8 
   )
legend(x=0.9, y=0.6, legend = list('hangzhou','ningbo','wenzhou','jiaxing','huzhou','shaoxing','jinhua','quzhou','zhoushan','taizhou','lishui'), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1, pt.cex=3)

value1<-data.frame(df[1,2:7])
value2<-data.frame(df[12,2:7])
value<-rbind(rep(100,6),rep(0,6),value1,value2)
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9))
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4))
radarchart( value  , axistype=1 , 
   pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
   cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,100,6), cglwd=0.8,
   vlcex=0.8 
   )
legend(x=0.7, y=1, legend = list('hangzhou','average'), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1, pt.cex=3)

par(mfrow=c(2,3))
barplot(df[1:11,2],col=rainbow(11),main='公民科学素质建设能力指数')
barplot(df[1:11,3],col=rainbow(11),main='科普人员能力指数')
barplot(df[1:11,4],col=rainbow(11),main='科普基础设施能力指数')
barplot(df[1:11,5],col=rainbow(11),main='科普经费能力指数')
barplot(df[1:11,6],col=rainbow(11),main='大众传媒能力指数')
barplot(df[1:11,7],col=rainbow(11),main='科学教育与培训能力指数',
        legend=list('hangzhou','ningbo','wenzhou','jiaxing','huzhou','shaoxing','jinhua','quzhou','zhoushan','taizhou','lishui'))
