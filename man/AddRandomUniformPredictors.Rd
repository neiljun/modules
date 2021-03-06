% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AddRandomUniformPredictors.R
\name{AddRandomUniformPredictors}
\alias{AddRandomUniformPredictors}
\title{Process module: AddRandomUniformPredictors}
\usage{
AddRandomUniformPredictors(.data, name = "RandUnif", scaleTo = NULL)
}
\arguments{
\item{.data}{\strong{Internal parameter, do not use in the workflow function}. \code{.data} is a list of a data frame and a raster object returned from occurrence modules and covariate modules respectively. \code{.data} is passed automatically in workflow from the occurrence and covariate modules to the process module(s) and should not be passed by the user.}

\item{name}{Optional argument specifying the name of the new covariate layer.  If not specified, it will automatically named.}

\item{scaleTo}{Optional argument specifying the name of an existing covariate layer which the new random uniform covariate will be scaled to.}
}
\value{
a Raster object with the appended random uniform covariate.
}
\description{
Process module which adds a random uniform covariate to the dataset.  This new covariate can be scaled to an existing covariate.
}
\section{Version}{
 1.01
}

\section{Date submitted}{
 2016-06-15
}

\section{Data type}{
 presence-only, presence/absence, abundance, proportion
}

\examples{
work1 <- workflow(occurrence = UKAnophelesPlumbeus,
   covariate  = UKAir,
   process    = Chain(OneHundredBackground,
                   AddRandomUniformPredictors(scaleTo = 'layer', name = 'Random.layer'),
                   AddRandomUniformPredictors(scaleTo = 'layer'),
                   AddRandomUniformPredictors),
   model      = LogisticRegression,
   output     = PerformanceMeasures)
   
### Display resulting covariate maps from each workflow
spplot(work1$process.output[[1]]$ras$layer)
spplot(work1$process.output[[1]]$ras$Random.layer.1)
spplot(work1$process.output[[1]]$ras$RandUnif.1)
spplot(work1$process.output[[1]]$ras$RandUnif.2)

### Show resulting model
work1$model.output[[1]]$model$model

}
\seealso{
Other process: \code{\link{BackgroundAndCrossvalid}},
  \code{\link{Background}}, \code{\link{Bootstrap}},
  \code{\link{CarolinaWrenValidation}},
  \code{\link{Clean}}, \code{\link{Crossvalidate}},
  \code{\link{JitterOccurrence}},
  \code{\link{LonLatToCovariates}}, \code{\link{MESSMask}},
  \code{\link{NoProcess}},
  \code{\link{OneHundredBackground}},
  \code{\link{OneThousandBackground}},
  \code{\link{PartitionDisc}}, \code{\link{RemoveNAs}},
  \code{\link{StandardiseCov}},
  \code{\link{SubsampleOccurrence}},
  \code{\link{TargetGroupBackground}},
  \code{\link{Transform}}, \code{\link{addInteraction}},
  \code{\link{spThin}}
}
\author{
James Campbell, \email{jamesadamcampbell@gmail.com}
}
