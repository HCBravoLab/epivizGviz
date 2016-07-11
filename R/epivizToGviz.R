# Convert an existing epiviz workspace into a Gviz plot

epivizToGviz <- function(app) {

  # set up used parameters
  loc <- capture.output(app$get_current_location(show))
  chr <- strsplit(loc[9], "\"")[[1]][2]
  start <- as.numeric(strsplit(loc[12], " ")[[1]][2])
  end <- as.numeric(strsplit(loc[15], " ")[[1]][2])
  id <- app$chart_mgr$list_charts()$id
  meas <- strsplit(app$chart_mgr$list_charts()$measurements, ",")
  type <- app$chart_mgr$list_charts()$type
  track_names <- list()
  track_list <- list()

  # convert to Gviz objects
  for (y in 1:length(id)) {
    for (i in 1:length(meas[[y]])) {
      gr <- GRanges(app$get_ms_object(app$chart_mgr$list_charts()[[y,1]], index=i)$.object)
      assign(paste0("id_", y, "_", i, "_", chr), gr[which(seqnames(gr)==chr),])
    }
    for (i in 1:length(meas[[y]])) {
      if (type[y]=="epiviz.plugins.charts.GenesTrack") {
        assign(paste0("gene_track_", y, "_", i), GeneRegionTrack(get(paste0("id_", y, "_", i, "_", chr)),
          collapseTranscripts=TRUE, shape="arrow", chromosome=chr, name=meas[[y]][i]))
        track_names[[length(track_names)+1]] <- paste0("gene_track_", y, "_", i)
        gen <- get(paste0("gene_track_", y, "_", i))@genome
        track_list[[length(track_list)+1]] <- IdeogramTrack(genome=gen, chromosome=chr)
        track_list[[length(track_list)+1]] <- GenomeAxisTrack()
        track_list[[length(track_list)+1]] <- get(paste0("gene_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.BlocksTrack") {
          assign(paste0("anno_track_", y, "_", i), AnnotationTrack(get(paste0("id_", y, "_", i, "_", chr)),
            stacking="dense", shape="box", col=NULL, chromosome=chr, name=meas[[y]][i]))
          track_names[[length(track_names)+1]] <- paste0("anno_track_", y, "_", i)
          track_list[[length(track_list)+1]] <- get(paste0("anno_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.LineTrack") {
          assign(paste0("data_col_", i), GRanges(seqnames=seqnames(get(paste0("id_", y, "_", i, "_", chr))),ranges=ranges(get(paste0("id_", y, "_", i, "_", chr))),betas=mcols(get(paste0("id_", y, "_", i, "_", chr)))[i]))
          assign(paste0("data_track_", y, "_", i), DataTrack(get(paste0("data_col_", i)),
            type=c("p", "smooth"), chromosome=chr, name=meas[[y]][i]))
          track_names[[length(track_names)+1]] <- paste0("data_track_", y, "_", i)
          track_list[[length(track_list)+1]] <- get(paste0("data_track_", y, "_", i))
      }
     }
  }

  # plot outcome
  plotTracks(track_list, from=start, to=end, sizes=matrix(1,1,length(track_list)))
}
