library(jsonlite)


urls <- c("http://api.stlouisfed.org/fred/series/observations?series_id=ECOMNSA&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json","http://api.stlouisfed.org/fred/series/observations?series_id=DGORDER&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json")

lapply(urls, getJSON())

url <- "http://api.stlouisfed.org/fred/series/observations?series_id=ECOMNSA&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json"

download_file <- function(url, ...) {
  download.file(url, basename(url),...)  
}
lapply(urls, download_file)

getJSON <- function(x, ...) {
  assign(basename(as.name(x), x))
  x <- fromJSON(x)
}

lapply(urls, getJSON)

lapply(urls, function(x) assign(basename(as.name(x)), x))
       
lapply(urls, function(x) assign(basename(x), x))
sapply(urls, getJSON)