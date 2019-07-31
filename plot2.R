library(data.table)
library(lubridate)

# read in the data
power <- data.table::fread(input = "household_power_consumption.txt"
                           , na.strings="?")

# convert the Date using lubridate
power$Date <- dmy(power$Date)

# subset the data so we are only dealing with Feb 1st and 2nd of 2007
power <- subset(power, Date=="2007-02-01" | Date=="2007-02-02")

# get a datetime value for plotting
power$date_time <- ymd_hms(paste(power$Date, power$Time))

# plot the data
plot(power$date_time, power$Global_active_power,  
      ylab = "Global Active Power (kilowatts)", xlab="", type="l")

# Copy my plot to a PNG file
dev.copy(png, file = "plot1.png", width=480, height=480, units="px", bg="white") 
# Don't forget to close the PNG device!
dev.off() 
