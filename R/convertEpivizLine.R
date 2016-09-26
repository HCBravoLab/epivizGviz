#' Convert Epiviz LineTrack to Gviz DataTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param chart_obj (EpivizChart) an object of class \code{\link[epivizr]{EpivizChart}}.
#' @param chr (character) the name of the chromosome to plot over, ex: "chr11".
#'
#' @return A list containing an object of class \code{\link[Gviz]{DataTrack}}
#'
#' @examples
#' # see package vignette for example usage
#' \dontrun{
#' convertEpivizLine(app, chart_obj, chr)
#' }
#' 
#' @import methods
#' @import Gviz
#' @export
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
    gr <- GenomicRanges::GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    if (!exists("line_list")) {line_list <- list()}
    line_list[[length(line_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("smooth"), chromosome=chr, name=name, fontsize=12)
  }
  line_list <- unique(line_list)
  return(line_list)
}
