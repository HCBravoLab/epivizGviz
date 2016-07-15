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

  # get ids, names, and measurements
  if (exists("track_list")) {rm(track_list, envir=globalenv())}
  chart_ids <- ls(envir=app$chart_mgr$.chart_list)
  for (id in chart_ids) {
    chart_obj <- app$chart_mgr$.get_chart_object(id)
    measurements <- chart_obj$.measurements
    for (ms in measurements) {
      # create gviz objects
      gr <- GRanges(app$data_mgr$.find_datasource(ms@datasourceId)$.object)
      gr_chr <- gr[which(seqnames(gr)==chr),]
      if (ms@defaultChartType=="GenesTrack") {
        genesToGeneRegion(grange=gr_chr, name=ms@datasourceId)
      } else if (ms@defaultChartType=="BlocksTrack") {
        blocksToAnnotation(grange=gr_chr, name=ms@datasourceId)
      } else if (ms@defaultChartType=="LineTrack") {
        lineToData(grange=gr_chr, name=ms@datasourceId)
      } else if (ms@defaultChartType=="StackedLineTrack") {
        stackedLineToData(grange=gr_chr, name=ms@datasorceId)
      }
    }
  }
  track_list <- unique(track_list)

  # adjust plot sizes
  if (exists("size")) {rm(size, envir=globalenv())}
  size <- list()
  for (track in track_list) {
    if (class(track)=="IdeogramTrack") {
      size[[length(size)+1]] <- 1
    } else if (class(track)=="GenomeAxisTrack") {
      size[[length(size)+1]] <- 2
    } else if (class(track)=="GeneRegionTrack") {
      size[[length(size)+1]] <- 4
    } else if (class(track)=="AnnotationTrack") {
      size[[length(size)+1]] <- 2
    } else if (class(track)=="DataTrack") {
      size[[length(size)+1]] <- 6
    }
  }

  # plot list of converted tracks
  plotTracks(track_list, from=start, to=end, sizes=size)
}

