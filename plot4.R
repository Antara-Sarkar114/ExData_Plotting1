library(dplyr)
library(tidyr)
library(readr)
a<-grep("^household.*[.txt]$",list.files(),value = TRUE)
electric_consumption<-read.table(a, header = TRUE, sep = ";", na.strings = c("NA","?"))
electric_consumption$Date<-as.Date(electric_consumption$Date, "%d/%m/%Y")
electric_consumption$Time<-strptime(paste(electric_consumption$Date,electric_consumption$Time), "%Y-%m-%d %H:%M:%S", tz="CET")
electric_consumption<-filter(electric_consumption, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#Plot 4 - Multiple plots in one screen
png(filename = "plot4.png")
#Setting Parameter
par(mfrow=c(2,2), cex.lab=0.8, cex.axis=0.7, mar=(c(4,4,1,1)))
#Sub-plot1
with(electric_consumption, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
#Sub-plot2
with(electric_consumption, plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
#Sub-plot3
plot(electric_consumption$Time, electric_consumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(electric_consumption$Time, electric_consumption$Sub_metering_2, col="red")
lines(electric_consumption$Time, electric_consumption$Sub_metering_3, col="blue")
legend("topright" ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), cex = 0.6, pt.cex = 0.4, bty = "n")
#Subplot4
with(electric_consumption, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()
