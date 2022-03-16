library(tidyverse)
library(magrittr)

#63111-0001:
#Ausstattung privater Haushalte (Laufende
#Wirtschaftsrechnungen): Deutschland, Stichtag,
#Gebrauchsgüter

#https://www-genesis.destatis.de/genesis/online


#I suspect there must be a difference between missing observations marked
#with "-" and those marked with ".", but I did not find an explanation
#therefore I am classing both cases as NA without differentiation
full_data <- read_csv2("63111-0001.csv", skip = 6, col_names = FALSE,
                       locale = locale(encoding = "latin1"), na = c("-", "."))

#remove info at the bottom, assign correct data types, transform "Erfasste Haushalte"
stripped_data <- slice(full_data, 5:23) %>% 
  mutate(X1 = as.Date(X1, format = "%d.%m.%Y")) %>% 
  mutate(across(X2:X73, ~as.numeric(sub(",", ".", .x)))) %>% 
  mutate(X3 = X3 * 1000)
  
#create list of column names
#I am integrating the unit % into the column names, but not integrating the 1000 factor
#for the column "Erfasste Haushalte" since I am transforming this column back to full size values
#align abbreviations (since we are looking at the rate of households owning a certain
#object, the object names do not contain meaningful grammatical plurals)
name_list <- c("Snapshot Date", full_data[1,2:3], paste(full_data[3,4:73], "[%]", sep = " "))
name_list <- name_list %>% 
  gsub(pattern = "Personenkraftwagen", replacement = "Pkw") %>% 
  gsub(pattern = "Krafträder", replacement = "Kraftrad")

#clean table with column names
final_table <- stripped_data %>% 
  set_colnames(name_list)

#export csv with NAs as empty to be more compatible with Tableau
write_csv(final_table, "utility_objects_private_households_clean.csv", na = "")