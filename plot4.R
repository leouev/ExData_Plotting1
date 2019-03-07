# step 1 preparing
## downlaod the data into the working directory
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("exdata_data_household_power_consumption.zip")) {
        download.file(data_url, "exdata_data_household_power_consumption.zip", method = "curl")
}
## unzip the data
if(!file.exists("household_power_consumption.txt")) {
        unzip("exdata_data_household_power_consumption.zip")
}
## read the data into r, and label the "?" characters as NAs
hpc <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
## subset the data in the dates of 2007-02-01 and 2007-02-02
hpc <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007") ,]
## parse the Date colume into date format 

hpc$Date <- dmy(hpc$Date)
hpc$datetime = strptime(paste(as.Date(hpc$Date), hpc$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# step 2 plotting
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
## 1st plot
with(hpc, plot(datetime, Global_active_power, 
               type = "l",
               ylab = "Global Active Power"))
## 2nd plot
with(hpc, plot(datetime, Voltage,
               type = "l"))
## 3rd plot
with(hpc, plot(datetime, Sub_metering_1, 
               type = "l",
               col = "black",
               xlab = "",
               ylab = "Energy sub metering"))
with(hpc, lines(datetime, Sub_metering_2,
                col = "red"))
with(hpc, lines(datetime, Sub_metering_3,
                col = "blue"))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"),
       bty = "n"
)
## 4th plot
 with(hpc, plot(datetime, Global_reactive_power,
                type = "l"))
 dev.off()