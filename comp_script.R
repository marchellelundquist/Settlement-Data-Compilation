# Install and load packages
install.packages("readr")
install.packages("stringr")
install.packages("dplyr)
install.packages("ggplot2")
install.packages("readxl")
library(readr)
library(stringr)
library(dplyr)
library(ggplot2)
library(readxl)

# Compile, clean, and standardize data from three settlement spreadsheets into a single CSV file

# set working directory to folder containing the settlements spreadsheets from BCR, WHO, and UNICEF
setwd("~/Desktop/Settlement Spreadsheets")

# store file names in a dataframe
data.files = list.files()

# create a dataframe to hold the settlement information
settlements <- data.frame(matrix(ncol = 5, nrow = 0))   # create dataframe to store settlements compiled from layers
columns <- c("Nom", "Province", "Lat", "Long", "Source")   # list desired column names
colnames(settlements) <- columns  # set column names

# loop through each file and add settlements to the full settlements spreadsheet
for(file in data.files){
  # print(file)
  currentFile <- read_excel(file)
  
  # create dataframe to hold the name, province, latitude and longitude of the settlement, and the data source
  currentFile <- currentFile %>%
    select(Nom = 'Nom', 
           Province = 'Province',
           Lat = 'Lat',
           Long = 'Long',
           Source = 'Source')%>%
    select(Nom, Province, Lat, Long, Source)%>%
    filter(Nom != '')   # filter out empty records
  settlements <- rbind(settlements, currentFile)  # add settlements from the current file to the main dataframe
}

# write the complete settlement dataframe to a CSV
write.csv(settlements, file = "Settlements_Compiled.csv")
