# converts Gviz GeneRegionTrack to Epiviz GenesTrack

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
  app <- startStandalone(annotation, chr=chr, start=start, end=end, port=7356)
}
