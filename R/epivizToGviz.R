# convert an existing Epiviz workspace into a Gviz plot

epivizToGviz <- function(app, plot_tracks=TRUE) {

  # callback for location
  loc <- NULL
  app$get_current_location(function(response) {
    if (response$success) {
      loc <<- response$value
    }})

  chr <- loc$seqName
  start <- loc$start
  end <- loc$end

  # get chart ids and chart objects
  track_list <- list()
  chart_ids <- ls(envir=app$chart_mgr$.chart_list)
  for (id in chart_ids) {
    chart_obj <- app$chart_mgr$.get_chart_object(id)
    type <- chart_obj$.type
    # create gviz objects
    if (type=="epiviz.plugins.charts.GenesTrack") {
      track_list[[length(track_list)+1]] <- convertGenes(app=app, chart_obj=chart_obj, chr=chr)
    } else if (type=="epiviz.plugins.charts.BlocksTrack") {
      track_list[[length(track_list)+1]] <- convertBlocks(app=app, chart_obj=chart_obj, chr=chr)
    } else if (type=="epiviz.plugins.charts.LineTrack" || type=="epiviz.plugins.charts.LinePlot") {
      track_list[[length(track_list)+1]] <- convertLine(app=app, chart_obj=chart_obj, chr=chr)
    } else if (type=="epiviz.plugins.charts.StackedLineTrack" || type=="epiviz.plugins.charts.StackedLinePlot") {
      track_list[[length(track_list)+1]] <- convertStackedLine(app=app, chart_obj=chart_obj, chr=chr)
    } else if (type=="epiviz.plugins.charts.HeatmapPlot") {
      track_list[[length(track_list)+1]] <- convertHeatmap(app=app, chart_obj=chart_obj, chr=chr)
    } else if (type=="epiviz.plugins.charts.ScatterPlot") {
      track_list[[length(track_list)+1]] <- convertScatter(app=app, chart_obj=chart_obj, chr=chr)
    }
  }
  track_list <- unique(unlist(track_list))

  # adjust plot sizes
  size <- list()
  for (track in track_list) {
    if (class(track)=="IdeogramTrack") {
      size[[length(size)+1]] <- 1
    } else if (class(track)=="GenomeAxisTrack") {
      size[[length(size)+1]] <- 2
    } else if (class(track)=="GeneRegionTrack") {
      size[[length(size)+1]] <- 1
    } else if (class(track)=="AnnotationTrack") {
      size[[length(size)+1]] <- 2
    } else if (class(track)=="DataTrack") {
      size[[length(size)+1]] <- 6
    }
  }

  # plot list of converted tracks
  if (plot_tracks==TRUE) {
  plotTracks(track_list, from=start, to=end, sizes=size)
  }

  return(track_list)
}
