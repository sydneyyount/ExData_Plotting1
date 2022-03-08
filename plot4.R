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

#plotting data 
 par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(hhPC, {
       plot(Global_active_power~dateTime, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab="")
       plot(Voltage~dateTime, type="l", 
                       ylab="Voltage (volt)", xlab="")
       plot(Sub_metering_1~dateTime, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~dateTime,col='Red')
       lines(Sub_metering_3~dateTime,col='Blue')
       legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~dateTime, type="l", 
                     ylab="Global Rective Power (kilowatts)",xlab="")
   })
  
  #saving to file
  dev.copy(png, file="plot4.png", height=480, width=480)
  dev.off(
