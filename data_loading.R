#******************************************************************
#Step 0. Downloading dependencies
#******************************************************************
library(tidyverse)
library(dplyr)
library(readr)
library(plyr)
library(glue)


#******************************************************************
#Step 1. Downloading & unzipping data
#******************************************************************
# 1. Download data in to data folder (git will ignore this folder)
if(!file.exists("./data")){dir.create("./data")}
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
zipF <- "./data/household_power_consumption.zip"
outDir <- "./data"
household_power_consumption <- unzip(zipF, exdir = outDir)

# 2. Read data into global environment
household_power_consumption <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
smallDf <- head(household_power_consumption)

# # 3. Subset the data for dates 2007-02-01 & 2007-02-02
# # 3. Adjust variables
# household_power_consumption$date_object <- mutate(household_power_consumption, date_object = strptime(household_power_consumption$Time, "%H:%M:%S"))
# 

parseDateFrom <- function(dayString, timeString) {
  myDateFormat <- "%d/%m/%Y %H:%M:%S"
  combinedStrings <- glue(dayString, timeString, .sep=" ")
  myDateObject <- strptime(combinedStrings, myDateFormat)
  return(myDateObject)
}
dateObjectToUTFFormattedString <- function(dateObject) {
  utcDateFormat <- "%Y-%m-%dT%H:%M:%S"
  str <- strftime(dateObject, utcDateFormat)
}

theEasierWay<-function(myDf) {
  allTheDates <- NULL
  for (row in 1:nrow(myDf)) {
    myDateObject <- parseDateFrom(myDf$Date[row], myDf$Time[row]) 
    allTheDates <- append(allTheDates, myDateObject)
  }
  myDf$date_object <- allTheDates
  return(myDf)
}

samllDF <- mutate(smallDf, date_object = strptime(glue(smallDf$Date, smallDf$Time, .sep=" "), myDateFormat))
samllDF <- mutate(smallDf, date_object = c(1:6))
samllDF <- mutate(smallDf, date_object = glue(Date, Time, .sep=" "))

smallDf$new_time <- strptime(smallDf$Time, "%H:%M:%S")
smallDf$new_date <- as.Date(smallDf$Date, "%d/%m/%Y")

makeCombinedDateStringFromRow<-function(oneRowOfDf) {
  s <- glue(oneRowOfDf['Date'], oneRowOfDf['Time'], .sep=" ")
  return(s)
}

smallDf$date_string_combined <- apply(smallDf, MARGIN=2, FUN=makeCombinedDateStringFromRow)

dayAndTimeStringCombined <- glue(household_power_consumption$Date[1], household_power_consumption$Time[1], .sep=" ")
dayOnlyObject <- strptime(household_power_consumption$Date[1], "%d/%m/%Y" )
myDateObject <- strptime(dayAndTimeStringCombined, "%d/%m/%Y %H:%M:%S")
backToString <- strftime(myDateObject, "%d/%m/%Y %H:%M:%S")
dateAsStringDifferentFormat <- strftime(myDateObject, "%Y-%m-%dT%H:%M:%S")
# Date <- as.Date(household_power_consumption$Date, "%d/%m/%y")

smallDf <- head(household_power_consumption)
#smallDf$date_object <- 