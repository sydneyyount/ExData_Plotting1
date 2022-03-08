#Reading in the data file and converting columns to readable format
hhPC <- read.table('household_power_consumption.txt',header=TRUE,sep=";")
hhPC$Date <- as.Date(hhPC$Date, "%d/%m/%Y")
 
 #subsetting data to specified date range
 hhPC <- subset(hhPC,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
 
 #converting data to have Date and Time together
 dateTime <- paste(hhPC$Date,hhPC$Time)
 dateTime <- setNames(dateTime, "DateTime")
 hhPC <- hhPC[ ,!(names(hhPC) %in% c("Date","Time"))]
 hhPC <- cbind(dateTime, hhPC)
 hhPC$dateTime <- as.POSIXct(dateTime)

#making data into numeric variable type
hhPC$Global_active_power <- as.numeric(hhPC$Global_active_power)


#creating histogram of global active power
plot(hhPC$Global_active_power~hhPC$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#printing to png file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()