#### Create data frames
getJSON <- function(id) {

  series_id <- id
#   unit <- units
#   vintage <- vint
  
  # Establish components of URL for API call
  base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="
  url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"
  type <- "&file_type=json"
  
  
  full_url <- paste(base_url,series_id, url_api, type, sep="")
  
  # Pull JSON from API
  return(fromJSON(full_url))
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