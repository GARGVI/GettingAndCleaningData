
dir<-"C:\\Users\\Gemma\\Dropbox\\Coursera\\GettingAndCleaningData\\Week3"
setwd(dir)
getwd()
if (!file.exists(dir)){
        dir.create(dir)
}

#############
#QUESTION 1
#############
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "Idaho.csv")
idaho<-read.csv("Idaho.csv")
dim(idaho)
str(idaho)
agricultureLogical<- idaho$ACR==3 & idaho$AGS==6
?which
which(agricultureLogical)

#############
#QUESTION 2
#############
install.packages("jpeg")
library(jpeg)
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
?download.file
download.file(fileUrl,destfile = "jeffJPEG.jpg", mode="wb")
img <- readJPEG("jeffPEG.jpg", native = TRUE)
quantile(img, probs = c(0.3,0.8))

#############
#QUESTION 3
#############
library(dplyr)
dfGDP<-read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",stringsAsFactors = FALSE,skip = 5, header = F)
dfEducation<-read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",stringsAsFactors = FALSE)
str(dfGDP)
str(dfEducation)
tblGDP<-tbl_df(dfGDP)
tblEducation<-tbl_df(dfEducation)
rm(dfGDP)
rm(dfEducation)
?bind_rows
?merge
?join
mergeData<-merge(tblGDP,tblEducation,by.x="V1",by.y="CountryCode")
mergeData<-inner_join(tblEducation,tblGDP,by=c("CountryCode" = "V1"))
mergeData<-filter(mergeData, V2!="")
str(mergeData)
mergeData<-arrange(mergeData,desc(as.numeric(V2)))
mergeData[13,"Long.Name"]
summarise(mergeData, count=n())

#############
#QUESTION 4
#############
str(mergeData)
mergeData<-mutate(mergeData, Income.Group= factor(Income.Group), V2=as.numeric(V2))
levels(mergeData$Income.Group)
by_IncomeGroup<-group_by(mergeData,Income.Group)
summarise(by_IncomeGroup, mean(V2,na.rm=T))

#############
#QUESTION 5
#############

?quantile
mergeData<-mutate(mergeData, quantile_rankGDP=cut(V2,breaks = quantile(V2, seq(0, 1, 0.2))))
mergeData %>%
        select(Income.Group,quantile_rankGDP)%>%
        filter(Income.Group=="Lower middle income", quantile_rankGDP=="(1,38.6]")%>%
        summarise(count=n())%>%
        print

