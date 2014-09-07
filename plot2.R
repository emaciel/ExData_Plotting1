
start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")
missing_values = "?"

data_graph <- read.csv("data/household_power_consumption.txt", sep=";")                # read csv file

data_graph$Time <- strptime(paste (data_graph$Date,data_graph$Time, sep = " ", collapse = NULL),"%d/%m/%Y %H:%M:%S")        # convert Time column to time

data_graph$Date <- as.Date(data_graph$Date, "%d/%m/%Y")
data_graph <- data_graph[data_graph$Date >= start_date & data_graph$Date <= end_date ,] # subset for the 2 relevant days

data_graph$Global_active_power <- as.numeric(as.character(data_graph$Global_active_power))

data_graph <- data_graph[ data_graph$Global_active_power != missing_values,]             # remove invalid ? entries

png(filename = "plot2.png", width = 480, height = 480, units = "px")   # open png file to save
par(mar=c(6,4,2,2))     # set margins
par(pch=".")            # set symbol used for plotting . (dot)
# plot line
plot(data_graph$Time, data_graph$Global_active_power, type="o", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()       # save to file and close it