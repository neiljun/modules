
#'Process module: OneThousandBackground
#'
#'Process module to generate up to 1000 background records at random in
#'      cells of the covariate raster and return these along with the occurrence data.
#'
#'
#'@return Dataframe with at least 5 columns
#'       value - a numeric value which may give 1 for presences, 0 for absences 
#'       or a positive integer for count data
#'       type - a character value saying what is in the value column
#'       lon - the longitude of the record
#'       lat - the latitutude of the record
#'       columns 5-n - the values of the covariates for each records (the names of
#'               these columns should correspond exactly to the names of the 
#'               layers in the covariate raster)
#'@name OneThousandBackground



OneThousandBackground <- function (occurrence, ras) {
  
  require (dismo)
  
  if (!all(occurrence$type == 'presence')) {
    stop ('this function only works for presence-only data')
  }
  
  # generate pseudo-absence data
  # suppressing warnings when the number is restricted
  suppressWarnings(pa <- randomPoints(ras, 1000))
  
  npres <- nrow(occurrence)
  
  npabs <- nrow(pa)
  
  # extract covariates
  occ_covs <- as.matrix(extract(ras, occurrence[, c('longitude', 'latitude')]))
  
  pa_covs <- as.matrix(extract(ras, pa))
  
  covs <- rbind(occ_covs, pa_covs)
  
  # combine with the occurrence data
  df <- data.frame(value = rep(c(1, 0),
                               c(npres, npabs)),
                   type = rep(c('presence', 'background'),
                              c(npres, npabs)),
                   fold = 1,
                   lon = c(occurrence$lon, pa[, 1]),
                   lat = c(occurrence$lat, pa[, 2]),
                   covs)
  
  names(df)[5:ncol(df)] <- names(ras)
  
  # remove missing values
  df <- na.omit(df)
  
  return(df)
  
}