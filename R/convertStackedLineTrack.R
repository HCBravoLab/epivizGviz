# converts Epiviz StackedLineTrack to Gviz DataTrack

convertStackedLineTrack <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    if (!exists("track_list")) {track_list <<- list()}
    track_list[[length(track_list)+1]] <<- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("mountain"), chromosome=chr, name=name)
  }
}
