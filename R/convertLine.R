# converts Epiviz LineTrack to Gviz DataTrack

convertLine <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    if (!exists("line_list")) {line_list <- list()}
    line_list[[length(line_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("smooth"), chromosome=chr, name=name, fontsize=12)
  }
  line_list <- unique(line_list)
}
