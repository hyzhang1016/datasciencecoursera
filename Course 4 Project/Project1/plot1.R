library(dplyr)

data<-read.table("household_power_consumption.txt", sep=";", header=T)
data$Date<-as.Date(data$Date, "%d/%m/%Y")
subset<-data %>% filter((Date=="2007-02-01") | (Date=="2007-02-02"))
subset[,3:9]<-sapply(subset[,3:9], function(x) as.numeric(as.character(x)))


## Plot 1
png("plot1.png", width=480, height=480)
hist(subset[,3], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
