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

#combine date and time column 

House_data$Date_Time<-paste0(House_data$Date,"/",House_data$Time)

#Plot 1

hist(House_data$Global_active_power,main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")


## Save the plot in png format
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

