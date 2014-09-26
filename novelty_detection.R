## Fix to be os and user agnostic.
# setwd()

## Source all required scripts.
required.scripts <- c('test_loader.R', 'normal_behavior.R')
sapply(required.scripts, source, .GlobalEnv)

## Begin analysis ... 
object <- get.JSON('DGORDER')
data <- get.data(object)
metadata <- get.metadata(object)

# Standarize data
scaled.data <- scale(as.numeric(data$value))

length(scaled.data)

# Gathering range stats
five.stats <- as.list(fivenum(scaled.data))
quant <- as.list(quantile(scaled.data))
                         
window <- tail(scaled.data, n=12)

# Convert to binary
to.binary <- lapply(window,intToBits)


