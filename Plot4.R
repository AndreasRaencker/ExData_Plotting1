library(data.table)

# reading file into data.table
epc <- fread("household_power_consumption.txt", na.strings = "?")

# transform and filter
epc <- epc[, Date := as.Date(Date, format = "%d/%m/%Y")]
epc <- subset(epc, 
              Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
epc <- epc[, Time := as.POSIXct(Time, format = "%H:%M:%S")]
date(epc$Time) <- epc$Date
names(epc)[2] <- "datetime"

# plot to png file
png("Plot4.png")
loc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

par(mfcol = c(2,2))

with(epc, {
    plot(x = datetime, y = Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power"
    )
    
    plot(x = datetime, y = Sub_metering_1,
         type = "l",
         col = "black",
         xlab = "",
         ylab = "Energy sub metering"
    )
    lines(x = datetime, y = Sub_metering_2, col ="red")
    lines(x = datetime, y = Sub_metering_3, col ="blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = 1,
           col = c("black", "red", "blue"),
           bty = "n"
    )
    
    plot(x = datetime, y = Voltage, type = "l")
    
    plot(x = datetime, y = Global_reactive_power, type = "l")
})

Sys.setlocale("LC_TIME", loc)
dev.off()