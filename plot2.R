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

#Generates plot2.png
png("plot2.png",480,480,bg="transparent")
with(EPCfeb2007,plot(Global_active_power~datetime,type="l", ylab = "Global Active Power",xlab=""))
dev.off()
