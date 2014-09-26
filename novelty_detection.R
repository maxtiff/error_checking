## Fix to be os and user agnostic.
# setwd()

## Source all required scripts.
required_scripts <- c('test_loader.R', 'normal_behavior.R')
sapply(required_scripts, source, .GlobalEnv)

## Begin analysis ... 
object <- getJSON('DGORDER')
data <- get_data(object)
metadata <- get_metadata(object)

# Standarize data
scaled.data <- scale(as.numeric(data$value))

# Gathering range stats
five.stats <- as.list(fivenum(scaled.data))
quant <- as.list(quantile(scaled.data))
                         
window <- tail(abs_val, n=12)

# inspect_behavior

test_mag <- get_magnitude(window)
to_binary <- lapply(test_mag,intToBits)

cache
