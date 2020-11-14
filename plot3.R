# Source "data loading" to load data. If data is already loaded, it will use the global environment.  
source("data_loading.R")

filtered_df$Sub_metering_1 <- as.numeric(filtered_df$Sub_metering_1)
filtered_df$Sub_metering_2 <- as.numeric(filtered_df$Sub_metering_2)
filtered_df$Sub_metering_3 <- as.numeric(filtered_df$Sub_metering_3)

png("plot3.png", width = 480, height = 480)
# Plot first line
plot3 <- plot(filtered_df$date_object, filtered_df$Sub_metering_1, type = "l",
     xlab = " ", ylab = "Energy sub metering",  lty = 1, lwd = 1)

# Add a second & third line
lines(filtered_df$date_object, filtered_df$Sub_metering_2, col = "red", type = "l")
lines(filtered_df$date_object, filtered_df$Sub_metering_3, col = "blue", type = "l")


# Add a legend to the plot and set legend lty
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()