# Reading the data

setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-household_power_consumption")
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",as.is=TRUE)

# Excluding the data aprt from 1 Feb 2007 - 2 Feb 2007

data<-data[grepl("^[12]/2/2007", data[,1]),]

# Combining Date and Time together

data$datetime<-paste(data[,1], data[,2])
data$datetime<-strptime(data$datetime,format="%d/%m/%Y %H:%M:%S")

Converting Other Charcter values to numeric 
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)

#Now data is ready for all kind of Plots

# Plot 4 ( all combined)

# Open "PNG" device
png(filename="plot4.png", width=480, height=480)
# Set the plotting area to have 2 rows and 2 columns, filled by row
par(mfrow=c(2,2))

plot(data$datetime, data$Global_active_power, pch=NA, main="", ylab = "Global Active Power", xlab = "")
# Connect the dots
lines(data$datetime, data$Global_active_power)

plot(data$datetime, data$Voltage, pch=NA, main="", ylab = "Voltage", xlab = "datetime")
lines(data$datetime,data$Voltage)

plot(data$datetime, data$Sub_metering_1, pch=NA, main="", ylab = "Energy sub metering", xlab = "")
lines(data$datetime, data$Sub_metering_1, col="black")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
# Add a legend
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(1,1,1),
       col=c("black", "red", "blue"),
       bty="n")#Removes the border around the legend

plot(data$datetime, data$Global_reactive_power, pch=NA, main="", ylab = "Global_reactive_power", xlab = "datetime")
lines(data$datetime, data$Global_reactive_power)

# Close the "PNG" device
dev.off()

