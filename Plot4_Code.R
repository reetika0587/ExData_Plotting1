#To avoid auto conversion
options(stringsAsFactors = FALSE)

#setting working directory
filepath<-"C:/Users/rchoudh/Downloads/exdata%2Fdata%2Fhousehold_power_consumption"
setwd(filepath)

#Reading data from the text file
House_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#check the format of each variable
str(House_data)

#changing Date and Time format as they are char

House_data$Date<-as.Date(House_data$Date,"%d/%m/%Y")

## Subset the data from 1,Feb to 2,Feb
House_data <- subset(House_data,House_data$Date >= as.Date("2007-2-1") & House_data$Date <= as.Date("2007-2-2"))

#Drop missing values

House_data <- House_data[complete.cases(House_data),]

#combine date and time column 

House_data$Date_Time<-paste(House_data$Date,House_data$Time)

#format Date_Time Column 

House_data$Date_Time <- as.POSIXct(House_data$Date_Time)

#Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(House_data$Global_active_power~House_data$Date_Time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(House_data$Voltage~House_data$Date_Time, type="l",ylab="Voltage (volt)", xlab="")
plot(House_data$Sub_metering_1~House_data$Date_Time, type="l",ylab="Global Active Power (kilowatts)", xlab="")
lines(House_data$Sub_metering_2~House_data$Date_Time,col='Red')
lines(House_data$Sub_metering_3~House_data$Date_Time,col='Blue')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1:2, text.font = 0.5,cex = 0.3)
plot(House_data$Global_reactive_power~House_data$Date_Time, type="l",ylab="Global Rective Power (kilowatts)",xlab="")

## Save the plot in png format
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

