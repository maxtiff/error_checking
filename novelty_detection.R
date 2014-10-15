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
library(robfilter)


### Begin analysis ...

## Collect time series data and standardize into z-score.
series <- 'dgorder'
object <- get.JSON(series)
data <- get.data(object)

## Collect vintages and metadata
vintage <- get.vintage(series)
metadata <- get.metadata(series)

## Detect outliers by creating statistics that sufficiently describe the normal behavior of the system. This is process is completed over sliding windows of 10 observations.
test <- observation.windows(data$value)


## Forecast testing below
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
# ft <- forecast(as.ts(test.data$value))
# plot(ft)

## Adaptive Robust Moving Median testing
# test.filter <- adore.filter(as.ts(test.data$value),min.width = 5,max.width = 10,rtr=1)
# plot(test.filter)