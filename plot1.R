## This script reads the data of household power consumption and creates a histogram of Global Active Power in kilowatts

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

## Second, create the histogram of Global Active Power in kilowatts. This is the only code that changes

png('plot1.png')
with(pcdata.subset, hist(Global_active_power, 
                         col="red",
                         main="Global Active Power",
                         xlab="Global Active Power (kilowatts)",
                         ylab="Frequency"))
dev.off()
