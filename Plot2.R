##Load complete Dataset in to Memory
hpc_full <- read.csv("./household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                       check.names=F, stringsAsFactors=FALSE, comment.char="", quote='\"')
##Convert the Date Column data into R Date  (as by default it will be String)
hpc_full$Date <- as.Date(hpc_full$Date, format="%d/%m/%Y")

##Filter the Data between the given Dates
filterd<- subset(hpc_full,Date>="2007-02-01" & Date<="2007-02-02")

##unload the full data as it is no more equired, so memory can be gained back.
rm(hpc_full)

##plot 
plot(filterd$Global_active_power~filterd$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
	 
##save the plot with required resolution.
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
