library(XML)

xml_base_url <- "http://api.stlouisfed.org/fred/series/observations?series_id="

xml_series_id <- "DGORDER"

xml_url_api <- "&api_key=76bb1186e704598b725af0a27159fdfc"

# xml_order_parameter <- "&order_by=series_id"

# xml_tags_paramter <- "&tag_names=exports;end+use"

full_xml_url <- paste(xml_base_url,xml_series_id,xml_url_api)

doc <- xmlTreeParse(full_xml_url, useInternal = TRUE)

xmlName(rootNode)
names(rootNode)