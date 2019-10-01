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

#save to PNG file with required width and height
png("plot1.png", width=480, height=480)

#construct histogram
hist(power_subset$Global_active_power, 
     col="red", 
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")

#returns the number and name of new active device (after the specified device has been shut down)
dev.off()