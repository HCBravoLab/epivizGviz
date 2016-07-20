# converts Epiviz GenesTrack to Gviz GeneRegionTrack

convertGenesTrack <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    name <- ms@datasourceId
    gene_track <- GeneRegionTrack(gr_chr, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=name)
    gen <- gene_track@genome
    chr <- gene_track@chromosome
    if (!exists("track_list")) {track_list <<- list()}
    track_list[[length(track_list)+1]] <<- IdeogramTrack(chromosome=chr, genome=gen)
    track_list[[length(track_list)+1]] <<- GenomeAxisTrack()
    track_list[[length(track_list)+1]] <<- gene_track
  }
}
