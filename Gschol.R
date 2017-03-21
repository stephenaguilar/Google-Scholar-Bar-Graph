
#load the relevant R libraries
library(scholar)
library(ggplot2)
library(gridExtra)
require(grid)

#Pull relevant data from Google Scholar
cit <- get_citation_history('1DVBiSkAAAAJ')
list_metrics <- get_profile('1DVBiSkAAAAJ')

#convert profile information (includeing impact metrics) from list into data frame
metrics <- data.frame(matrix(unlist(list_metrics), nrow=1, byrow=T))

#drop everything except total citations, hindex and i10index
metrics <- metrics[ -c(1:3,7:12)]

#rename columns in profile information data frame
colnames(metrics)[1] <- "citations"
colnames(metrics)[2] <- "hindex"
colnames(metrics)[3] <- "i10index"


#build bar grapg PNG of citationsisnta

plot <- ggplot(cit,aes(x=year,y=cites))+
  geom_bar(stat='identity', fill="#0099cc", colour="#000000")+
  theme_bw()+
  annotate('text',label=format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"),x=-Inf,y=Inf,vjust=1.5,hjust=-0.03,size=2.0,colour='white')+
  


png('/Users/aguilars/Box Sync/Webiste/scholar_citations_SJAguilar.png',width=500,height=400,res=150,bg="transparent")
plot +
  theme(
    plot.background = element_rect(fill ="transparent", colour=NA),
    plot.title = element_text(colour = "#e2e2e2", size = 10, vjust = 1.5),
    axis.text = element_text(colour = "#e2e2e2", size = 10),
    axis.title.x = element_text(colour ="transparent", size = 10),
    axis.title.y = element_text(colour ="transparent", size = 10),
    panel.grid.major = element_line(colour = "#e2e2e2"),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "transparent")
  )
dev.off()

