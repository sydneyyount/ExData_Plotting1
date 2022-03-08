#Reading in the data file and converting columns to readable format
hhPC <- read.table('household_power_consumption.txt',header=TRUE,sep=";")
hhPC$Date <- as.Date(hhPC$Date, "%d/%m/%Y")

#subsetting data to specified date range
hhPC <- subset(hhPC,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#creating histogram of global active power

#making data into numeric variable type
hhPC$Global_active_power <- as.numeric(hhPC$Global_active_power)

#plotting histogram
hist(hhPC$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()