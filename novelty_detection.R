## Fix to be os agnostic
# setwd()

## Source all required scripts.
required_scripts <- c('test_loader.R', 'normal_behavior.R')
sapply(required_scripts, source, .GlobalEnv)

source('test_loader.R')
source('normal_behavior.R')
object <- getJSON('DGORDER')
data <- get_data(object)
metadata <- get_metadata(object)

abs_val<- lapply(data$value, abs)
window <- tail(abs_val, n=12)
sd <- get_norm_behavior(window)

# inspect_behavior

test_mag <- get_magnitude(window)
to_binary <- lapply(test_mag,intToBits)
