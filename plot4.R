source("data_loading.R")
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
par(mar = c(1,2,2,0))
par(pty = "m")
plot1 <- source("plot2.R")

plot2 <- plot(filtered_df$date_object, filtered_df$Voltage, type = "l", 
              xlab = "", ylab = "Voltage",  lty = 1, lwd = 1, pch=16)

plot3 <- source("plot3.R")

plot4 <-  plot(filtered_df$date_object, filtered_df$Global_reactive_power, 
               xlab = "", ylab = "Global Reactive Power",  lty = 1, lwd = 1, type = "l")

dev.off()
