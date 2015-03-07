#Data arrangement

data<-read.table("household_power_consumption.txt", header= TRUE, sep=";")

data$Date<-as.Date(data$Date, format = "%d/%m/%Y")

within(data, { timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })

data[,3]<-as.numeric(data[,3])
data[,4]<-as.numeric(data[,4])
data[,5]<-as.numeric(data[,5])
data[,6]<-as.numeric(data[,6])
data[,7]<-as.numeric(data[,7])
data[,8]<-as.numeric(data[,8])
data[,9]<-as.numeric(data[,9])


subdata1<-data[data$Date == "2007-02-01",]
subdata2<-data[data$Date == "2007-02-02",]
subdata<-rbind(data[data$Date == "2007-02-01",], data[data$Date == "2007-02-02",])
subdata<-within(subdata, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S") })
subdata$timestamp<-as.POSIXct(subdata$timestamp, format = "%Y/%m/%d %H:%M:%S")

#Plot3

png(file="plot3.png")
plot(subdata$timestamp, subdata$Sub_metering_1-2, type="l", ylab="Energy sub metering", xlab="", yaxt="n")
axis(2, c(0, 10, 20, 30))
lines(subdata$timestamp,(subdata$Sub_metering_2-2)/7, type="l", col="RED")
lines(subdata$timestamp,subdata$Sub_metering_3, type="l", col="BLUE")
legend("topright", lty="solid", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
