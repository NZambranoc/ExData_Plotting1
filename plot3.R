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

#Generates plot3.png
png("plot3.png",480,480,bg="transparent")
with(EPCfeb2007,{
    plot(Sub_metering_1~datetime,type="n", ylab = "Energy sub metering",xlab="")
    lines(datetime,Sub_metering_1)
    lines(datetime,Sub_metering_2, col="red")
    lines(datetime,Sub_metering_3, col="blue")
    
})
legend("topright",col = c("black","red","blue"),lty = 1,lwd=2, legend =names(EPCfeb2007)[6:8] )
dev.off()
