# converts Gviz GeneRegionTrack to Epiviz GenesTrack

convertGvizGeneRegion <- function(track, annotation=NULL) {

  # check arguments
  if (!is(track, "GeneRegionTrack")) {
    stop(("'track' must be a 'GeneRegionTrack' object"))
  }
  if (track@genome=="hg19") {
    library(Homo.sapiens)
    annotation <- Homo.sapiens
  }
  if (is.null(annotation)) {
    stop(("Must provide 'annotation' if genome is not 'hg19'"))
  }

  # create epiviz chart
  chr <- track@chromosome
  start <- min(start(track))
  end <- max(end(track))
  app <- startStandalone(annotation, chr=chr, start=start, end=end, port=7356)
}
