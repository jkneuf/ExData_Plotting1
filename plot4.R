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

# change it so four graphs show up in a 2x2 matrix
par(mfrow = c(2, 2))

# plot the top left graph
plot(power$date_time, power$Global_active_power,  
     ylab = "Global Active Power (kilowatts)", xlab="", type="l")

# plot the top right graph
plot(power$date_time, power$Voltage,  
     ylab = "Voltage", xlab="datetime", type="l")

# plot the bottom left graph
with(power, plot (date_time, Sub_metering_1, col="black", 
                  ylab = "Energy sub metering", xlab="", type="l"))
# then add the other two lines
with(power, lines(date_time, Sub_metering_2, col="red", type="l"))
with(power, lines(date_time, Sub_metering_3, col="blue", type="l"))
# then add the legend
legend("topright", inset=.008, lty=1:1, col = c("black", "red", "blue"), y.intersp = .7, cex=0.7,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), box.lty=0)

# then plot the bottom right graph
plot(power$date_time, power$Global_reactive_power,  
     ylab = "Global_reactive_power", xlab="datetime", type="l")

# Copy my plot to a PNG file
dev.copy(png, file = "plot4.png", width=480, height=480, units="px", bg="white") 
# Don't forget to close the PNG device!
dev.off() 

# change it so one graph shows up
par(mfrow = c(1, 1))
