## get the dplyr package for later use.
library(dplyr) 
## read the file into R, set the stringsAsFactors to FALSE so that the numbers from Global_active_power column would not be "factors", which are unable to plot in hist() function.
file<- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
## Change the first column "Date" to date class, and obtain only the rows with the date in between 2007-02-01 and 2007-02-02.
file_mutate<- mutate(file, Date=as.Date(Date, "%d/%m/%Y"))
two_day<-filter(file_mutate, Date>="2007-02-01" & Date<="2007-02-02")
## Add a new column named "Add", which is basically pasting the "Date" and "Time" column together with a space as separator.
add<-mutate(two_day, Add=paste(Date,Time,sep=" "))
## The "Add" column allows the use of strptime() to generate the POSIXlt date format. 
add$Add<-strptime(add$Add, format="%Y-%m-%d %H:%M:%S")
## Open the png graphic device
png(file="Plot3.png")
## Plot the three curves onto the same graph, and annotate them correctly.
with((add),plot(Add, Sub_metering_1, type="l", xlab="",ylab="Energy sub metering"))
with((add),lines(Add, Sub_metering_2,col="red"))
with((add), lines(Add, Sub_metering_3,col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))
## turn off the device after use.
dev.off()
