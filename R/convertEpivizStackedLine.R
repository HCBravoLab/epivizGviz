#' Convert Epiviz StackedLineTrack to Gviz DataTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param chart_obj (EpivizChart) an object of class \code{\link[epivizr]{EpivizChart}}.
#' @param chr (character) the name of the chromosome to plot over, ex: "chr11".
#'
#' @return A list containing an object of class \code{\link[Gviz]{DataTrack}}
#'
#' @examples
#' # see package vignette for example usage
#' convertEpivizStackedLine(app, chart_obj, chr)
#'
#' @export
convertEpivizStackedLine <- function(app, chart_obj, chr) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!identical(chart_obj$.type, "epiviz.plugins.charts.StackedLineTrack") && !identical(chart_obj$.type, "epiviz.plugins.charts.StackedLinePlot")) {
    stop("'chart_obj' must be an 'EpivizChart' object of type 'StackedLineTrack' or 'StackedLinePlot'")
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
    if (!exists("stac_list")) {stac_list <- list()}
    stac_list[[length(stac_list)+1]] <- DataTrack(gr_chr, groups=colnames(mcols(gr_chr)), type=c("histogram"), chromosome=chr, name=name, fontsize=12)
  }
  stac_list <- unique(stac_list)
  return(stac_list)
}

