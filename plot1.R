#Script for generating plot1

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
  
  #Opening png device for file 'plot1.png'
  png("plot1.png", width = 480, height = 480)
  
  #Plotting histogram with red bars
  hist(data$Global_active_power, main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)", col = "red")
  
  #Closing png device
  dev.off()
  
} else {
  warning("File 'household_power_consumption' not found.", call. = F)
}