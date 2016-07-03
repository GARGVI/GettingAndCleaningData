library(swirl)
install_from_swirl("Getting and Cleaning Data")
install_from_swirl
swirl()
getwd()
setwd("C:\\Users\\Gemma\\Dropbox\\Coursera\\GettingAndCleaningData\\Week1\\Rpractica")
vDir<-"C:\\Users\\Gemma\\Dropbox\\Coursera\\GettingAndCleaningData\\Week1\\Rpractica"
if (!file.exists(vDir)){
        dir.create(vDir)
}
setwd(vDir)
getwd()
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,".//housingIdaho.csv")

list.files("./")
downloadDate<-date()
downloadDate

vFile<-".//housingIdaho.csv"
idahoHousing<- read.table(vFile, header=TRUE, sep=",")
head(idahoHousing)
summary(idahoHousing)
str(idahoHousing)
table(idahoHousing$INSP)
?table

summary(idahoHousing$VAL)
str(idahoHousing$VAL)

worthHouses<- idahoHousing$VAL[idahoHousing$VAL==24 & !is.na(idahoHousing$VAL)]

idahoHousing$VAL[ !is.na(idahoHousing$VAL)]
?lapply
summary(worthHouses)
str(worthHouses)
str(idahoHousing$FES)

###############
#XLS FILES
###############
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(fileUrl,".//NatuaralGas.xlsx", mode="wb")
list.files("./")
downloadDate<-date()
downloadDate

install.packages("xlsx")
library(xlsx)
rowIndex <- 18:23
colIndx <- 7:15
dat <- read.xlsx(file="NatuaralGas.xlsx",sheetIndex=1,colIndex=colIndx,startRow=18, endRow=23, header=TRUE)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)
?read.xlsx
?download.file

###############
#XML FILES
###############
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl,".//restaurants.xml")
list.files("./")
downloadDate<-date()
downloadDate
install.packages("XML")
library(XML)
doc<- xmlTreeParse("restaurants.xml",useInternalNodes = TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
zipCode <-xpathSApply(rootNode,"//zipcode",xmlValue)
str(zipCode)
sum(zipCode=="21231")

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,".//housingIdaho2.csv")
list.files("./")
downloadDate<-date()
downloadDate
??fread
install.packages("data.table")
library(data.table)
DT<- fread("housingIdaho2.csv",sep=",", header=TRUE)
file.info("housingIdaho2.csv")$size
R.version.string
str(DT)
str(DT$pwgtp15)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])
rm(list = ls()) 
