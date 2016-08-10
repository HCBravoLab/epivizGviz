#' Convert Epiviz GenesTrack to Gviz GeneRegionTrack.
#'
#' @param app (EpivizApp) an object of class \code{\link[epivizr]{EpivizApp}}.
#' @param chart_obj (EpivizChart) an object of class \code{\link[epivizr]{EpivizChart}}.
#' @param chr (character) the name of the chromosome to plot over, ex: "chr11".
#'
#' @return A list containing an object of class \code{\link[Gviz]{IdeogramTrack}}, \code{\link[Gviz]{GenomeAxisTrack}}, \code{\link[Gviz]{GeneRegionTrack}}
#'
#' @examples
#' # see package vignette for example usage
#' convertEpivizGenes(app, chart_obj, chr=NULL)
#'
#' @export
convertEpivizGenes <- function(app, chart_obj, chr=NULL) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!identical(chart_obj$.type, "epiviz.plugins.charts.GenesTrack")) {
    stop("'chart_obj' must be an 'EpivizChart' object of type 'GenesTrack'")
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
    gene_track <- GeneRegionTrack(gr_chr, collapseTranscripts=TRUE, stacking="dense", shape="arrow", chromosome=chr, name=name, fontsize=12)
    gen <- gene_track@genome
    chr <- gene_track@chromosome
    if (!exists("gene_list")) {gene_list <- list()}
    gene_list[[length(gene_list)+1]] <- IdeogramTrack(chromosome=chr, genome=gen, fontsize=12)
    gene_list[[length(gene_list)+1]] <- GenomeAxisTrack(fontsize=12)
    gene_list[[length(gene_list)+1]] <- gene_track
  }
  gene_list <- unique(gene_list)
  return(gene_list)
}
