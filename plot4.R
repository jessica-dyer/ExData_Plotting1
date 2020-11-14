source("data_loading.R")
png("plot4.png")

par(mfrow = c(2,2))
#par(mar = c(2,0,2,0))
par(pty = "m")
plot1 <- plot(filtered_df$date_object, filtered_df$Global_active_power,  
                       type = "l",
                       ylab = "Global Active Power (kilowatts)",
                       xlab = " ", 
                       lty = 1, lwd = 1) 

plot2 <- plot(filtered_df$date_object, filtered_df$Voltage, type = "l", 
              xlab = "", ylab = "Voltage",  lty = 1, lwd = 1, pch=16)

plot3 <- plot(filtered_df$date_object, filtered_df$Sub_metering_1, type = "l",
                 xlab = " ", ylab = "Energy sub metering",  lty = 1, lwd = 1)

# Add a second & third line
lines(filtered_df$date_object, filtered_df$Sub_metering_2, col = "red", type = "l")
lines(filtered_df$date_object, filtered_df$Sub_metering_3, col = "blue", type = "l")


# Add a legend to the plot and set legend lty
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col = c("black", "red", "blue"), lty = 1)

plot4 <-  plot(filtered_df$date_object, filtered_df$Global_reactive_power, 
               xlab = "", ylab = "Global Reactive Power",  lty = 1, lwd = 1, type = "l")

dev.off()
