# converts Epiviz HeatmapPlot to Gviz DataTrack

convertHeatmap <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  ms_obj <- app$get_ms_object(chart_obj)$.object
  mcols(rowRanges(ms_obj)) <- assay(ms_obj)
  gr <- GRanges(rowRanges(ms_obj), strand="*")
  gr_chr <- gr[which(seqnames(gr)==chr),]
  for (ms in measurements) {
    name <- ms@datasourceId
  if (!exists("heat_list")) {heat_list <- list()}
  heat_list[[length(heat_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("heatmap"), chromosome=chr, name=name, fontsize=12)
  }
  heat_list <- unique(heat_list)
}
