# converts Epiviz BlocksTrack to Gviz AnnotationTrack

convertBlocksTrack <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    if (!exists("track_list")) {track_list <<- list()}
    track_list[[length(track_list)+1]] <<- AnnotationTrack(gr_chr, stacking="dense", shape="box", col=NULL, chromosome=chr, name=name)
  }
}
