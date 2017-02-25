library(data.table)

# reading file into data.table
epc <- fread("household_power_consumption.txt", na.strings = "?")

# transform and filter
epc <- epc[,Date:=as.Date(Date, format = "%d/%m/%Y")]
epc <- subset(epc, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
epc <- epc[,Time:=strptime(Time, format = "%H:%M:%S")]
date(epc$Time)<-epc$Date

# plot to png file
png("Plot3.png")
loc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")
plot(x = epc$Time, y = epc$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering"
)
lines(x = epc$Time, y = epc$Sub_metering_2, col ="red")
lines(x = epc$Time, y = epc$Sub_metering_3, col ="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))
Sys.setlocale("LC_TIME", loc)
dev.off()