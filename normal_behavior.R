
get_norm_behavior <- function(data) {
  
  # Find mean
  mean <- mean(as.numeric(data))
  
  # Find distance from mean for each observation via anonymous function
  diff <- lapply(data, function(x) x - mean)
  
  # Sqr values in data  
  sqr <- lapply(diff, function(x) x^2)
  
  # Sum the values of all squared observations
  sqr_sum <- sum(as.numeric(sqr))
  
  # Find divided sum of squares
  dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
  
  # Take square root of divided sum of squares to get SD.
  return(sqrt(dvd_sum_sqrs))
}

get_magnitude <- function(data) {
  data <- as.numeric(data)
  return(10^(floor(log10(data))))
}

