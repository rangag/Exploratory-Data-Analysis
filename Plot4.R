##Load complete Dataset in to Memory
hpc_full <- read.csv("./household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                       check.names=F, stringsAsFactors=FALSE, comment.char="", quote='\"')
##Convert the Date Column data into R Date  (as by default it will be String)
hpc_full$Date <- as.Date(hpc_full$Date, format="%d/%m/%Y")

##Filter the Data between the given Dates
filterd<- subset(hpc_full,Date>="2007-02-01" & Date<="2007-02-02")

##unload the full data as it is no more equired, so memory can be gained back.
rm(hpc_full)


date_time <- paste(as.Date(filterd$Date), filterd$Time)
filterd$date_time <- as.POSIXct(date_time)

##plot 
par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,2,0))
with(filterd, {
    plot(Global_active_power~date_time, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~date_time, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~date_time, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~date_time,col='Red')
    lines(Sub_metering_3~date_time,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~date_time, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})
	 
##save the plot with required resolution.
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
