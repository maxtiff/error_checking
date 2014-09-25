get_sd <- function(data) {
  
#   if (units == grep('pct1',units)) {
    ## Calculate SD of percent change
    
    # Find mean
    mean <- mean(data$value)
    
    # Find distance from mean for each observation via anonymous function
    diff <- lapply(data$value, function(x) x - mean)
    
    # Square the distance to get rid of negative values
    sqr <- lapply(diff, function(x) x*x)
    
    # Sum the values of all squared observations
    sqr_sum <- sum(as.numeric(sqr))
    
    # Find divided sum of squares
    dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
    
    # Take square root of divided sum of squares to get SD.
    sd_pct_chg <- sqrt(dvd_sum_sqrs)
#   }  
}

get_magnitude <- function(data) {
  return(10^(ceiling(log10(data))))
}

units_level <- function(){}

rate_unites <- function(){}