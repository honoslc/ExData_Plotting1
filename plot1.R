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

# Open file device
png(file="outputs/plot1.png")

# Set transparent background for image
par(bg="transparent")

# Create plot
hist(xhec$Global_active_power, 
     col ="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close device
dev.off() 

# Remove all objects from memory
# rm(list=ls()) 

