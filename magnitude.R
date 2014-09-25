# get_absval_pch <- function(data) {
#   
# #   if (units == grep('pct1',units)) {
#     ## Calculate SD of percent change
#     
# 
#     
# #     # Square the distance to get rid of negative values
# #     sqr <- lapply(data$value, function(x) x^2)
# #    
# #     
# #     # Take sqrt to remove all negative values 
# #     sqr_rt <- lapply(sqr, sqrt)
#     
#     # Get absolute value of percent change
#     abs_value <- lapply(data$value, abs)
#     return(as.numeric(abs_value))
# }

  # Sqr values in window  
  sqr <- lapply(data$value, function(x) x^2)
    
  # Sum the values of all squared observations
  sqr_sum <- sum(as.numeric(sqr))
    
  # Find divided sum of squares
  dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
    
  # Take square root of divided sum of squares to get SD.
  sd_pct_chg <- sqrt(dvd_sum_sqrs)
#   }  
}

get_norm_behavior <- function() {
  # Find mean
  mean <- mean(tail(data$value, 10))
  
  # Find distance from mean for each observation via anonymous function
  diff <- lapply(data$value, function(x) x - mean)
  
  # Sqr values in window  
  sqr <- lapply(diff, function(x) x^2)
  
  # Sum the values of all squared observations
  sqr_sum <- sum(as.numeric(sqr))
  
  # Find divided sum of squares
  dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
  
  # Take square root of divided sum of squares to get SD.
  sd_pct_chg <- sqrt(dvd_sum_sqrs)
}

get_magnitude <- function(data) {
  return(10^(ceiling(log10(data))))
  
}
