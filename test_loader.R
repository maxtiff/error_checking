##    This module loads all URL information to call previous vintage from FRED API.
##    Improve documentation universality, and naming conventions.
##                                                          

setBaseURL <- function() {

  return("http://api.stlouisfed.org/fred")
  
  series/observations?
  url_api <- "api_key=76bb1186e704598b725af0a27159fdfc"
  unit <- '&units=pch'
  type <- "&file_type=json"
  
  return(paste(base_url,url_api,unit, type, sep=""))
}

## Call URL
getBaseURL <- function() {
  
  return(setBaseURL())
  
}

getTypeDir <- function() {

  base_url <- getBaseURL()
  
  dir <- 'series'
  
  return(paste(base_url, dir, sep="/"))
  
}

getType <- function() {
  
  type_url <- getTypeDir()
  
  type <- 'observations'
  
  return(paste(type_url,type,sep="/"))
}

getAPIKey <- function() {
  return("api_key=76bb1186e704598b725af0a27159fdfc")
}

getURL <- function() {
  base <- getType()
  key <- getAPIKey()
    
  return(paste(base,key,sep="?"))
}


## Create data frames
getJSON <- function(id) {
  base_url <- getURL()
  series_url<- paste('base_url','&series_id=',id,sep="")

  return(fromJSON(series_url))
} 

getVintageDates <- function(id) {
  
  ## This funciton is for testing and demonstration purposes only.
  base_url <- getURL()
  series_id <- id
  vintage <- vint
  
}

get_data <- function(object) {
  ##Input json object from getJSON()
  
  # Convert JSON object to data frame for processing
  data <- data.frame(object$observations)
  
  # Drop realtime start and end
  drops <- c("realtime_start","realtime_end")
  data <- data[,!(names(data) %in% drops)]
  
  # Convert observation date to appropriate format for time-series analysis
  data$date <- strptime(data$date, format="%Y-%m-%d")
  
  # Convert
  data$value <- as.numeric(data$value)
  
  # Drop NA values.
  data <- na.omit(data)
  
  return(data)
  
  ###########################################################################################
  ##### The data frame should be immutable at this point! Do not attempt to change it! ######
  ###########################################################################################
}

get_metadata <- function(object) {
  # pulls information about series from downloaded JSON object
  return(data.frame(rbind(object$observation_start,object$observation_end,object$units)))  
}