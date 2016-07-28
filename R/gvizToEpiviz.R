# convert an existing Gviz plot into an Epiviz workspace

gvizToEpiviz <- function(gviz_plot) {

  # check arguments
  if (!is(gviz_plot, "list")) {
    stop(("'gviz_plot' must be a 'list' object"))
  }

  # create epiviz workspace
  for (track in gviz_plot) {
    if (class(track)=="GeneRegionTrack" || class(track)=="BiomartGeneRegionTrack") {
      app <- convertGvizGeneRegion(track=track)
    } else if (class(track)=="AnnotationTrack") {
      convertGvizAnnotation(app=app, track=track)
    } else if (class(track)=="DataTrack") {
      convertGvizData(app=app, track=track)
    }
  }
  return(app)
}
