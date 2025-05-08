#Loading the rvest package
library('rvest')
setwd("~/Desktop")


docUrl <- read.csv(file="link.csv", header=TRUE, stringsAsFactors=FALSE)


for(j in 1:nrow(docUrl)){
  url <- j

sentimentPos <- length(html_nodes(webpage,'.meddy-satisfied')) 
sentimentNeg <- length(html_nodes(webpage,'.meddy-unsatisfied')) 
sentimentNeu <- length(html_nodes(webpage,'.meddy-neutral')) 
sentimentTotal <- length(html_nodes(webpage,'.status-icon')) 
sentimentNeg
sentimentNeu
sentimentPos
sentimentTotal

# Pie Chart with Percentages
slices <- c(sentimentNeu, sentimentNeg, sentimentPos) 
lbls <- c("Neutral", "Positive", "Negative")
pct <- round(slices/sentimentTotal*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Sentiments")

}