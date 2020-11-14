source("data_loading.R")
png("plot2.png", width = 480, height = 480)

par(pty = "s")
plot2 <- plot(filtered_df$date_object, filtered_df$Global_active_power,  
              type = "l",
              ylab = "Global Active Power (kilowatts)",
              xlab = " ", 
              lty = 1, lwd = 1) 
dev.off()          
              