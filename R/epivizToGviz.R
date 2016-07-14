# convert an existing epiviz workspace into a Gviz plot

epivizToGviz <- function(app) {

  # callback for location
  loc <- NULL
  app$get_current_location(function(response) {
    if (response$success) {
      loc <<- response$value
    }})

  chr <- loc$seqName
  start <- loc$start
  end <- loc$end

  if (exists("track_list")) {
    rm(track_list, envir=globalenv())
  }

  # get ids, names, and measurements
  chart_ids <- ls(envir=app$chart_mgr$.chart_list)
  for (id in chart_ids) {
    chart_obj <- app$chart_mgr$.get_chart_object(id)
    measurements <- chart_obj$.measurements
    for (ms in measurements) {
      # create gviz objects
      gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
      gr_chr <- gr[which(seqnames(gr)==chr),]
      if (ms@defaultChartType=="GenesTrack") {
        genesToGeneRegion(grange=gr_chr, name=ms@name)
      } else if (ms@defaultChartType=="BlocksTrack") {
        blocksToAnnotation(grange=gr_chr, name=ms@name)
      } else if (ms@defaultChartType=="LineTrack") {
        lineToData(grange=gr_chr, name=strsplit(ms@datasourceId,"_")[[1]][1])
      } else if (ms@defaultChartType=="StackedLineTrack") {
        stackedLineToData(grange=gr_chr, name=strsplit(ms@datasourceId,"_")[[1]][1])
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
      size[i,1] <- 2
    } else if (class(track_list[[i]])=="GeneRegionTrack") {
      size[i,1] <- 4
    } else if (class(track_list[[i]])=="AnnotationTrack") {
      size[i,1] <- 2
    } else if (class(track_list[[i]])=="DataTrack") {
      size[i,1] <- 6
      }
    }

  # plot outcome
  plotTracks(unique(track_list), from=start, to=end, sizes=size)
  rm(track_list)
}

