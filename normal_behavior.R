
determine.freq <- function(object) {

  return(as.list(object$seriess['frequency_short']))

}

create.windows <- function(data, frequency) {
  ## Needs to be rebuilt to check around new observations and revisions, as opposed to the entire time series as it now stands.
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
  resid.q <- quantile(resid,prob=c(0.2,0.8))

  ## Establish interquantile range
  iqr <- diff(resid.q)
  limits <- resid.q + 2*iqr*c(-1,1)

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
