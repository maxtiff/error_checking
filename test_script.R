library(jsonlite)
library(forecast)

## Order of magnitude funciton that is used anonymously instead.
# log10_ceiling <- function(x) {
#   10^(ceiling(log10(x)))
# }

get_vintages <- function(series_id) {
  
}

base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="

series_id <- "ECOMNSA"

url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"

type <- "&file_type=json"

units <- "&units=pc1"

vintage_date <-  
  
vintage <- TRUE


if (vintage == TRUE) {
  
  full_url <- paste(base_url,series_id, url_api, units, type, sep="")
  
}

else 

{
  full_url <- paste(base_url,series_id, url_api, type, sep="")

doc <- fromJSON(full_url)

assign(series_id, data.frame(doc$observations))

drops <- c("realtime_start","realtime_end")
ECOMNSA <- ECOMNSA[,!(names(ECOMNSA) %in% drops)]
ECOMNSA$date <- strptime(ECOMNSA$date, format="%Y-%m-%d")
ECOMNSA$value <- as.numeric(ECOMNSA$value)
# 
# good <- complete.cases(ECOMNSA)
# ECOMNSA <- ECOMNSA[good,]

plot(ECOMNSA,type = 'l' )

mag <- lapply(as.numeric(ECOMNSA$value), function(x) 10^(floor(log10(x))))

ECOMNSA$mag <- mag

good <- complete.cases(ECOMNSA$value)
ECOMNSA <- ECOMNSA[good,]
mean <- mean(ECOMNSA$value)
diff <- lapply(ECOMNSA$value, function(x) x - mean)
sqr <- lapply(diff, function(x) x*x)
sqr_sum <- sum(as.numeric(sqr))
dvd_sum_sqrs <- sqr_sum/as.numeric(length(sqr))
sd_pct_chg <- sqrt(dvd_sum_sqrs)