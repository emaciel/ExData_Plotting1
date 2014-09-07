
start_date = as.Date("2007-02-01")
end_date = as.Date("2007-02-02")
missing_values = "?"

data_graph <- read.csv("data/household_power_consumption.txt", sep=";")                # read csv file
data_graph$Date <- as.Date(data_graph$Date, "%d/%m/%Y")         # convert Date column to date

data_graph <- data_graph[data_graph$Date >= start_date & data_graph$Date <= end_date ,] # subset for the 2 relevant days

data_graph$Global_active_power <- as.numeric(as.character(data_graph$Global_active_power))

data_graph <- data_graph[ data_graph$Global_active_power != missing_values,]             # remove invalid ? entries

png(filename = "plot1.png", width = 480, height = 480, units = "px")   # open png file to save
par(mar=c(6,4,2,2))     # set margins

# plot histogram
hist(data_graph$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")
dev.off()       # save to file and close it

