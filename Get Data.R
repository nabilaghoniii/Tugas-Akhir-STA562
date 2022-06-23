library(httr)
library(dplyr)
library(mongolite)

# GET DATA
jkt <- GET('https://api.open-meteo.com/v1/forecast?latitude=-6.1862&longitude=106.8063&current_weather=TRUE&timezone=Asia%2FBangkok')
data_jkt <- content(jkt, "parsed")
jkt_time <- data_jkt$current_weather$time
jkt_temp <- data_jkt$current_weather$temperature
jkt_speed <- data_jkt$current_weather$windspeed

sydney <- GET('https://api.open-meteo.com/v1/forecast?latitude=-33.865143&longitude=151.209900&current_weather=TRUE&timezone=Australia%2FSydney')
data_sydney <- content(sydney, "parsed")
sydney_time <- data_sydney$current_weather$time
sydney_temp <- data_sydney$current_weather$temperature
sydney_speed <- data_sydney$current_weather$windspeed

ny <- GET('https://api.open-meteo.com/v1/forecast?latitude=40.71&longitude=-74.01&current_weather=TRUE&timezone=America%2FNew_York')
data_ny <- content(ny, "parsed")
ny_time <- data_ny$current_weather$time
ny_temp <- data_ny$current_weather$temperature
ny_speed <- data_ny$current_weather$windspeed

london <- GET('https://api.open-meteo.com/v1/forecast?latitude=51.5002&longitude=-0.1262&current_weather=TRUE&timezone=Europe%2FLondon')
data_london <- content(london, "parsed")
london_time <- data_london$current_weather$time
london_temp <- data_london$current_weather$temperature
london_speed <- data_london$current_weather$windspeed

cairo <- GET('https://api.open-meteo.com/v1/forecast?latitude=30.0571&longitude=31.2272&current_weather=TRUE&timezone=Africa%2FCairo')
data_cairo <- content(cairo, "parsed")
cairo_time <- data_cairo$current_weather$time
cairo_temp <- data_cairo$current_weather$temperature
cairo_speed <- data_cairo$current_weather$windspeed

wellington <- GET('https://api.open-meteo.com/v1/forecast?latitude=-41.2865&longitude=174.7762&current_weather=TRUE&timezone=Pacific%2FAuckland')
data_wellington <- content(wellington, "parsed")
wellington_time <- data_wellington$current_weather$time
wellington_temp <- data_wellington$current_weather$temperature
wellington_speed <- data_wellington$current_weather$windspeed

city <- c("Jakarta","Sydney","New York","London","Cairo","Wellington")
time <- c(jkt_time,sydney_time,ny_time,london_time,cairo_time,wellington_time)
temp <- c(jkt_temp,sydney_temp,ny_temp,london_temp,cairo_temp,wellington_temp)
speed <- c(jkt_speed,sydney_speed,ny_speed,london_speed,cairo_speed,wellington_speed)
weather <-  data.frame(city, time,temp, speed)
names(weather) <-c("city","time","temperature","wind_speed")
weather <- weather %>% mutate(
  time = as.character(substr(time, nchar(time)-5+1, nchar(time))))


# INSERT DATA
connection_string <- 'mongodb+srv://nabilaghoni:shiefila@cluster0.vvsc3.mongodb.net/sample_training'

random_collection <- mongo(collection = "weather", 
                           db = "sample_dataset_R", 
                           url = connection_string, 
                           verbose = TRUE)
random_collection$insert(weather)


