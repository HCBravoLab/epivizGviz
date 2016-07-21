# converts Epiviz StackedLineTrack to Gviz DataTrack

convertStackedLine <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  ms_obj <- app$get_ms_object(chart_obj)$.object
  mcols(rowRanges(ms_obj)) <- assay(ms_obj)
  gr <- GRanges(rowRanges(ms_obj), strand="*")
  gr_chr <- gr[which(seqnames(gr)==chr),]
  for (ms in measurements) {
    name <- ms@datasourceId
    if (!exists("stac_list")) {stac_list <- list()}
    stac_list[[length(stac_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("histogram"), chromosome=chr, name=name, fontsize=12)
  }
  stac_list <- unique(stac_list)
}

