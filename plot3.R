library(dplyr)
library(tidyr)
library(readr)
a<-grep("^household.*[.txt]$",list.files(),value = TRUE)
electric_consumption<-read.table(a, header = TRUE, sep = ";", na.strings = c("NA","?"))
electric_consumption$Date<-as.Date(electric_consumption$Date, "%d/%m/%Y")
electric_consumption$Time<-strptime(paste(electric_consumption$Date,electric_consumption$Time), "%Y-%m-%d %H:%M:%S", tz="CET")
electric_consumption<-filter(electric_consumption, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#Plot 3 - Multiple Line Graph
png(filename = "plot3.png")
plot(electric_consumption$Time, electric_consumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(electric_consumption$Time, electric_consumption$Sub_metering_2, col="red")
lines(electric_consumption$Time, electric_consumption$Sub_metering_3, col="blue")
legend("topright" ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), cex = 1, pt.cex = 0.9)
dev.off()