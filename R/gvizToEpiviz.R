# convert an existing Gviz plot into an Epiviz workspace

gvizToEpiviz <- function(gviz_plot, annotation, start, end) {

  if (gviz_plot[[1]]@genome=="hg19") {
  library(Homo.sapiens)
  annotation <- Homo.sapiens
  }
  annotation
  app <- startStandalone(annotation, keep_seqlevels=paste0("chr", c(10,11,20)), chr="chr11", port=7344)
  app$navigate(chr=chr, start=start, end=end)
  for (track in gviz_plot) {
    if (class(track)=="GeneRegionTrack") {
      convertGeneRegion(app=app, track=track)
    } else if (class(track)=="AnnotationTrack") {
      convertAnnotation(app=app, track=track)
    } else if (class(track)=="DataTrack") {
      convertData(app=app, track=track)
    }
  }
}
