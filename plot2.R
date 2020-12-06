
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

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

NEIsubset <- NEI[NEI$fips=="24510", ]

total_annual_emissions_Balt <- aggregate(Emissions ~ year, NEIsubset, FUN = sum)

#create png file
png("plot2.png")
plot2 <- barplot(height = total_annual_emissions_Balt$Emissions/1000, names.arg = total_annual_emissions_Balt$year, xlab = "years", ylab = expression("total PM"[2.5]*" emission"), main = expression("Total PM"[2.5]*" emissions in Baltimore in time"), col= 2:(length(total_annual_emissions_Balt$year)+1))
dev.off()
print()