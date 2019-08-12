library(dplyr)
data4<-read.table("household_power_consumption.txt", sep=";", header=T)
data4[,3:9]<-sapply(data4[,3:9], function(x) as.numeric(as.character(x)))
data4$datetime<-as.POSIXct(paste(data4$Date, data4$Time), format = "%d/%m/%Y %H:%M:%S")
data4$Date<-as.Date(data4$Date, "%d/%m/%Y")
subset4<-data4 %>% filter((Date=="2007-02-01") | (Date=="2007-02-02"))
## Plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Plot 1
plot(subset4[, 10], subset4[, 3], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(subset4[, 10],subset4[, 5], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(subset4[, 10], subset4[, 7], type="l", xlab="", ylab="Energy sub metering")
lines(subset4[, 10], subset4[, 8], col="red")
lines(subset4[, 10], subset4[, 9],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(subset4[, 10], subset4[,4], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
