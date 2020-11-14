# Source "data loading" to load data. If data is already loaded, it will use the cache. 

source("data_loading.R")


png("plot1.png", width = 480, height = 480)
par(pty = "s")
filtered_df$Global_active_power <- as.numeric(filtered_df$Global_active_power)

plot1 <- hist(filtered_df$Global_active_power,main="Global Active Power", 
              xlab="Global Active Power (kilowatts)", col = "red") 

dev.off()