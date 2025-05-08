#Loading the rvest package
library('rvest')
setwd("~/Desktop")


docUrl <- read.csv(file="link.csv", header=TRUE, stringsAsFactors=FALSE)

docUrl
for(j in 1:6){
  url <- docUrl[j,3]
  print(url)
  webpage <- read_html(url)
  
  #Sentiment for each doctor
  sentimentPos <- length(html_nodes(webpage,'.meddy-satisfied')) 
  sentimentNeg <- length(html_nodes(webpage,'.meddy-unsatisfied')) 
  sentimentNeu <- length(html_nodes(webpage,'.meddy-neutral')) 
  sentimentTotal <- length(html_nodes(webpage,'.status-icon')) 
  # sentimentNeg
  # sentimentNeu
  # sentimentPos
  # sentimentTotal
  
  # Pie Chart with Percentages
  slices <- c(sentimentNeu, sentimentNeg, sentimentPos)
  lbls <- c("Neutral", "Negative", "Positive")
  pct <- round(slices/sentimentTotal*100)
  lbls <- paste(lbls, pct) # add percents to labels
  lbls <- paste(lbls,"%",sep="") # ad % to labels
  pie(slices,labels = lbls, col=rainbow(length(lbls)),
      main="Pie Chart of Sentiments")
  
  #Using CSS selectors to scrap the names section
  names_data_html <- html_nodes(webpage,'.comment-name')

  #Converting the ranking data to text
  name_data <- html_text(names_data_html)

  #Using CSS selectors to scrap the comments section
  comment_data_html <- html_nodes(webpage,'.comment-body')

  #Converting the ranking data to text
  comment_data <- html_text(comment_data_html)

  commentTable <- data.frame(matrix(nrow=0,ncol=2))
  colnames(commentTable)[1]="Patient Name"
  colnames(commentTable)[2]="Patient Comment"


  for(k in 1:length(name_data)-1){
    commentTable[k,1] <- name_data[k]
    commentTable[k,2] <- comment_data[k]
  }
  commentTable <- apply(commentTable,2,as.character)

  doctor <- docUrl[j,2]
  doctorFile <- paste(doctor, ".csv")
  write.csv(commentTable, file=doctorFile)

  
}
