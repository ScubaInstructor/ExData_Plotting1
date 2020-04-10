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
plot(dataFrame$timestamp, dataFrame$Global_active_power, type = "l", xlab ="", ylab="Global Active Power (kilowatts)");

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()