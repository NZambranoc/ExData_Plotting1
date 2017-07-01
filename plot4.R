library(data.table)
library(lubridate)


EPC <- fread("household_power_consumption.txt",sep = ";",na.strings = "?")

#merges `Date` and `Time` variables to a single Date/Time class variable
EPC[,datetime:=paste(Date,Time)]
EPC<- EPC[,c(10,3:9)]
EPC[,datetime:=strptime(datetime,format="%d/%m/%Y %H:%M:%S")]

#Subset [1|2] Feb 2007 records
EPCfeb2007 <- EPC[month(datetime)==2 & year(datetime)==2007]
EPCfeb2007 <- EPCfeb2007[day(datetime)==1|day(datetime)==2]

#Generates plot4.png
png("plot4.png",480,480,bg="transparent")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
    plot(Global_active_power ~ Datetime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
         xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ Datetime, type = "l", 
         ylab = "Global_rective_power", xlab = "datetime")
})

dev.off()