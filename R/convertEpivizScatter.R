#' Convert Epiviz ScatterPlot to Gviz DataTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param chart_obj (EpivizChart) an object of class \code{\link[epivizr]{EpivizChart}}.
#' @param chr (character) the name of the chromosome to plot over, ex: "chr11".
#'
#' @return A list containing an object of class \code{\link[Gviz]{DataTrack}}
#'
#' @examples
#' # see package vignette for example usage
#' convertEpivizScatter(app, chart_obj, chr)
#'
#' @export
convertEpivizScatter <- function(app, chart_obj, chr) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!identical(chart_obj$.type, "epiviz.plugins.charts.ScatterPlot")) {
    stop("'chart_obj' must be an 'EpivizChart' object of type 'ScatterPlot'")
  }
  if (is.null(chr)) {
    stop("Must provide 'chr'")
  }

  # create gviz track
  measurements <- chart_obj$.measurements
  ms_obj <- app$get_ms_object(chart_obj)$.object
  mcols(rowRanges(ms_obj)) <- assay(ms_obj)
  gr <- GRanges(rowRanges(ms_obj), strand="*")
  gr_chr <- gr[which(seqnames(gr)==chr),]
  for (ms in measurements) {
    name <- ms@datasourceId
    if (!exists("scat_list")) {scat_list <- list()}
    scat_list[[length(scat_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("p"), chromosome=chr, name=name, fontsize=12)
  }
  scat_list <- unique(scat_list)
  return(scat_list)
}
