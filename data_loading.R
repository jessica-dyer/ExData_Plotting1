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

if(!exists("filtered_df")) {
  fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipF <- "./data/household_power_consumption.zip"
  
  if(!file.exists(zipF)) {
    download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
    outDir <- "./data"
    household_power_consumption <- unzip(zipF, exdir = outDir)
  }

  # 2. Read data into global environment
  household_power_consumption <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
  
  # 3. Filter the data for dates 2007-02-01 & 2007-02-02
  filtered_df <- filter(household_power_consumption, Date=="1/2/2007" | Date=="2/2/2007")
  
  # 4. Adjust variables
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
  
  # 5. Create a date/time object 
  filtered_df <- theEasierWay(filtered_df)
}
