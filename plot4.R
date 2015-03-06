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

# Select rows by dates
# xhec results is 2880 objects of 9 variables 
xhec <- subset(hec, Date >= "2007-02-01" & Date <= "2007-02-02")

# Merge Date & Time 
apt <-strptime(paste(xhec$Date, xhec$Time), format="%Y-%m-%d %H:%M:%S")

# Check class object 
class(apt)

# Open file device
png(file="outputs/plot4.png")

# =========== Create Main Grid for Dashboard ================

# Set transparent background for image
par(bg="transparent")

# Create 2 x 2 grid
par(mfrow = c(2, 2))

# Change margins
#par(mar = c(1,1,1,1))

# =========== Add Plot 2 ====================================

plot(apt, xhec$Global_active_power, 
     type ='l',
     xlab = " ",
     ylab = "Global Active Power")

# =========== Add New Plot Voltage ===========================

plot(apt, xhec$Voltage, 
     type ='l',
     xlab = "datetime",
     ylab = "Voltage")

# =========== Add Plot 3 =====================================

# Create plot
plot(apt, xhec$Sub_metering_1, 
     type ='l',
     xlab = " ",
     ylab = "Energy sub meetering")

# Add additional meters values for meter 2 & 3
lines(apt, xhec$Sub_metering_2, type="l", col="red")
lines(apt, xhec$Sub_metering_3, type="l", col="blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
       lty = 1,
       bty = "n",
       merge = TRUE)

# =========== Add New Plot Global Reactive Power ==============

plot(apt, xhec$Global_reactive_power, 
     type ='l',
     xlab = "datetime",
     ylab = "Global_reactive_power")

#===============================================================

# Close device
dev.off() 

# Remove all objects from memory
# rm(list=ls()) 

