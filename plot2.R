#Script for generating plot2

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
  png("plot2.png", width = 480, height = 480)
  
  #Setting locale to English
  Sys.setlocale("LC_TIME", "C")
  
  #Plot graphic
  plot(data_DateTime, data$Global_active_power,
       xlab = "", ylab = "Global Active Power (kilowatts)",type = "l")
  
  #Closing png device
  dev.off()
  
} else {
  warning("File 'household_power_consumption' not found.", call. = F)
}