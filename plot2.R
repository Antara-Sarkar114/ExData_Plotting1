library(dplyr)
library(tidyr)
library(readr)
a<-grep("^household.*[.txt]$",list.files(),value = TRUE)
electric_consumption<-read.table(a, header = TRUE, sep = ";", na.strings = c("NA","?"))
electric_consumption$Date<-as.Date(electric_consumption$Date, "%d/%m/%Y")
electric_consumption$Time<-strptime(paste(electric_consumption$Date,electric_consumption$Time), "%Y-%m-%d %H:%M:%S", tz="CET")
electric_consumption<-filter(electric_consumption, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#Plot 2 - Time Series line graph
png(filename = "plot2.png")
with(electric_consumption, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()