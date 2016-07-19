# converts Epiviz GenesTrack to Gviz GeneRegionTrack

convertGenesTrack <- function(grange, name) {
  gene_track <- GeneRegionTrack(grange, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=name)
  gen <- gene_track@genome
  if (!exists("track_list")) {track_list <<- list()}
  track_list[[length(track_list)+1]] <<- IdeogramTrack(genome=gen, chromosome=chr)
  track_list[[length(track_list)+1]] <<- GenomeAxisTrack()
  track_list[[length(track_list)+1]] <<- gene_track
}

