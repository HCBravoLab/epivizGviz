#' Convert Gviz DataTrack to Epiviz LineTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param track (DataTrack) an object of class \code{\link[Gviz]{DataTrack}}.
#'
#' @return An object of class \code{\link[epivizr]{EpivizChart}}
#'
#' @examples
#' # see package vignette for example usage
#' \dontrun{
#' convertGvizData(app, track)
#' }
#' 
#' @import methods
#' @import SummarizedExperiment
#' @export
convertGvizData <- function(app, track) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!is(track, "DataTrack")) {
    stop("'track' must be a 'DataTrack' object")
  }

  # create epiviz chart
  gr <- track@range
  data <- track@data
  name <- track@name
  exprs <- t(as.matrix(data))
  rse <- SummarizedExperiment(assays=exprs, rowRanges=gr)
  rse_ms <- app$data_mgr$add_measurements(rse, name)
  if (displayPars(track)$type=="heatmap" || displayPars(track)$type=="gradient") {
    data_track <- app$chart_mgr$visualize("HeatmapPlot", datasource=rse_ms)
    return(data_track)
  } else if (displayPars(track)$type=="p") {
    data_track <- app$chart_mgr$visualize("ScatterPlot", datasource=rse_ms)
    return(data_track)
  } else if (displayPars(track)$type=="histogram") {
    data_track <- app$chart_mgr$visualize("StackedLineTrack", datasource=rse_ms)
    return(data_track)
  } else {
    data_track <- app$chart_mgr$visualize("LineTrack", datasource=rse_ms)
    data_track$set(settings=list(step=1, interpolation="basis"))
    return(data_track)
  }
}
