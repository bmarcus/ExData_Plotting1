#######################################################
# Exploratory Data Analysis - Project 1 - Plot 3
#######################################################

library("data.table")

# Download the raw data file (zipped)
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="./RAW_DATA/household_power_consumption.zip", 
              method="curl")

# unzip the data file and rename it locally
unzip(zipfile = "./RAW_DATA/household_power_consumption.zip", 
      exdir="./RAW_DATA")

# Read in the unzipped data file and put in data table
energyDT <- fread("./RAW_DATA/household_power_consumption.txt", 
                   na.strings = "?")

# Combine data and time into POSIXct date for filtering by time of day
energyDT[, dateTime := as.POSIXct(paste(Date, Time), 
         format = "%d/%m/%Y %H:%M:%S")]

# Filter dates from 2007-02-01 to 2007-02-02
energyDT <- energyDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Create Plot 3
plot(energyDT[, dateTime], energyDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(energyDT[, dateTime], energyDT[, Sub_metering_2],col="red")
lines(energyDT[, dateTime], energyDT[, Sub_metering_3],col="blue")
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1))

# copy plot to png file
dev.copy(png,"./plot3.png",width=480, height=480)
dev.off()