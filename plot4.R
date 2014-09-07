start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")
missing_values = "?"

data_graph <- read.csv("data/household_power_consumption.txt", sep=";")                # read csv file
data_graph$Time <- strptime(paste (data_graph$Date,data_graph$Time, sep = " ", collapse = NULL),"%d/%m/%Y %H:%M:%S")        # convert Time column to time

data_graph$Date <- as.Date(data_graph$Date, "%d/%m/%Y")         # convert Date column to date
data_graph <- data_graph[data_graph$Date >= start_date & data_graph$Date <= end_date ,] # subset for the 2 relevant days

# convert all values relevant to the plots to numeric values from factors
data_graph$Global_active_power <- as.numeric(as.character(data_graph$Global_active_power))
data_graph$Voltage <- as.numeric(as.character(data_graph$Voltage))
data_graph$Sub_metering_1<-as.numeric(as.character(data_graph$Sub_metering_1))
data_graph$Sub_metering_2<-as.numeric(as.character(data_graph$Sub_metering_2))
data_graph$Sub_metering_3<-as.numeric(as.character(data_graph$Sub_metering_3))
data_graph$Global_reactive_power <- as.numeric(as.character(data_graph$Global_reactive_power))


data_graph <- data_graph[data_graph$Global_active_power != missing_values,]        # remove invalid ? entries
data_graph <- data_graph[data_graph$Sub_metering_1 != missing_values,]             # remove invalid ? entries
data_graph <- data_graph[data_graph$Sub_metering_2 != missing_values,]             # remove invalid ? entries
data_graph <- data_graph[data_graph$Sub_metering_3 != missing_values,]             # remove invalid ? entries
data_graph <- data_graph[data_graph$Global_reactive_power != missing_values,]      # remove invalid ? entries
data_graph <- data_graph[data_graph$Voltage != missing_values,]                    # remove invalid ? entries


png(filename = "plot4.png", width = 480, height = 480, units = "px")    # open png file to save 
par(mar=c(6,4,2,2))             # set margins
par(pch=".",mfrow=c(2,2))       # set 4 plots in the same graphic device
                                # set symbol used for plotting . (dot)

# plot first chart
plot(data_graph$Time, data_graph$Global_active_power, type="o", xlab="",ylab="Global Active Power")
# plot second chart
plot(data_graph$Time, data_graph$Voltage, type="o", xlab="datetime",ylab="Voltage")
# plot third chart
plot(data_graph$Time, data_graph$Sub_metering_1, type="o", xlab="",ylab="Energy sub metering")
lines(data_graph$Time, data_graph$Sub_metering_2, type="o", col="red")
lines(data_graph$Time, data_graph$Sub_metering_3, type="o", col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),bty = "n")
# plot fourth chart
plot(data_graph$Time, data_graph$Global_reactive_power, type="o", xlab="datetime",ylab="Global_reactive_power")

dev.off()       # save to file and close it