# converts Gviz DataTrack to Epiviz LineTrack

convertData <- function(app, track) {
  gr <- track@range
  data <- track@data
  mcols(gr) <- t(data)
  name <- track@name
  if (displayPars(track)$type=="smooth") {
    data_track <- app$plot(gr, datasource_name=name, type="bp", columns=colnames(mcols(gr)))
    data_track$set(settings=list(step=1, interpolation="basis"))
  } else if (displayPars(track)$type=="heatmap") {
    gr_ms <- app$data_mgr$add_measurements(gr, name)
    data_track <- app$chart_mgr$visualize("HeatmapPlot", datasource_name=gr_ms)
  }
}
