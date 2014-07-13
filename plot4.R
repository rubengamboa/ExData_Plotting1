## This script reads the data of household power consumption and creates a linegraph of Sub_metering_[123] timeseries
## overlayed on the same graph

## First, we read the data.  This is boilerplate code.

# Grab the data from the file.  Force arguments to be numeric, and watch for NAs (as ?) and the column separator.

pcdata.raw <- read.table(file="household_power_consumption.txt",
                         header=TRUE,
                         sep=";",
                         na.strings="?",
                         colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Subset the data by date

pcdata.subset <- pcdata.raw[which(pcdata.raw[1]=='1/2/2007' | pcdata.raw[1]=='2/2/2007'),]

# Add a DateTime column that combines Date and Time strings into an actual Date object
# Also, get rid of the original Date and Time strings

pcdata.subset <- cbind(DateTime=strptime(paste(pcdata.subset[,"Date"], pcdata.subset[,"Time"]), format="%d/%m/%Y %H:%M:%S"), 
                       pcdata.subset[,c(3,4,5,6,7,8,9)])

## Second, create the linegraph of Sub_metering_[123] timeseries
## overlayed on the same graph. This is the only code that changes

png('plot4.png')
par(mfcol=c(2,2))
with(pcdata.subset, plot(DateTime, Global_active_power, type="n",
                         col="red",
                         main="",
                         xlab="",
                         ylab="Global Active Power (kilowatts)"))
with(pcdata.subset, {
    lines(DateTime, Global_active_power)
    plot(DateTime, Sub_metering_1, type="n",
         col="red",
         main="",
         xlab="",
         ylab="Energy sub metering")
    lines(DateTime, Sub_metering_1, col="black")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright",
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=c(1,1,1),
           col=c("black", "red", "blue"))
           
    plot(DateTime, Voltage, type="n",
         col="black",
         main="",
         xlab="datetime",
         ylab="Voltage")
    lines(DateTime, Voltage)

    plot(DateTime, Global_reactive_power, type="n",
         col="black",
         main="",
         xlab="datetime",
         ylab="Global_reactive_power")
    lines(DateTime, Global_reactive_power)
})

dev.off()
