#######################################################
# Exploratory Data Analysis - Project 1 - Plot 1
#######################################################
library(data.table)
library(dplyr)
library(lubridate)

# Download the raw data file (zipped)
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile="./RAW_DATA/household_power_consumption.zip", 
        method="curl")

# unzip the data file and rename it locally
unzip(zipfile = "./RAW_DATA/household_power_consumption.zip", exdir="./RAW_DATA")

# Read in the unzipped data file and put in tibble
energyDT <- fread("./RAW_DATA/household_power_consumption.txt", na.strings = "?")

# cast Date column as date datatype to be used later for date comparison.
energyDT[,Date := as.Date(Date, format = "%d/%m/%Y")]

# filter based on dates between 02-01-2007 and 02-02-2007
energyDT <- filter(energyDT, 
        Date >= ymd("2007-02-01"), 
        Date <= ymd("2007-02-02"))

# plot Global Active Power / Frequency
hist(energyDT$Global_active_power,  
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", 
        ylab="Frequency", 
        col="Red")

# copy plot to png file
dev.copy(png,"./plot1.png",width=480, height=480)
dev.off()