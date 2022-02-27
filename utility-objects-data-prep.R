library(tidyverse)

#63111-0001:
#Ausstattung privater Haushalte (Laufende
#Wirtschaftsrechnungen): Deutschland, Stichtag,
#Gebrauchsgüter

#https://www-genesis.destatis.de/genesis/online?operation=previous&levelindex=2&levelid=1645826798909&levelid=1645826287561&step=1#abreadcrumb


#I suspect there must be a difference between missing observations marked
#with "-" and those marked with ".", but I did not find an explanation
#therefore I am classing both cases as NA without differentiation
haushalte <- read_csv2("63111-0001.csv", skip = 6, col_names = FALSE,
                       locale = locale(encoding = "latin1"), na = c("-", "."))

#remove info at the bottom
plain_data <- slice(haushalte, 5:23) %>% 
  X1 <- as.Date(plain_data$X1, format = "%d.%m.%Y")
  

#create list of column names
#I am integrating the unit % into the column names, but not integrating the 1000 factor
#for the column "Erfasste Haushalte" since I am transforming this column back to full size values
full_names <- c("Snapshot Date", haushalte[1,2:3], paste(haushalte[3,4:73], "[%]", sep = " "))


parse_date(plain_data[1], format = "%d.%m.%Y")
plain_data

is.character(plain_data$X1)
typeof(plain_data[1])

sapply(plain_data, class)
