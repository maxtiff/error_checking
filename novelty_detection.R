## Fix to be os and user agnostic. Certain inputs will be pulled from data file.
# setwd()

## Source all required scripts.
required.scripts <- c('api_loader.R','normal_behavior.R')
sapply(required.scripts, source, .GlobalEnv)

## Load required libraries
library(jsonlite)
library(httr)
# library(ggplot2)


## Begin analysis ... 

# Collect time series data that sufficiently exhibits the normal behavior of the system.
# Data is standardized into z-score.
series <- 'DGORDER'
object <- get.JSON(series)
data <- get.data(object)
metadata <- get.metadata(series)

# Create non-overlapping windows.
  # Need to break into windows around observations that are revised.
  # freq <- determine.freq(metadata)
  # test <- create.windows(data, freq)

# Detect outliers.
test <- detect.outliers(data$value)
