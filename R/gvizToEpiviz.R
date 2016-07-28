# convert an existing Gviz plot into an Epiviz workspace

gvizToEpiviz <- function(gviz_plot) {
  for (track in gviz_plot) {
    if (class(track)=="GeneRegionTrack" || class(track)=="BiomartGeneRegionTrack") {
      app <- convertGeneRegion(track=track, chr=chr, start=start, end=end)
    } else if (class(track)=="AnnotationTrack") {
      convertAnnotation(app=app, track=track)
    } else if (class(track)=="DataTrack") {
      convertData(app=app, track=track)
    }
  }
  return(app)
}
