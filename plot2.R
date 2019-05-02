#######################################################
# Exploratory Data Analysis - Project 1 - Plot 2
#######################################################
library(data.table)

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
energyDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
energyDT <- energyDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# cast Date column as date datatype to be used later for date comparison.
#energyDT[,Date := as.Date(Date, 
#                           format = "%d/%m/%Y")]


# filter based on dates between 02-01-2007 and 02-02-2007
#energyDT <- filter(energyDT, 
#                    Date >= ymd("2007-02-01"), 
#                    Date <= ymd("2007-02-02"))

# Prevent the histogram from printing in scientific notation
# energyDT[, Global_active_power := lapply(.SD, as.numeric, .SDcols = c("Global_active_power"))]

#png("plot2.png", width=480, height=480)

## Plot 2
plot(x = energyDT[, dateTime],
     y = energyDT[, Global_active_power],
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

#dev.off()