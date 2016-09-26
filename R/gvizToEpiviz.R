#' Convert an existing Gviz plot into an Epiviz workspace.
#'
#' @param gviz_plot (list) a list representing a plot from \code{\link[Gviz]{plotTracks}}
#' @param annotation (OrganismDb) an object of class \code{\link[OrganismDbi]{OrganismDb}}.
#' @param chr (character) chromosome to browse to on app startup.
#' @param start (integer) start location to browse to on app startup.
#' @param end (integer) end location to browse to on app startup.
#'
#' @return An object of class \code{\link[epivizr]{EpivizApp}}
#'
#' @examples
#' # see package vignette for example usage
#' \dontrun{
#' gvizToEpiviz(gviz_plot, annotation=NULL, chr=NULL, start=NULL, end=NULL)
#' }
#' 
#' @import methods
#' @import Gviz
#' @import epivizrStandalone
#' @export
gvizToEpiviz <- function(gviz_plot, annotation=NULL, chr=NULL, start=NULL, end=NULL) {

  # check arguments
  if (!is(gviz_plot, "list")) {
    stop("'gviz_plot' must be a 'list' object")
  }

  # create epiviz workspace
  app <- NULL
  for (track in gviz_plot) {
    if (class(track)=="GeneRegionTrack" || class(track)=="BiomartGeneRegionTrack") {
      app <- convertGvizGeneRegion(track=track, annotation=annotation, chr=chr, start=start, end=end)
    }
  }
  if (is.null(app)) {
    app <- startStandalone(annotation, chr=chr, start=start, end=end, try_ports=TRUE)
  }
  for (track in gviz_plot) {
    if (class(track)=="AnnotationTrack") {
      convertGvizAnnotation(app=app, track=track)
    } else if (class(track)=="DataTrack") {
      convertGvizData(app=app, track=track)
    }
  }
  return(app)
}
