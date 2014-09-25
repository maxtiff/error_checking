# required_scripts <- c('test_loader.R', 'magnitude.R')
# 
# lapply(required_scripts, function (x) source(x))

source('test_loader.R')
source('magnitude.R')
object <- getJSON('DGORDER')
data <- get_data(object)
metadata <- get_metadata(object)

test_mag <- get_magnitude(data$value)