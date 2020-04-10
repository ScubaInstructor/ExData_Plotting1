dataFile = "household_power_consumption.txt"

if(!file.exists(dataFile)){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "exdata_data_household_power_consumption.zip");
  unzip("exdata_data_household_power_consumption.zip");
}

power <- data.table::fread(dataFile, sep = ";", header = TRUE, na.strings = "?");
power$Date <- as.Date(power$Date, format="%d/%m/%Y");
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),];
df$Global_active_power <- as.numeric(as.character(df$Global_active_power));
hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)");

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()