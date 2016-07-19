# converts Epiviz LineTrack to Gviz DataTrack

convertLineTrack <- function(grange, chr, chart=NULL, name) {
  if (!is.null(chart)) {
    measurements <- chart$.measurements
    for (ms in measurements) {
      gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
      grange <- gr[which(seqnames(gr)==chr),]
      name <- ms@datasourceId
    }
  }
  if (!exists("track_list")) {track_list <<- list()}
  track_list[[length(track_list)+1]] <<- DataTrack(grange, groups=colnames(mcols(grange)), type=c("smooth"), chromosome=chr, name=name)
}
