#' Convert Gviz GeneRegionTrack to Epiviz GenesTrack.
#'
#' @param track (GeneRegionTrack) an object of class \code{\link[Gviz]{GeneRegionTrack}}.
#' @param annotation (OrganismDb) an object of class \code{\link[OrganismDbi]{OrganismDb}}.
#' @param chr (character) chromosome to browse to on app startup.
#' @param start (integer) start location to browse to on app startup.
#' @param end (integer) end location to browse to on app startup.
#'
#' @return An object of class \code{\link[epivizr]{EpivizApp}}
#'
#' @examples
#' # see package vignette for example usage
#' convertGvizGeneRegion(track, annotation=NULL, chr=NULL, start=NULL, end=NULL)
#'
#' @export
convertGvizGeneRegion <- function(track, annotation=NULL, chr=NULL, start=NULL, end=NULL) {

  # check arguments
  if (!is(track, "GeneRegionTrack")) {
    stop("'track' must be a 'GeneRegionTrack' object")
  }
  if (track@genome=="hg19") {
    library(Homo.sapiens)
    annotation <- Homo.sapiens
  }
  if (is.null(annotation)) {
    stop("Must provide 'annotation' if genome is not 'hg19'")
  }

  # create epiviz chart
  if (is.null(chr)) {
    chr <- track@chromosome
  }
  if (is.null(start)) {
    start <- min(start(track))
  }
  if (is.null(end)) {
    end <- max(end(track))
  }
  app <- startStandalone(annotation, chr=chr, start=start, end=end, try_ports=TRUE)
  return(app)
}
