# converts Epiviz GenesTrack to Gviz GeneRegionTrack

convertGenesTrack <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    gr_chr_plus <- gr_chr[which(strand(gr_chr)=="+"),]
    gr_chr_minus <- gr_chr[which(strand(gr_chr)=="-"),]
    name <- ms@datasourceId
    gene_track_plus <- GeneRegionTrack(gr_chr_plus, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=paste(name,"plus"))
    gen <- gene_track_plus@genome
    chr <- gene_track_plus@chromosome
    gene_track_minus <- GeneRegionTrack(gr_chr_minus, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=paste(name,"minus"))
    if (!exists("track_list")) {track_list <<- list()}
    track_list[[length(track_list)+1]] <<- IdeogramTrack(chromosome=chr, genome=gen)
    track_list[[length(track_list)+1]] <<- GenomeAxisTrack()
    track_list[[length(track_list)+1]] <<- gene_track_plus
    track_list[[length(track_list)+1]] <<- gene_track_minus
  }
}
