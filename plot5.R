#Call ggplot2 library
library(ggplot2)
library(dplyr)
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


NEIsubset <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
baltimore_emissions <- summarise(group_by(NEIsubset, year), Emissions = sum(Emissions))

#create the png file
png("plot5.png")
mv_plot <- ggplot(baltimore_emissions, aes(x = factor(year), y = round(Emissions/1000, 2), fill = year, label = round(Emissions/1000, 2))) +
  geom_bar(stat = "identity") + xlab("Year") + ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore") + 
  geom_label(aes(fill = year), color = "white", fontface = "bold")

print(mv_plot)
dev.off()
  
 
