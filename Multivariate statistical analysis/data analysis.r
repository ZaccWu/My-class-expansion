library(openxlsx)
data<-read.xlsx("C:/Users/Tinky/Desktop/公民素质.xlsx",1)
maxmin<-data.frame(公民科学素质建设能力指数=c(100,0),科普人员能力指数=c(100,0),科普基础设施能力指数=c(100,0),科普经费能力指数=c(100,0),大众传媒能力指数=c(100,0),科学教育与培训能力指数=c(100,0))

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
