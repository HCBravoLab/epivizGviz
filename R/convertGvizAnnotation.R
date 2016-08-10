#' Convert Gviz AnnotationTrack to Epiviz BlocksTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param track (AnnotationTrack) an object of class \code{\link[Gviz]{AnnotationTrack}}.
#'
#' @return An object of class \code{\link[epivizr]{EpivizChart}}
#'
#' @examples
#' # see package vignette for example usage
#' convertGvizAnnotation(app, track)
#'
#' @export
convertGvizAnnotation <- function(app, track) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!is(track, "AnnotationTrack")) {
    stop("'track' must be an 'AnnotationTrack' object")
  }

  # create epiviz chart
  gr <- track@range
  name <- track@name
  anno_track <- app$plot(gr, datasource_name=name)
  return(anno_track)
}
