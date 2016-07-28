# converts Gviz AnnotationTrack to Epiviz BlocksTrack

convertGvizAnnotation <- function(app, track) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!is(track, "AnnotationTrack")) {
    stop(("'track' must be an 'AnnotationTrack' object"))
  }

  # create epiviz chart
  gr <- track@range
  name <- track@name
  anno_track <- app$plot(gr, datasource_name=name)
}
