#Script for writing and creating clean data for analysis
#by Paul Alves 
#Note that this process could take a while on older computers
#Also protip don't try to run it when files are on a usb device
#It crashed my pc like 3 times when I tried it so put it on an hdd or ssd.
#Make sure you have HDD space as well as the resulting file is about 2GB

#library imports
library(tidyverse)
library(stringr)

#name of the kwh column names for later
kwh_names <- c("KWH JANUARY 2010",
               "KWH FEBRUARY 2010",
               "KWH MARCH 2010",
               "KWH APRIL 2010",
               "KWH MAY 2010",
               "KWH JUNE 2010",
               "KWH JULY 2010",
               "KWH AUGUST 2010",
               "KWH SEPTEMBER 2010",
               "KWH OCTOBER 2010",
               "KWH NOVEMBER 2010",
               "KWH DECEMBER 2010")

#name of therm columns for later
therm_names <- c("THERM JANUARY 2010",
                 "THERM FEBRUARY 2010",
                 "THERM MARCH 2010",
                 "TERM APRIL 2010", #nice typoes a++
                 "THERM MAY 2010",
                 "THERM JUNE 2010",
                 "THERM JULY 2010",
                 "THERM AUGUST 2010",
                 "THERM SEPTEMBER 2010",
                 "THERM OCTOBER 2010",
                 "THERM NOVEMBER 2010",
                 "THERM DECEMBER 2010")

#read the file
energy <- read_csv("./Energy_Usage_2010.csv") %>%
  #gather the data into a single year column and kwh / therm column
gather(key = "Month_KWH", value = "KWH", 
                  kwh_names) %>%
          gather(key = "Month_Therm", value = "Therm",
                therm_names) %>% 
  #omit NAs and remove duplicates that may have been created
          na.omit() %>%
          distinct()
#loop to replace the value names with good month names
#this is another dumb way of doing this but replace and mutate didn't work so...
for (i in 1:12) {
  #loop for each month, and replace according to the above arrays
  energy$Month_Therm[energy$Month_Therm==therm_names[i]] <- month.name[i]
  energy$Month_KWH[energy$Month_KWH==kwh_names[i]] <- month.name[i]
}
#write the file
write_csv(energy,"./Energy_Usage_2010_clean.csv")
