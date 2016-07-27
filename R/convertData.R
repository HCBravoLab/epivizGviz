# converts Gviz DataTrack to Epiviz LineTrack

convertData <- function(app, track) {
  gr <- track@range
  data <- track@data
  name <- track@name
  exprs <- t(as.matrix(data))
  rse <- SummarizedExperiment(assays=exprs, rowRanges=gr)
  rse_ms <- app$data_mgr$add_measurements(rse, name)
  if (displayPars(track)$type=="heatmap" || displayPars(track)$type=="gradient") {
    data_track <- app$chart_mgr$visualize("HeatmapPlot", datasource=rse_ms)
  } else if (displayPars(track)$type=="p") {
    data_track <- app$chart_mgr$visualize("ScatterPlot", datasource=rse_ms)
  } else if (displayPars(track)$type=="histogram") {
    data_track <- app$chart_mgr$visualize("StackedLineTrack", datasource=rse_ms)
  } else {
    data_track <- app$chart_mgr$visualize("LineTrack", datasource=rse_ms)
    data_track$set(settings=list(step=1, interpolation="basis"))
  }
}
