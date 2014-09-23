library(jsonlite)
library(forecast)

## Order of magnitude funciton that is used anonymously instead.
# log10_ceiling <- function(x) {
#   10^(ceiling(log10(x)))
# }  

base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="

series_id <- "DGORDER"

url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"

type <- "&file_type=json"

units <- "&units=pca"

vintage_date <-  
  
vintage <- TRUE


if (vintage == TRUE) {
  full_url <- paste(base_url,series_id, url_api, units, type, sep="")
} else {
  full_url <- paste(base_url,series_id, url_api, units, type, sep="")
}

# Load JSON object
doc <- fromJSON(full_url)

# Convert JSON object to data frame for processing
# assign(series_id, data.frame(doc$observations))
ECOMNSA <- data.frame(doc$observations)
drops <- c("realtime_start","realtime_end")
ECOMNSA <- ECOMNSA[,!(names(ECOMNSA) %in% drops)]
ECOMNSA$date <- strptime(ECOMNSA$date, format="%Y-%m-%d")
ECOMNSA$value <- as.numeric(ECOMNSA$value)
ECOMNSA <- na.omit(ECOMNSA)
plot(ECOMNSA,type = 'l' )

ECOMNSA$sq <- lapply(ECOMNSA$value, function(x) x^2)

ECOMNSA$sqrt <- lapply(ECOMNSA$value, function(x) sqrt(x^2))

# Calculate order of magnitude.
ECOMNSA$mag <- lapply(as.numeric(ECOMNSA$sqrt), function(x) 10^(ceiling(log10(x))))

# Create magnitude column
ECOMNSA$mag <- mag

if (units == grep('pct1',units)) {
  ## Calculate SD of percent change
  
  # Drop NA values
  good <- complete.cases(ECOMNSA$value)
  ECOMNSA <- ECOMNSA[good,]
  
  # Find mean
  mean <- mean(ECOMNSA$value)
  
  # Find distance from mean for each observation via anonymous function
  diff <- lapply(ECOMNSA$value, function(x) x - mean)
  
  # Square the distance to get rid of negative values
  sqr <- lapply(diff, function(x) x*x)
  
  # Sum the values of all squared observations
  sqr_sum <- sum(as.numeric(sqr))
  
  # Find divided sum of squares
  dvd_sum_sqrs <- sqr_sum/(as.numeric(length(sqr)-1))
  
  # Take square root of divided sum of squares to get SD.
  sd_pct_chg <- sqrt(dvd_sum_sqrs)
}  

