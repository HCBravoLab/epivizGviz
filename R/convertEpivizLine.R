# converts Epiviz LineTrack to Gviz DataTrack

convertEpivizLine <- function(app, chart_obj, chr) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!identical(chart_obj$.type, "epiviz.plugins.charts.LineTrack") && !identical(chart_obj$.type, "epiviz.plugins.charts.LinePlot")) {
    stop("'chart_obj' must be an 'EpivizChart' object of type 'LineTrack' or 'LinePlot'")
  }
  if (is.null(chr)) {
    stop("Must provide 'chr'")
  }

  # create gviz track
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
