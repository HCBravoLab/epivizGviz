# converts Epiviz GenesTrack to Gviz GeneRegionTrack

convertGenesTrack <- function(grange, chr, chart=NULL, name) {
  if (!is.null(chart)) {
    measurements <- chart$.measurements
    for (ms in measurements) {
      gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
      grange <- gr[which(seqnames(gr)==chr),]
      name <- ms@datasourceId
    }
  }
  grange
  gene_track <- GeneRegionTrack(grange, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=name)
  gen <- gene_track@genome
  chr <- gene_track@chromosome
  if (!exists("track_list")) {track_list <<- list()}
  track_list[[length(track_list)+1]] <<- IdeogramTrack(chromosome=chr, genome=gen)
  track_list[[length(track_list)+1]] <<- GenomeAxisTrack()
  track_list[[length(track_list)+1]] <<- gene_track
}
