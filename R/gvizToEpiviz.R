# convert an existing Gviz plot into an Epiviz workspace

gvizToEpiviz <- function(gviz_plot, annotation, start, end) {
  chr <- "chr11"
  start <- 85000000
  end <- 86000000
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
