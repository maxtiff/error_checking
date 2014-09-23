library(jsonlite)

"%o%" <- compose

urls <- c("http://api.stlouisfed.org/fred/series/observations?series_id=ECOMNSA&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json","http://api.stlouisfed.org/fred/series/observations?series_id=DGORDER&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json")
url <- "http://api.stlouisfed.org/fred/series/observations?series_id=DGORDER&api_key=76bb1186e704598b725af0a27159fdfc&file_type=json"
names <- vector()

getJSON <- function(x, ...) {
  assign(basename(x), data.frame(fromJSON(as.character(x))))
}


sapply(urls, function(x) assign(basename(as.vector(x)), x))

assignNames <- function(x, ...) {
  for (item in x) {
    assign(basename(as.vector(item)), item)
  }
}