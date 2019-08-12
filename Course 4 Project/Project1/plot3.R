library(dplyr)
data3<-read.table("household_power_consumption.txt", sep=";", header=T)
data3[,3:9]<-sapply(data3[,3:9], function(x) as.numeric(as.character(x)))
data3$datetime<-as.POSIXct(paste(data3$Date, data3$Time), format = "%d/%m/%Y %H:%M:%S")
data3$Date<-as.Date(data3$Date, "%d/%m/%Y")
subset3<-data3 %>% filter((Date=="2007-02-01") | (Date=="2007-02-02"))
## Plot 3
png("plot3.png", width=480, height=480)
plot(subset3[, 10], subset3[, 7], type="l", xlab="", ylab="Energy sub metering")
lines(subset3[, 10], subset3[, 8],col="red")
lines(subset3[, 10], subset3[, 9],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
