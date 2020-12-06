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

# merge both datasets
NEISCC <- merge(NEI, SCC, by = "SCC")
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
coal <- grepl("coal", NEISCC$Short.Name, ignore.case = TRUE )
NEISCCsubset <- NEISCC[coal, ]

total_annual_emissions_coal <- aggregate(Emissions ~ year, NEISCCsubset, FUN = sum)

png("plot4.png")
g_plot <- ggplot(data = total_annual_emissions_coal, aes(x = factor(year), y = round(Emissions/1000,2), label = round(Emissions/1000,2), fill = year)) +
  geom_bar(stat = "identity") + ylab(expression("PM"[2.5]*" emissions in Kilotons")) + xlab("Year") +
  geom_label(aes(fill = year), color = "white", fontface = "bold")
  ggtitle("Coal Combustion Emissions from 1999 to 2008.")
print(g_plot)
dev.off()