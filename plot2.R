# Load Household Energy Consumption dataset 
# Calculate memory requirements 
# 2,075,259 x 9 x 8 bytes/numeric = 142.5MB 

# Load & Test rows   
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))

hec <- read.csv("sources/household_power_consumption.txt", 
                  header=T, 
                  sep=";", 
                  na.strings="?", 
                  colClasses=c("Date" = "myDate"), 
                  stringsAsFactors=F)

# Check results 
summary(hec)

# Select rows by dates
# xhec results is 2880 objects of 9 variables 

xhec <- subset(hec, Date >= "2007-02-01" & Date <= "2007-02-02")

# Merge Date & Time 
apt <-strptime(paste(xhec$Date, xhec$Time), format="%Y-%m-%d %H:%M:%S")

# Check class object 
class(apt)

# Open file device
png(file="outputs/plot2.png")

# Set transparent background for image
par(bg="transparent")

# Create plot
plot(apt, xhec$Global_active_power, 
     type ='l',
     xlab = " ",
     ylab = "Global Active Power (kilowatts)")

# Close device
dev.off() 

# Remove all objects from memory
rm(list=ls()) 

