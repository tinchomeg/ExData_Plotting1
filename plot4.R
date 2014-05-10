#Script for generating plot4

#Checking file existence
if(any(file.exists("household_power_consumption.txt", 
                   "household_power_consumption.zip"))) {
  
  #Unzipping file if needed
  if(!file.exists("household_power_consumption.txt")) {
    unzip("household_power_consumption.zip")
  }
  
  #Reading data from file
  data <- read.table("household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     stringsAsFactors = FALSE,
                     na.strings = "?")
  
  #Subsetting data on dates 1/2/2007 - 2/2/2007
  data <- subset(data, grepl("^[12]/2/2007$", data$Date))
  
  #Converting dates to POSIXlt class
  data_DateTime <- with(data, strptime(paste(Date, Time), "%d/%m/%Y %X"))
  
  #Opening png device for file 'plot1.png'
  png("plot4.png", width = 480, height = 480)
  
  #Setting locale to English
  Sys.setlocale("LC_TIME", "C")
  
  #Setting layout for graphics
  par(mfrow = c(2,2))
  
  #Plot graphic 1
  plot(data_DateTime, data$Global_active_power, xlab = "", 
       ylab = "Global active power", type = "l")
  
  #Plot graphic 2
  plot(data_DateTime, data$Voltage, xlab = "datetime", 
       ylab = "Voltage", type = "l")
  
  #Plot graphic 3
  plot(data_DateTime, data$Sub_metering_1, col = "black", type = "l",
       xlab = "", ylab = "Energy sub metering")
  lines(data_DateTime, data$Sub_metering_2, type = "l", col = "red")
  lines(data_DateTime, data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), bg = NA, box.lty = 0,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Plot graphic 4
  plot(data_DateTime, data$Global_reactive_power, xlab = "datetime", 
       ylab = "Global_reactive_power", type = "l")
  
  #Closing png device
  dev.off()
  
} else {
  warning("File 'household_power_consumption' not found.", call. = F)
}