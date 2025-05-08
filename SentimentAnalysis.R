#from https://www.springboard.com/blog/text-mining-in-r/


# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("syuzhet")
install.packages("ggplot2")
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library('syuzhet')
library('rvest')
library("ggplot2")

#Specifying the url for desired website to be scrapped
url <- 'https://www.meddy.co/mohammad-asha/'

#Reading the HTML code from the website
webpage <- read_html(url)


#Using CSS selectors to scrap the names section
comments_data_html <- html_nodes(webpage,'.comment-body')

#Converting the ranking data to text
textdata <- html_text(comments_data_html)

# Load the data as a corpus
docs <- Corpus(VectorSource(textdata))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming (reduces words to their root form)
docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

par(bg="grey30")
png(file="WordCloud.png",width=1000,height=700, bg="grey30")
wordcloud(d$word, d$freq, col=terrain.colors(length(d$word), alpha=0.9), random.order=FALSE, rot.per=0.3 )
title(main = "Meddy's Most Used Terms to Describe Doctors", font.main = 1, col.main = "cornsilk3", cex.main = 1.5)

d<-get_nrc_sentiment(textdata)
td<-data.frame(t(d))



#Transformation and  cleaning
names(td)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td), td)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]
dev.off()
qplot(sentiment, data=td_new2, weight=count, geom="bar",fill=sentiment)+ggtitle("Patient sentiments")

