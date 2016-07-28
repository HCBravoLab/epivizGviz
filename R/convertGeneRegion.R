# converts Gviz GeneRegionTrack to Epiviz GenesTrack

convertGeneRegion <- function(track, annotation) {
  chr <- track@chromosome
  start <- min(start(track))
  end <- max(end(track))
  if (track@genome=="hg19") {
    library(Homo.sapiens)
    annotation <- Homo.sapiens
  }
  app <- startStandalone(annotation, chr=chr, start=start, end=end, port=7356)
}
