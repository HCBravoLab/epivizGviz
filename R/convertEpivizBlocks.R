# converts Epiviz BlocksTrack to Gviz AnnotationTrack

convertEpivizBlocks <- function(app, chart_obj, chr) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!identical(chart_obj$.type, "epiviz.plugins.charts.BlocksTrack")) {
    stop("'chart_obj' must be an 'EpivizChart' object of type 'BlocksTrack'")
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
    if (!exists("anno_list")) {anno_list <- list()}
    anno_list[[length(anno_list)+1]] <- AnnotationTrack(gr_chr, stacking="dense", shape="box", col=NULL, chromosome=chr, name=name, fontsize=12)
  }
  anno_list <- unique(anno_list)
}
