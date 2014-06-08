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

# Graph 3


# Open "PNG" device
png(filename="plot3.png", width=480, height=480)

# Prepare the plot, but do not add any points
plot(data$datetime, data$Sub_metering_1, pch=NA, main="", ylab = "Energy sub metering", xlab = "")

# Connect the dots: black is station 1, red is 2, blue is 3
lines(data$datetime, data$Sub_metering_1, col="black")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")

# Add a legend
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(1,1,1),
       col=c("black", "red", "blue"))

# Close the "PNG" device
dev.off()
