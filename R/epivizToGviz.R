# Convert an existing epiviz workspace into a Gviz plot

epivizToGviz <- function(app, gen, chr, start, end) {

  # set up used parameters
  #chr <- "chr11"
  #gen <- "hg19"
  #start <- 2140953
  #end <- 2181411
  id <- app$chart_mgr$list_charts()$id
  meas <- strsplit(app$chart_mgr$list_charts()$measurements, ",")
  type <- app$chart_mgr$list_charts()$type

  # create data objects
  for (y in 1:length(id)) {
    for (i in 1:length(meas[[y]])) {
      gr <- GRanges(app$get_ms_object(app$chart_mgr$list_charts()[[y,1]], index=i)$.object)
      assign(paste0("id_", y, "_", i, "_", chr), gr[which(seqnames(gr)==chr),])
   }
  }

  # convert to Gviz objects
  for (y in 1:length(id)) {
    for (i in 1:length(meas[[y]])) {
      if (type[y]=="epiviz.plugins.charts.GenesTrack") {
        assign(paste0("gene_track_", y, "_", i), GeneRegionTrack(get(paste0("id_", y, "_", i, "_", chr)),
          collapseTranscripts=TRUE, shape="arrow", chromosome=chr, genome=gen, name=meas[[y]][i]))
      } else if (type[y]=="epiviz.plugins.charts.BlocksTrack") {
          assign(paste0("anno_track_", y, "_", i), AnnotationTrack(get(paste0("id_", y, "_", i, "_", chr)),
            stacking="dense", shape="box", col=NULL, chromosome=chr, genome=gen, name=meas[[y]][i]))
      } else if (type[y]=="epiviz.plugins.charts.LineTrack") {
          assign(paste0("data_track_", y, "_", i), DataTrack(get(paste0("id_", y, "_", i, "_", chr)),
            type=c("p", "smooth"), chromosome=chr, genome=gen, name=meas[[y]][i]))
      }
     }
   }
  chr_track <- IdeogramTrack(genome=gen,chromosome=chr)
  axis_track <- GenomeAxisTrack()


  # plot outcome
  tracks_list <- list()
  for (y in 1:length(id)) {
    for (i in 1:length(meas[[y]])) {
      if (type[y]=="epiviz.plugins.charts.GenesTrack") {
        tracks_list[[length(tracks_list)+1]] <- get(paste0("gene_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.BlocksTrack") {
        tracks_list[[length(tracks_list)+1]] <- get(paste0("anno_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.LineTrack") {
        tracks_list[[length(tracks_list)+1]] <- get(paste0("data_track_", y, "_", i))
      }
    }
  }
  plotTracks(tracks_list, from=start, to=end, sizes=matrix(1,1,length(tracks_list)))
}
