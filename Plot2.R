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

# line plot to png file
png("Plot2.png")
loc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")
with(epc, 
     plot(x = datetime, y = Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
     )
)
Sys.setlocale("LC_TIME", loc)
dev.off()