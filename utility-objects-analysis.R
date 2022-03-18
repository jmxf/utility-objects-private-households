library(tidyverse)

utility_objects <- read_csv("utility_objects_private_households_clean.csv")

###Data Availability Stats

na_summary <- utility_objects[4:73] %>% 
  summarise(across(everything(), list(na_count = ~sum(is.na(.x)))))

#average number of data points available per category
avg_data_points <- sum(!is.na(utility_objects[4:73])) / 70
med_data_points <- median(colSums(!is.na(utility_objects[4:73])))
  
#number of categories with data for all years collected
complete_categories <-

overview <- describe