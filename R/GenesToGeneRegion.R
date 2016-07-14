# takes in GenesTrack epiviz chart object and returns GeneRegionTrack Gviz object

genesToGeneRegion <- function(grange, name) {

  gene_track <- GeneRegionTrack(grange, collapseTranscripts=TRUE, stacking="full", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=name)
  gen <- gene_track@genome
  if (!exists("track_list")) {
    track_list <<- list()
  }
  track_list[[length(track_list)+1]] <<- IdeogramTrack(genome=gen, chromosome=chr)
  track_list[[length(track_list)+1]] <<- GenomeAxisTrack()
  track_list[[length(track_list)+1]] <<- gene_track
  track_list <<- unique(track_list)
}

