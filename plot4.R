power_consum <- read.table("household_power_consumption.txt",skip=1,sep=";")

names(power_consum) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                         "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

subset_power_consum <- subset(power_consum,power_consum$Date=="1/2/2007" | power_consum$Date =="2/2/2007")

subset_power_consum$Date <- as.Date(subset_power_consum$Date, format="%d/%m/%Y")
subset_power_consum$Time <- strptime(subset_power_consum$Time, format="%H:%M:%S")
subset_power_consum[1:1440,"Time"] <- format(subset_power_consum[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_power_consum[1441:2880,"Time"] <- format(subset_power_consum[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

png ( "plot4.png" , width = 480 , height = 480 )

par(mfrow=c(2,2))

with(subset_power_consum,{
  plot(subset_power_consum$Time,as.numeric(as.character(subset_power_consum$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subset_power_consum$Time,as.numeric(as.character(subset_power_consum$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subset_power_consum$Time,subset_power_consum$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subset_power_consum,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subset_power_consum,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subset_power_consum,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subset_power_consum$Time,as.numeric(as.character(subset_power_consum$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()