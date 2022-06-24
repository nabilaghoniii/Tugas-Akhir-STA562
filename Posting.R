library(rtweet)
library(mongolite)

connection_string <- Sys.getenv("MONGODB_URI")
random_collection <- mongo(collection = "weather", 
                           db = "sample_dataset_R", 
                           url = connection_string, 
                           verbose = TRUE)

# POST TWITTER
upload <- random_collection$find(sort='{"_id":-1}', limit=6)
hashtag <- Sys.Date()

post1 <- paste0(
  "Hello, good people. How's your day? Its time to take a look at today's weather! As we normally do, we would like to inform you current weather in few cities all around the world. Hang on a second..", 
  "\n",
  "\n",
  "#", hashtag
)

post2 <- paste0(
  upload$city[[6]], " (", upload$time[[6]], ") 🌡️", upload$temperature[[6]], "°C  💨 ", upload$wind_speed[[6]], " km/h", "\n",
  upload$city[[5]], " (", upload$time[[5]], ") 🌡", upload$temperature[[5]], "°C  💨 ", upload$wind_speed[[5]], " km/h", "\n",
  upload$city[[4]], " (", upload$time[[4]], ") 🌡", upload$temperature[[4]], "°C  💨 ", upload$wind_speed[[4]], " km/h", "\n",
  upload$city[[3]], " (", upload$time[[3]], ") 🌡", upload$temperature[[3]], "°C  💨 ", upload$wind_speed[[3]], " km/h", "\n",
  upload$city[[2]], " (", upload$time[[2]], ") 🌡", upload$temperature[[2]], "°C  💨 ", upload$wind_speed[[2]], " km/h", "\n",
  upload$city[[1]], " (", upload$time[[1]], ") 🌡", upload$temperature[[1]], "°C  💨 ", upload$wind_speed[[1]], " km/h", "\n",
  "\n",
  "\n",
  "#", hashtag
)

twitter_token <- rtweet::create_token(
  app = "jualrumahbgr",
  consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"), 
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

rtweet::post_tweet(
  status = post1,
  token = twitter_token
)

rtweet::post_tweet(
  status = post2,
  token = twitter_token
)
