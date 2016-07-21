# converts Epiviz GenesTrack to Gviz GeneRegionTrack

convertGenes <- function(app, chart_obj, chr) {
  measurements <- chart_obj$.measurements
  for (ms in measurements) {
    gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
    gr_chr <- gr[which(seqnames(gr)==chr),]
    gr_chr_plus <- gr_chr[which(strand(gr_chr)=="+"),]
    gr_chr_minus <- gr_chr[which(strand(gr_chr)=="-"),]
    name <- ms@datasourceId
    gene_track_plus <- GeneRegionTrack(gr_chr_plus, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name=name, fontsize=12)
    gen <- gene_track_plus@genome
    chr <- gene_track_plus@chromosome
    gene_track_minus <- GeneRegionTrack(gr_chr_minus, collapseTranscripts=TRUE, stacking="dense", transcriptAnnotation="symbol", shape="arrow", chromosome=chr, name="", fontsize=12)
    if (!exists("gene_list")) {gene_list <- list()}
    gene_list[[length(gene_list)+1]] <- IdeogramTrack(chromosome=chr, genome=gen, fontsize=12)
    gene_list[[length(gene_list)+1]] <- GenomeAxisTrack(fontsize=12)
    gene_list[[length(gene_list)+1]] <- gene_track_plus
    gene_list[[length(gene_list)+1]] <- gene_track_minus
  }
  gene_list <- unique(gene_list)
}
