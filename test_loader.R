##    This module loads all URL information to call previous vintage from FRED API.
##    Improve documentation universality, and naming conventions.
##                                                          

set.BaseURL <- function() {

  return("http://api.stlouisfed.org/fred")
  
}

get.BaseURL <- function() {
  
  return(set.BaseURL())
  
}

get.TypeDir <- function() {

  base<- get.BaseURL()  
  dir <- 'series'  
  type <- 'observations'
  
  return(paste(base, dir, type, sep="/"))
  
}

set.APIKey <- function() {
  
  return("api_key=76bb1186e704598b725af0a27159fdfc")
  
}

get.APIkey <- function() {
  
  base <- get.TypeDir()  
  key <- set.APIKey()
  
  return(paste(base,key,sep="?"))
}

get.finalURL <- function() {
  
  base <- get.APIkey()
  units <- "units=pch"  
  file.type <- "file_type=json"
  
  return(paste(base,units,file.type,sep='&'))
}

## Create data frames
get.JSON <- function(id) {
  
  base<- get.finalURL()  
  series<- paste(base,'&series_id=',id,sep="")
  
  return(fromJSON(series))
} 

get.VintageDates <- function(id, vint) {
  
  ## This funciton is for testing and demonstration purposes only.
  base_url <- getURL()
  series_id <- id
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
  
  # Convert to scaled
  data$value <- as.numeric(data$value)
  
  # Drop NA values.
  data <- na.omit(data)
  
  return(data)
  
  ###########################################################################################
  ##### The data frame should be immutable at this point! Do not attempt to change it! ######
  ###########################################################################################
}

get.metadata <- function(object) {
  # pulls information about series from downloaded JSON object
  return(data.frame(rbind(object$observation_start,object$observation_end,object$units)))  
}