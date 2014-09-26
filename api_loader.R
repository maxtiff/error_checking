##    This module loads all URL information to call previous vintage from FRED API.
##    Improve documentation universality, and naming conventions.
##                                                          

set.BaseURL <- function() {

  return("http://api.stlouisfed.org/fred")
  
}

get.BaseURL <- function() {
  
  return(set.BaseURL())
  
}

set.Dir <- function() {
  
  return('series')
  
}

get.Dir <- function() {

  return(set.Dir())
  
}

set.Type <- function() {
  
  return('observations')

}

get.Type <- function() {

  return(set.Type())
  
}

set.Units <- function() {
  base <- "units"
  units <- "pch"
  return(paste(base,units,sep="="))
  
}

get.Units <- function() {
  
  return(set.Units())
  
}

set.fileType <- function() {
  base <- "file_type"
  type <- "JSON"
  return(paste(base,type,sep=""))
  
}

set.APIKey <- function() {
  base <- "api_key"
  key <- "76bb1186e704598b725af0a27159fdfc"
  return(paste(base,key,sep="="))
  
}

get.APIkey <- function() {
  
  return(set.APIKey())
  
}

set.dirURL <- function() {
  
  base <- get.BaseURL()
  dir <- get.Dir()
  
  return(paste(base,dir,sep="/"))
}

get.dirURL <- function() {
  
  return(set.dirURL())
  
}

set.typeURL <- function() {
  
  base <- get.dirURL()
  type <- get.Type()
  
  return(paste(base,type,sep="/"))
  
}

get.typeURL <- function() {
  
  return(set.typeURL())
  
}

get.metadata <- function(series) {
  # pulls information about series from API
  # needs restructured
  base <- get.dirURL()
  key <- get.APIKey()
  api <- paste('?',key,sep="")
  series_id <- paste('&series_id=',series,sep="")
  
  return(paste(base,api,series_id,sep=""))
}

## Create data frames
get.JSON <- function(id) {
  
  base<- get.finalURL()  
  series<- paste(base,'&series_id=',id,sep="")
  
  return(fromJSON(series))
} 

get.VintageDates <- function(id, vint) {
  
  ## This funciton is for testing and demonstration purposes only.
  base <- get.finalURL()
  series <- id
  vintage <- vint
  
  
}

get.data <- function(object) {
  ##Input json object from getJSON()
  
  # Convert JSON object to data frame for processing
  data <- data.frame(object$observations)
  
  # Drop realtime start and end
  drops <- c("realtime_start","realtime_end")
  data <- data[,!(names(data) %in% drops)]
  
  # Convert observation date to appropriate format for time-series analysis
  data$date <- strptime(data$date, format="%Y-%m-%d")
  
  # Convert to numeric type
  data$value <- as.numeric(data$value)
  
  # Drop NA values.
  data <- na.omit(data)
  
  # Standardize data in order to detect outliers
  data$value <- scale(data$value)
  
  return(data)
  
  ###########################################################################################
  ##### The data frame should be immutable at this point! Do not attempt to change it! ######
  ###########################################################################################
}