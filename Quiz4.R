setwd("C:\\Users\\Gemma\\Documents\\GettingAndCleaningData")

if(!file.exists("./data")){
        dir.create("./data")
}

#QUESTION 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl,destfile="./data/survey.csv")
surveyData <- read.csv("./data/survey.csv")
names(surveyData)
strsplit(names(surveyData),"wgtp")[[123]]


#QUESTION2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./data/GDPData.csv")
GDPData <- read.csv("./data/GDPData.csv",skip = 4, nrows = 214)
names(GDPData)
#replace "," 
GDPData$GDPMilions<-as.numeric(gsub(",","",GDPData$X.4))
str(GDPData)
summary(GDPData)
mean(GDPData$GDPMilions, na.rm = TRUE)

#QUESTION3
grep("^United",GDPData$X.3 ,value=TRUE)

#QUESTION4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="./data/CountryData.csv")
CountryData <- read.csv("./data/CountryData.csv")

?merge
GDPData<-data.table(GDPData)
CountryData<-data.table(CountryData)


mergedData = merge(GDPData,CountryData,by.x="X",by.y="CountryCode",all=TRUE)
grep("(fiscal year end: june)+", tolower(mergedData$Special.Notes),value=T)


#QUESTION 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
str(sampleTimes)

library(lubridate)
table(year(sampleTimes))
table(year(sampleTimes),wday(sampleTimes, label = T))

