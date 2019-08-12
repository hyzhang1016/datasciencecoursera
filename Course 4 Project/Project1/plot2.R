library(dplyr)
data2<-read.table("household_power_consumption.txt", sep=";", header=T)
data2[,3:9]<-sapply(data2[,3:9], function(x) as.numeric(as.character(x)))
data2$datetime<-as.POSIXct(paste(data2$Date, data2$Time), format = "%d/%m/%Y %H:%M:%S")
data2$Date<-as.Date(data2$Date, "%d/%m/%Y")
subset2<-data2 %>% filter((Date=="2007-02-01") | (Date=="2007-02-02"))
## Plot 2
png("plot2.png", width=480, height=480)
plot(x = subset2[, 10]
     , y = subset[, 3]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
