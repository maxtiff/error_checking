getJSON <- function(url, ...) {
  fromJSON(url, ...)
}

lapply(urls, getJSON)
