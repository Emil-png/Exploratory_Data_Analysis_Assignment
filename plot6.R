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
#subset for Baltimore & Los Angeles "on road" vehicles
#summarise() creates a new data frame. It will have one (or more) rows for each combination of grouping variables
balt_emissions <- summarise(group_by(filter(NEI, fips == "24510" & type == "ON-ROAD"), year), Emissions = sum(Emissions))
LA_emissions <- summarise(group_by(filter(NEI, fips == "06037" & type == "ON-ROAD"), year), Emissions = sum(Emissions))

#merge the new subsets into one 
balt_emissions$County <- "Baltimore, MD"
LA_emissions$County <- "Los Angeles, CA"
both <- rbind(balt_emissions, LA_emissions)

png("plot6.png")
Balt_LA_plot <- ggplot(both, aes(x = factor(year), y = Emissions, fill = County, label = round(Emissions, 2))) + 
  geom_bar(stat = "identity") + 
  facet_grid(County ~ ., scales = "free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + xlab("Year") + 
  ggtitle(expression("Motor vehicle emissions in Baltimore and Los Angeles in time")) +
  geom_label(aes(fill = County), color = "white", fontface = "bold")

print(Balt_LA_plot)
dev.off()
