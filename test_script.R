library(jsonlite)

base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="

series_id <- "DGORDER"

url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"

type <- "&file_type=json"

units <- "&units=pc1"

full_url <- paste(base_url,series_id,units, url_api, type, sep="")

doc <- fromJSON(full_url)

assign(series_id, data.frame(doc$observations))

drops <- c("realtime_start","realtime_end")
DGORDER <- DGORDER[,!(names(DGORDER) %in% drops)]
DGORDER$date <- strptime(DGORDER$date, format="%Y-%m-%d")

good <- complete.cases(DGORDER)
DGORDER <- DGORDER[good,]

      