## This file and the data file should be in the working directory

# To clean up the Global Environment
# rm(list = ls())

# Rough estimation for amount of memory
# http://simplystatistics.org/2011/10/07/r-workshop-reading-in-large-data-frames/
# rows * # columns * 8 bytes / 2^20 
# 2075259 * 9 * 8 / 2^20 = 142.5 mb
# compare to object.size(fullData) = 126.8 mb

# To change the local settings to English
Sys.setlocale("LC_TIME", "English")

# Read full data
fullData <- read.table("household_power_consumption.txt", sep = ";",
                       header = TRUE, na.strings = "?" )

# Subset only two days
data <- subset(fullData, Date == "2/2/2007" | Date == "1/2/2007")

# Joins Date and Time columns
data[,1] <- paste(data$Date, data$Time)
colnames(data)[1] <- "Date_Time"
data$Time <- NULL
data$Date_Time <- strptime(data$Date_Time, format = "%d/%m/%Y %H:%M:%S")

# Generates plot
windows()
plot(data$Date_Time, data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab="", cex.lab = 0.8, cex.axis = 0.8)

# PNG file 
dev.copy(png, file = "plot2.png") 
dev.off()
