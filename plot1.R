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
#show NEI data
head(NEI)
#show SCC data
head(SCC)

#Question 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#use aggregate to split data into subsets and compute summary statistics
total_annual_emissions <- aggregate(Emissions ~ year, NEI, FUN = sum)

#create the png file
png('plot1.png')
barplot(height = total_annual_emissions$Emissions/1000, names.arg = total_annual_emissions$year, xlab = "years", ylab = expression('total PM'[2.5]*'emission'), main = expression('total PM' [2.5]* 'emissions by year'), col = 2:(length(total_annual_emissions$year))+1)
dev.off()