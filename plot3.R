#Call ggplot2 library
library(ggplot2)

#set working directory
setwd("C:/Users/Dell/Desktop/Cursos/Data_Science_course_Jopkins/Exploratory_data_analysis/Assignments")
if(!file.exists("./dataStore")){dir.create("./dataStore")}
#now get the data for the project from the url
get.data.project <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(get.data.project, destfile = "./dataStore/exdata_data_NEI_data.zip", method = "auto")

#unzip data files
unzip(zipfile = "./dataStore/exdata_data_NEI_data.zip")

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

NEIsubset <- NEI[NEI$fips=="24510", ]
total_annual_emissions_type <- aggregate(Emissions ~ year + type, NEIsubset, FUN = sum)

png("plot3.png", width = 640, height = 480)
g_plot <- ggplot(data = total_annual_emissions_type, aes(x = factor(year), y = Emissions, fill = type, colore = "black")) 
g_plot <- g_plot + geom_bar(stat = "identity") + facet_grid(. ~ type) +  xlab("Year") + ylab(expression("total PM"[2.5]*" emissions")) + ggtitle("Baltimore Emissions by Source Type")
print(g_plot)
dev.off()
