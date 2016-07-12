# Convert an existing epiviz workspace into a Gviz plot

epivizToGviz <- function(app) {

  # set up used parameters
  loc <- capture.output(app$get_current_location(show))
  chr <- strsplit(loc[9], "\"")[[1]][2]
  start <- as.numeric(strsplit(loc[12], " ")[[1]][2])
  end <- as.numeric(strsplit(loc[15], " ")[[1]][2])
  id <- app$chart_mgr$list_charts()$id
  name <- strsplit(app$chart_mgr$list_charts()$measurements, ",")
  type <- app$chart_mgr$list_charts()$type
  track_list <- list()

  # convert to Gviz objects
  for (y in 1:length(id)) {
    for (i in 1:length(name[[y]])) {
      name[[y]][i] <- strsplit(name[[y]], "_")[[i]][1]
      gr <- GRanges(app$get_ms_object(app$chart_mgr$list_charts()[[y,1]], index=i)$.object)
      assign(paste0("id_", y, "_", i, "_", chr), gr[which(seqnames(gr)==chr),])
    }
    for (i in 1:length(name[[y]])) {
      if (type[y]=="epiviz.plugins.charts.GenesTrack") {
        assign(paste0("gene_track_", y, "_", i), GeneRegionTrack(get(paste0("id_", y, "_", i, "_", chr)),
          collapseTranscripts=TRUE, stacking="full", transcriptAnnotation="gene", shape="arrow", chromosome=chr, name=name[[y]][i]))
        gen <- get(paste0("gene_track_", y, "_", i))@genome
        track_list[[length(track_list)+1]] <- IdeogramTrack(genome=gen, chromosome=chr)
        track_list[[length(track_list)+1]] <- GenomeAxisTrack()
        track_list[[length(track_list)+1]] <- get(paste0("gene_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.BlocksTrack") {
          assign(paste0("anno_track_", y, "_", i), AnnotationTrack(get(paste0("id_", y, "_", i, "_", chr)),
            stacking="dense", shape="box", col=NULL, chromosome=chr, name=name[[y]][i]))
          track_list[[length(track_list)+1]] <- get(paste0("anno_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.LineTrack") {
          assign(paste0("data_track_", y, "_", i), DataTrack(get(paste0("id_", y, "_", i, "_", chr)), groups=colnames(mcols(get(paste0("id_", y, "_", i, "_", chr)))), type=c("smooth"), chromosome=chr, name=name[[y]][i]))
          track_list[[length(track_list)+1]] <- get(paste0("data_track_", y, "_", i))
      } else if (type[y]=="epiviz.plugins.charts.StackedLineTrack") {
        assign(paste0("stac_track_", y, "_", i), DataTrack(get(paste0("id_", y, "_", i, "_", chr)), groups=colnames(mcols(get(paste0("id_", y, "_", i, "_", chr)))),
                                                           type=c("horizon"), chromosome=chr, name=name[[y]][i]))
        track_list[[length(track_list)+1]] <- get(paste0("data_track_", y, "_", i))
      }
     }
  }

  # adjust plot sizes
  track_list <- unique(track_list)
  size <- matrix(nrow=length(track_list), ncol=1)
  for (i in 1:length(unique(track_list))) {
    if (class(track_list[[i]])=="IdeogramTrack") {
      size[i,1] <- 1
    } else if (class(track_list[[i]])=="GenomeAxisTrack") {
      size[i,1] <- 1
    } else if (class(track_list[[i]])=="GeneRegionTrack") {
      size[i,1] <- 3
    } else if (class(track_list[[i]])=="AnnotationTrack") {
      size[i,1] <- 1
    } else if (class(track_list[[i]])=="DataTrack") {
      size[i,1] <- 5
      }
    }

  # plot outcome
  plotTracks(unique(track_list), from=start, to=end, sizes=size)
}

