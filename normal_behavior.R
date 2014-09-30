
# get_norm_behavior <- function(data) {
#   
#   # Find mean
#   mean <- mean(as.numeric(data))
#   
#   # Find distance from mean for each observation via anonymous function
#   diff <- lapply(data, function(x) x - mean)
#   
#   # Sqr values in data  
#   sqr <- lapply(diff, function(x) x^2)
#   
#   # Sum the values of all squared observations
#   sqr_sum <- sum(as.numeric(sqr))
#   
#   # Find divided sum of squares
#   dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
#   
#   # Take square root of divided sum of squares to get SD.
#   return(sqrt(dvd_sum_sqrs))
# }

# get_magnitude <- function(data) {
#   data <- as.numeric(data)
#   return(10^(floor(log10(data))))
# }

determine.freq <- function(object) {
  
  return(as.list(object$seriess['frequency_short']))
  
}

create.windows <- function(data, frequency) {
  
  ln <- length(data$value)
  freq <- frequency
  
  if (freq == 'M') {
    interval <- ceiling(ln/12)
    return(rollapply(data$value,width=interval,diff(quantile(data$value,)),by=interval))
  } else if (is.null(data)) {
    return('fail')
  } else {
    return('something wrong')
  }
  
}

detect.outliers <- function(data,plot=TRUE) {
  
  ## Read in data.
  x <- as.ts(data)
  
  ## Estimate trend and components.
  if(frequency(x)>1)
    resid <- stl(x,s.window="periodic",robust=TRUE)$time.series[,3]
  else
  {
    tt <- 1:length(x)
    resid <- residuals(loess(x ~ tt))
  }
  
  ## Break into quantiles for outlier detection and score observations on severity.
  resid.q <- quantile(resid,prob=c(0.1,0.9))
  
  ## Establish interquantile range
  iqr <- diff(resid.q)
  limits <- resid.q + 1.5*iqr*c(-1,1)
  
  ## Determine score of data point
  score <- abs(pmin((resid-limits[1])/iqr,0) + pmax((resid - limits[2])/iqr,0))
  
  ## Plot outliers on TS graph.
  if(plot)
  {
    plot(x)
    x2 <- ts(rep(NA,length(x)))
    x2[score>0] <- x[score>0]
    tsp(x2) <- tsp(x)
    points(x2,pch=19,col="red")
    
    return(invisible(score))
  }
  else if (sum(score) > 0) {
    return(score)
  } else {
    return("No anomalies have been detected.")
  }
  
}


