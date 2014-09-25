required_scripts <- c('test_loader.R', 'magnitude.R')

lapply(required_scripts, function (x) source(x))
source('test_loader.R')
source('magnitude.R')
test <- getJSON('DGORDER')

test_mag <- get_magnitude(test$value)