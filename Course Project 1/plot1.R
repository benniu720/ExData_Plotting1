## get the dplyr package for later use.
library(dplyr) 
## read the file into R, set the stringsAsFactors to FALSE so that the numbers from Global_active_power column would not be "factors", which are unable to plot in hist() function.
file<- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
## Change the first column "Date" to date class, and obtain only the rows with the date in between 2007-02-01 and 2007-02-02.
file_mutate<- mutate(file, Date=as.Date(Date, "%d/%m/%Y"))
two_day<-filter(file_mutate, Date>="2007-02-01" & Date<="2007-02-02")

## open the png graphic device, plot the histogram and annotate accordingly. Turn off when finish.
png(file="plot1.png")
hist(as.numeric(two_day$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()
