library(jsonlite)
library(forecast)

log10_ceiling <- function(x) {
  10^(ceiling(log10(x)))
}

base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="

series_id <- "ECOMNSA"

url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"

type <- "&file_type=json"

units <- "&units=pc1"

full_url <- paste(base_url,series_id, units, url_api, type, sep="")

doc <- fromJSON(full_url)

assign(series_id, data.frame(doc$observations))

drops <- c("realtime_start","realtime_end")
ECOMNSA <- ECOMNSA[,!(names(ECOMNSA) %in% drops)]
ECOMNSA$date <- strptime(ECOMNSA$date, format="%Y-%m-%d")

ECOMNSA$value <- ECOMNSA$value[ECOMNSA$value <= 0 ] <- NA
# 
# good <- complete.cases(ECOMNSA)
# ECOMNSA <- ECOMNSA[good,]

plot(ECOMNSA,type = 'l' )

mag <- lapply(ECOMNSA$value, function(x) 10^(ceiling(log10(x))))

ECOMNSA$mag <- mag

      