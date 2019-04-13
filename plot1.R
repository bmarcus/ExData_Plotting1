#######################################################
# Exploratory Data Analysis - Project 1 - Plot 1
#######################################################
library(data.table)
library(dplyr)

# Download the raw data file (zipped)
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile="./RAW_DATA/household_power_consumption.zip", 
        method="curl")

# unzip the data file and rename it locally
unzip(zipfile = "./RAW_DATA/household_power_consumption.zip", exdir="./RAW_DATA")

# Read in the unzipped data file and put in tibble
newFile <- fread("./RAW_DATA/household_power_consumption.txt", na.strings = "?")

# create new DateTime column that combines Date and Time columns and put in new 
# format d/%m/%Y %H:%M:%S
newFile[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#filter the data to only include dates 02-01-2007 through 02-02-2017
newFile <- filter(newFile, 
        DateTime >= as.Date("2007-02-01 00:00:00"), 
        DateTime <= as.Date("2007-02-02 00:00:00"))

# plot Global Active Power / Frequency
hist(newFile$Global_active_power,  
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", 
        ylab="Frequency", 
        col="Red")

# copy plot to png file
dev.copy(png,"./plot.png")
dev.off()