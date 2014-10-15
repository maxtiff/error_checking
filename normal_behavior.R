
determine.freq <- function(object) {

  return(as.list(object$seriess['frequency_short']))

}


detect.outliers <- function(data,plot=TRUE) {

  ## Read in data.
  x <- as.ts(data)

  ## Estimate trend and components and take residual.
  if(frequency(x)>1)
    resid <- stl(x,s.window="periodic",robust=TRUE)$time.series[,3]
  else
  {
    tt <- 1:length(x)
    resid <- residuals(loess(x ~ tt))
  }

  ## Break into quantiles for outlier detection and score observations on severity.
  resid.q <- quantile(resid,prob=c(0.25,0.75))

  ## Establish interquantile range
  iqr <- diff(resid.q)
  limits <- resid.q + 2.5*iqr*c(-1,1)

  ## Determine score of data point. Only examine scores above 1.
  score <- floor(abs(pmin((resid-limits[1])/iqr,0) + pmax((resid - limits[2])/iqr,0)))

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
  ## Check value of score.
  else if (sum(score) > 0) {

    return(score)

  } else {

    return("No anomalies have been detected.")

  }

}

check.revisions <- function(vintage,update) {

  old.obs <- head(update, n=-1)

  if (identical(vintage,old.obs) == TRUE) {
    # continue
  } else if (identical(vintage,old.obs) == FALSE) {
    # mark which observations have revised.
  } else {
    print("Error. Exiting")
    exit()
  }

}

observation.windows <- function(data) {
  ### Create non-overlapping windows.
  ## Count how many obs total in the time series, as well as handle the quantity of obs inspected by the algorithim and obs that remain to be processed.
  series.length <- length(data)
  remaining.obs <- series.length
  obs.inspected <- 0

  ### Establish number of windows over span of time series.
  ## 10 is chosen to prevent degrees of freedom errors. This may need adjustment with any appropriate evidence that becomes available as time proceeds.
  ## Window size is 9 in order to slide the window along the time series without double counting observations.
  window.size <- 9
  slider <- 10
  complete.windows <- floor(series.length/window.size)
  remainder <- series.length%%10
  print(paste("Observations remaining after last complete window:",remainder,sep=" "))

  ## Counter variables for window coordinates in list (this is bad practice).
  n <- 1

  ## Check if new data is identical to previous vintage up to the last observation.
# if (check.revisions == TRUE) {
#
#   score <- detect.outliers(tail(data, n = 10)
#
# } else {

   ## Sequence along windows of time series.
   # Adjust to prevent subscript out of bounds.
    for (i in seq_along(data)) {

      print(i)

# if (remaining.obs > remainder) {
      score <- detect.outliers(data[n:(n+window.size),])
      print(paste("Remaining Observations:",remaining.obs, sep=" "))
      print(data[n:(n+window.size),])
      print(score)

      n <- n + slider
      obs.inspected <- obs.inspected + 10
      print(paste("Observations inspected:",obs.inspected,sep=" "))
      remaining.obs <- series.length - obs.inspected
      print(paste("Remaining Observations:",remaining.obs,sep=" "))
#     } else if (remaining.obs - window.size == remainder) {
#        score <- detect.outliers(data[n:(n+window.size),])
# #       print(score)
# #
# #       n <- n + window.size
# #       remaining.obs <- remaining.obs - window.size
#        print(remaining.obs)
#
#     }

  }

}

forecast.post <- function(data) {

  ft <- forecast(as.ts(data))

  return(ft$mean[2])

}

get.magnitude <- function(data) {

  return(10^(ceiling(log10(data))))

}

