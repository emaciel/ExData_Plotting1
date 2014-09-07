
start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")
missing_values = "?"

data_graph <- read.csv("data/household_power_consumption.txt", sep=";")                # read csv file
data_graph$Time <- strptime(paste (data_graph$Date,data_graph$Time, sep = " ", collapse = NULL),"%d/%m/%Y %H:%M:%S")        # convert Time column to time

data_graph$Date <- as.Date(data_graph$Date, "%d/%m/%Y")         # convert Date column to date
data_graph <- data_graph[data_graph$Date >= start_date & data_graph$Date <= end_date ,] # subset for the 2 relevant days

data_graph <- data_graph[data_graph$Sub_metering_1 != missing_values,]             # remove invalid ? entries
data_graph <- data_graph[ data_graph$Sub_metering_2 != missing_values,]             # remove invalid ? entries
data_graph <- data_graph[ data_graph$Sub_metering_3 != missing_values,]             # remove invalid ? entries

data_graph$Sub_metering_1<-as.numeric(as.character(data_graph$Sub_metering_1))
data_graph$Sub_metering_2<-as.numeric(as.character(data_graph$Sub_metering_2))
data_graph$Sub_metering_3<-as.numeric(as.character(data_graph$Sub_metering_3))

png(filename = "plot3.png", width = 480, height = 480, units = "px")   # open png file to save
par(mar=c(6,4,2,2))     # set margins
par(pch=".")            # set symbol used for plotting . (dot)

# plot lines
plot(data_graph$Time, data_graph$Sub_metering_1, type="o", xlab="",ylab="Energy sub metering")
lines(data_graph$Time, data_graph$Sub_metering_2, type="o", col="red")
lines(data_graph$Time, data_graph$Sub_metering_3, type="o", col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off()       # save to file and close it