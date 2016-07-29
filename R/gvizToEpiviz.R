# convert an existing Gviz plot into an Epiviz workspace

gvizToEpiviz <- function(gviz_plot, annotation=NULL, chr=NULL, start=NULL, end=NULL) {

  # check arguments
  if (!is(gviz_plot, "list")) {
    stop(("'gviz_plot' must be a 'list' object"))
  }

  # create epiviz workspace
  app <- NULL
  for (track in gviz_plot) {
    if (class(track)=="GeneRegionTrack" || class(track)=="BiomartGeneRegionTrack") {
      app <- convertGvizGeneRegion(track=track, annotation=annotation, chr=chr, start=start, end=end)
    }
  }
  if (is.null(app)) {
    app <- startStandalone(annotation, chr=chr, start=start, end=end, port=7356)
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
