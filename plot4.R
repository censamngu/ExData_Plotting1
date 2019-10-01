#set working directory
setwd("H:/Training/Coursera/")

#check if sub-directory exist and download the file
fileName <- "Power.zip"

if (!file.exists(fileName)){
  fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, fileName)
}

#check if folder exists and unzip the file
if (!file.exists("UCI Electric Power Consumption Dataset")){
  unzip(fileName)
}

#change directory to local repo
setwd("H:/Training/Coursera/ExData_Plotting1")

#read text file into R
power <- read.csv("H:/Training/Coursera/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

#convert data variables 
start_date <- as.Date("01/02/2007","%d/%m/%Y")
end_date <- as.Date("02/02/2007", "%d/%m/%Y")
all_dates <- as.Date(power$Date, "%d/%m/%Y")

#subsetting to required dates 
power_subset <- power[all_dates >= start_date & all_dates <=end_date,]

#concatenate vectors after converting to character
date_time <- paste(power_subset$Date, power_subset$Time)

#convert date_time to Date/Time classes
converted_dt <- strptime(date_time, format="%d/%m/%Y %H:%M:%S")

#save to PNG file with required width and height
png("plot4.png", width=480, height=480)

#set up for multiple graphs in single plot
par(mfcol = c(2,2))

#plot 1,1 aka plot from plot2.R
plot(converted_dt, power_subset$Global_active_power, 
     type = "l",
     xlab= "", 
     ylab="Global Active Power")

#plot 2,1 aka plot from plot3.R
plot(converted_dt, power_subset$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

#add Sub_metering_2 line to line graph
lines(converted_dt, power_subset$Sub_metering_2,
      type = "l",
      col = "red")

#add Sub_metering_3 line to line graph
lines(converted_dt, power_subset$Sub_metering_3,
      type = "l",
      col = "blue")

#add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = 1:1,
       cex = 0.8,
       bty = "n")

#plot 1,2
plot(converted_dt, power_subset$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#plot 2,2
plot(converted_dt, power_subset$Global_active_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

#returns the number and name of new active device (after the specified device has been shut down)
dev.off()