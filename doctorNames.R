#Loading the rvest package
install.packages('rvest')
library('rvest')
setwd("~/Desktop")
#Specifying the url for desired website to be scrapped
url <- 'https://www.meddy.co/doctors/general+practitioner/'

#Reading the HTML code from the website
webpage <- read_html(url)

doctorList <- html_nodes(webpage,'.listings-card-header')

names <- html_text(doctorList)

write.csv(names, file="docname.csv")

cleannames = gsub("\nDr. ", "", names)
cleannames = gsub("\n", "", cleannames)

cleannames2 = gsub(" ", "-", cleannames)


nameTable <- data.frame(matrix(nrow=0,ncol=2))
colnames(nameTable)[1]="Doctor Name"
colnames(nameTable)[2]="Profile Link"


for(j in 1:length(cleannames2)){
  nameTable[j,1] <- cleannames[j]
  nameTable[j,2] <- paste("https://www.meddy.co/",cleannames2[j],sep="")}

write.csv(nameTable, file="link.csv")
