library(dplyr)
library(tidyr)
library(readr)
a<-grep("^household.*[.txt]$",list.files(),value = TRUE)
electric_consumption<-read.table(a, header = TRUE, sep = ";", na.strings = c("NA","?"))
electric_consumption$Date<-as.Date(electric_consumption$Date, "%d/%m/%Y")
electric_consumption$Time<-strptime(paste(electric_consumption$Date,electric_consumption$Time), "%Y-%m-%d %H:%M:%S", tz="CET")
electric_consumption<-filter(electric_consumption, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
#Plot 1 - Histogram of global attractive power
png(filename = "plot1.png")
hist(electric_consumption$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()