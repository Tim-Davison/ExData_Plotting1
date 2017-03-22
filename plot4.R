
## Plot #4
## read in data from text file

library(readr)
d <- read_csv2("household_power_consumption.txt", 
               na = "?",
               col_names= TRUE, 
               col_types = "ccnnnnnnn",
               n_max= 69600)

datetime <- as.POSIXct(paste(d$Date, d$Time), 
                       format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
data <- cbind(datetime, d)

## to remove the old date and time columns
library(dplyr)
data2 <- select(data, datetime, Global_active_power:Sub_metering_3)

## to filter between appropriate dates
t1 <- as.POSIXct("2007-02-01 00:00:00", tz = "GMT")
t2 <- as.POSIXct("2007-02-02 23:59:00", tz = "GMT")

data3 <- data2[data2$datetime %in% t1:t2, ]

## setup parameters of plots
## plot #1 Global Active Power

png(filename = "plot4.png", width = 480, height= 480)

par(mfcol=c(2,2))
with(data3, {
  plot(datetime, Global_active_power, 
                 type = "l",
                 ylab = "Global Active Power", 
                 xlab = "")
  
{plot(datetime, Sub_metering_1, 
     type = "l",
     lwd=1,
     col="black",
     xlab= "",
     ylab= "Energy sub metering")

lines(datetime, Sub_metering_2, 
      type = "l",
      lwd=1,
      col="red",
      ylab = "", 
      xlab = "")

lines(datetime, Sub_metering_3, 
      type = "l",
      lwd=1,
      col="blue",
      ylab = "", 
      xlab = "")

legend("topright", pch= "-", col= c("black", "red", "blue"),
       legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}

plot(datetime, Voltage, 
     type = "l",
     ylab = "Voltage", 
     xlab = "datetime")

plot(datetime, Global_reactive_power, 
     type = "l",
     ylab = "Global Reactive Power", 
     xlab = "datetime")
})
dev.off()