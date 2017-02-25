library(data.table)

# reading file into data.table
epc <- fread("household_power_consumption.txt", na.strings = "?")

# transform and filter
epc <- epc[,Date:=as.Date(Date, format = "%d/%m/%Y")]
epc <- subset(epc, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
# epc <- epc[,Time:=strptime(Time, format = "%H:%M:%S")]
# date(epc$Time)<-epc$Date

# histogram plot to png file
png("Plot1.png")
hist(epc$Global_active_power, 
    col = "red",
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)"
)
dev.off()