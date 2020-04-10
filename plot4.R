dataFile = "household_power_consumption.txt"

if(!file.exists(dataFile)){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "exdata_data_household_power_consumption.zip");
  unzip("exdata_data_household_power_consumption.zip");
}

power <- data.table::fread(dataFile, sep = ";", header = TRUE, na.strings = "?");
power$Date <- as.Date(power$Date, format="%d/%m/%Y");
dataFrame <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),];

dataFrame$Global_active_power <- as.numeric(as.character(dataFrame$Global_active_power));
dataFrame <- transform(dataFrame, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

dataFrame$Sub_metering_1 <- as.numeric(as.character(dataFrame$Sub_metering_1))
dataFrame$Sub_metering_2 <- as.numeric(as.character(dataFrame$Sub_metering_2))
dataFrame$Sub_metering_3 <- as.numeric(as.character(dataFrame$Sub_metering_3))

dataFrame$Global_active_power <- as.numeric(as.character(dataFrame$Global_active_power))
dataFrame$Global_reactive_power <- as.numeric(as.character(dataFrame$Global_reactive_power))
dataFrame$Voltage <- as.numeric(as.character(dataFrame$Voltage))

par(mfrow=c(2,2))

plot(dataFrame$timestamp,dataFrame$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(dataFrame$timestamp,dataFrame$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dataFrame$timestamp, dataFrame$Sub_metering_1, type = "l", xlab ="", ylab="Energy sub metering");
lines(dataFrame$timestamp,dataFrame$Sub_metering_2,col="red")
lines(dataFrame$timestamp,dataFrame$Sub_metering_3,col="blue")
legend(x = "topright", bty="n", cex=.8, y.intersp = .8, y = .7, col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))

plot(dataFrame$timestamp,dataFrame$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()