power_consum <- read.table("household_power_consumption.txt",skip=1,sep=";")

names(power_consum) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                         "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

subset_power_consum <- subset(power_consum,power_consum$Date=="1/2/2007" | power_consum$Date =="2/2/2007")

subset_power_consum$Date <- as.Date(subset_power_consum$Date, format="%d/%m/%Y")
subset_power_consum$Time <- strptime(subset_power_consum$Time, format="%H:%M:%S")
subset_power_consum[1:1440,"Time"] <- format(subset_power_consum[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_power_consum[1441:2880,"Time"] <- format(subset_power_consum[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

png ( "plot2.png" , width = 480 , height = 480 )

plot(subset_power_consum$Time,as.numeric(as.character(subset_power_consum$Global_active_power)),type="l",xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()