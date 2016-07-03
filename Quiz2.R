library(httr)
#With that installed, a local webserver is setup on port 1410 and provided you've setup your github application appropriately (with a redirect to http://localhost:1410).
install.packages("httpuv")
library(httpuv)
library(jsonlite)
#https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
oauth_endpoints("github")
myapp <- oauth_app("github", key = "881e59e8685123c02530", secret = "d18b0b0e330f4dcc2100d6a659adde5e853f7067")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)

#******************************************************
#******************QUIZ 1******************************
#******************************************************
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
?stop_for_status
stop_for_status(req)
json1<-content(req)

class(json1)
str(json1)

json2<- jsonlite::fromJSON(toJSON(json1))

?toJSON
class(json2)
str(json2)
names(json2)
json2[json2$name=="datasharing",]$created_at

#******************************************************
#******************QUIZ 2******************************
#******************************************************

install.packages("sqldf")
library("sqldf")
?sqldf
dir<-"C:\\Users\\Gemma\\Dropbox\\Coursera\\GettingAndCleaningData\\Week2"
setwd(dir)
getwd()
if (!file.exists(dir)){
        dir.create(dir)
}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "ComunitySurvey.csv")
dateDownloades<-date()
list.files()

library(data.table)
acs<- fread("ComunitySurvey.csv",sep=",", header=TRUE)
head(acs)
class(acs)
str(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")



#******************************************************
#******************QUIZ 3******************************
#******************************************************
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

#******************************************************
#******************QUIZ 4******************************
#******************************************************
?nchar
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode =readLines(con)
close(con)
htmlCode
nchar(c(htmlCode[10], htmlCode[20], htmlCode[30], htmlCode[100]))

#******************************************************
#******************QUIZ 5******************************
#******************************************************

?read.fwf
data <- read.fwf(file="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", skip = 4, widths=c(15, 4,9, 4,9, 4,9, 4,9))
str(data)
head(data)
class(data)
sum(data$V4)
