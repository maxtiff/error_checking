## Fix to be os and user agnostic. Certain inputs will be pulled from data file.
# setwd()

## Source all required scripts.
required.scripts <- c('api_loader.R', 'normal_behavior.R')
sapply(required.scripts, source, .GlobalEnv)

## Load required libraries
library(jsonlite)
library(ggplot2)
## Begin analysis ... 

# Collect time series data that sufficiently exhibits the normal behavior of the system.
series <- 'DGORDER'
object <- get.JSON(series)
data <- get.data(object)
metadata <- get.metadata(series)

# Gathering range stats to determine range of variation
five.stats <- as.list(fivenum(scaled.data))

## Convert to binary
# to.binary <- lapply(data$value,intToBits)

window <- tail(data, n=12)

# Visualize series
ggplot(data=data, aes(x=date,y=value)) + 
  geom_line(colour="blue", size=.6) + 
  geom_point(colour="black", size=4, shape=21, fill="white")