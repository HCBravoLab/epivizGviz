#' Convert Epiviz BlocksTrack to Gviz AnnotationTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param chart_obj (EpivizChart) an object of class \code{\link[epivizr]{EpivizChart}}.
#' @param chr (character) the name of the chromosome to plot over, ex: "chr11".
#'
#' @return A list containing an object of class \code{\link[Gviz]{AnnotationTrack}}
#'
#' @examples
#' \dontrun{
#' # see package vignette for example usage
#' convertEpivizBlocks(app, chart_obj, chr)
#' }
#' 
#' @import methods
#' @import Gviz
#' @export
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
    gr <- GenomicRanges::GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    if (!exists("anno_list")) {anno_list <- list()}
    anno_list[[length(anno_list)+1]] <- AnnotationTrack(gr_chr, stacking="dense", shape="box", col=NULL, chromosome=chr, name=name, fontsize=12)
  }
  anno_list <- unique(anno_list)
  return(anno_list)
}
