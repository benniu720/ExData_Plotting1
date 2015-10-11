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
## open the png graphic device and name the file.
png(file="plot2.png")
## Plot Add vs Global_active_power and choose type "l", annotate the labels correctly. And turn off when finished.
with((add), plot(Add, Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()

