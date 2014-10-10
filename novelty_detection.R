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


#### Begin analysis ...

### Collect time series data that sufficiently exhibits the normal behavior of the system.
## Data is standardized into z-score.
series <- 'frblmci'
object <- get.JSON(series)
data <- get.data(object)
vintage <- get.vintage(series)
metadata <- get.metadata(series)

### Detect outliers (modify to detect outliers in windows).
score <- detect.outliers(data$value)

### Create non-overlapping windows.
## Count how many obs total, and handle obs remaining.
series.length <- length(data$value)
remaining.obs <- series.length

## Establish number of windows over span of time series.
## 10 is chosen to prevent errors surrounding degrees of freedom.
window.size <- 10
complete.windows <- floor(series.length/window.size)
remainder <- series.length%%window.size
slider <- 9

## Counter variables for window coordinates in list (this is bad practice).
n <- 1

## Check if new data is identical to previous vintage up to the last observation.
if (identical(tail(data$value, n=-1),vintage$value)) {

  score <- detect.outliers(tail(data$value, n = 10)

} else {

  ## Sequence along windows of time series.
  # Adjust to prevent subscript out of bounds.
  for (i in seq_along(data$value)) {

    print(i)

    score <- detect.outliers(data$value[n:(n+window.size-1),])
    print(score)

    n <- n + slider
    remaining.obs <- remaining.obs - window.size

  }

}

# For tests: Visualize series
# ggplot(data=data, aes(x=date,y=value)) +
#   geom_line(colour="blue", size=.6) +
#   geom_point(colour="black", size=4, shape=21, fill="white")


## Forecast testing
# test.object <- fromJSON('http://api.stlouisfed.org/fred/series/observations?api_key=76bb1186e704598b725af0a27159fdfc//
#                &file_type=json&units=lin&vintage_dates=2014-08-26&series_id=DGORDER')
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