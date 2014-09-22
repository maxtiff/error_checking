library(jsonlite)

getJSON <- function(url, ...) {
  fromJSON(url, ...)
}

urls <- c("http://api.stlouisfed.org/fred/series/observations?series_id=ECOMNSA&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json","http://api.stlouisfed.org/fred/series/observations?series_id=DGORDER&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json")

lapply(urls, getJSON())
