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

# first plot the sub_metering_1 data and labels
with(power, plot (date_time, Sub_metering_1, col="black", 
                  ylab = "Energy sub metering", xlab="", type="l"))
# then add the other two lines
with(power, lines(date_time, Sub_metering_2, col="red", type="l"))
with(power, lines(date_time, Sub_metering_3, col="blue", type="l"))
# then add the legend
legend("topright", lty=1:1, col = c("black", "red", "blue"), y.intersp = .7, cex=1,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
     
# Copy my plot to a PNG file
dev.copy(png, file = "plot3.png", width=480, height=480, units="px", bg="white") 
# Don't forget to close the PNG device!
dev.off() 