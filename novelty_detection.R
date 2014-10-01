## Fix to be os and user agnostic. Certain inputs will be pulled from data file.
# setwd()

## Source all required scripts.
required.scripts <- c('api_loader.R','normal_behavior.R')
sapply(required.scripts, source, .GlobalEnv)

## Load required libraries
library(jsonlite)
library(httr)
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
