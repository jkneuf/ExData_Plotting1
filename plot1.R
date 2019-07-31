library(readr)
library(lubridate)

# read in the data
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                    stringsAsFactors=FALSE, quote = "\"'", na.strings = "?", 
                    strip.white = TRUE)

# convert the Date using lubridate
power$Date <- dmy(power$Date)

# subset the data so we are only dealing with Feb 1st and 2nd of 2007
power <- subset(power, Date=="2007-02-01" | Date=="2007-02-02")

# get a datetime value for plotting
power$date_time <- ymd_hms(paste(power$Date, power$Time))

# make the histogram and label correctly
hist(power$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)")

# Copy my plot to a PNG file
dev.copy(png, file = "plot1.png", width=480, height=480, units="px", bg="white") 
# Don't forget to close the PNG device!
dev.off() 
     