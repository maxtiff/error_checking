## Fix to be os and user agnostic. Certain inputs will be pulled from data file.
# setwd()

## Source all required scripts.
required.scripts <- c('api_loader.R','normal_behavior.R')
sapply(required.scripts, source, .GlobalEnv)

## Load required libraries
library(jsonlite)
library(httr)
library(forecast)
library(ggplot2)


### Begin analysis ...

## Collect time series data that sufficiently exhibits the normal behavior of the system.
# Data is standardized into z-score.
series <- 'DGORDER'
object <- get.JSON(series)
data <- get.data(object)
metadata <- get.metadata(series)

## Create non-overlapping windows.
# Need to break into windows around observations that are revised or new.
# freq <- determine.freq(metadata)
# test <- tail(data$value, n= 12)

## Detect outliers (modify to detect outliers in windows).
score <- detect.outliers(data$value)

## Pull out windows with positive outlier scores.
if (sum(score) > 0) {
  print(sum(score))
} else if (sum(score) == 0) {
  # continue
} else {
  print("Something has gone wrong")
  exit()
}

# For tests: Visualize series
# ggplot(data=data, aes(x=date,y=value)) +
#   geom_line(colour="blue", size=.6) +
#   geom_point(colour="black", size=4, shape=21, fill="white")


## Forecast testing
# test.object <- fromJSON('http://api.stlouisfed.org/fred/series/observations?api_key=76bb1186e704598b725af0a27159fdfc&file_type=json&units=lin&vintage_dates=2014-08-26&series_id=DGORDER')
# test.data <- data.frame(test.object$observations)
# View(test.data)
# get.data(test.data)
# drops <- c("realtime_start","realtime_end")
# test.data <- test.data[,!(names(test.data) %in% drops)]
# test.data$date <- strptime(test.data$date, format="%Y-%m-%d")
# test.data$value <- as.numeric(test.data$value)
# test.data <- na.omit(test.data)
# test.data$value <- scale(test.data$value)
# View(test.data)
# test.data <-head(test.data, n=-1)
# test.score <- detect.outliers(test.data$value)
# forecast(as.ts(test.data$value))
