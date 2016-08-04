# replot existing Epiviz workspace

restartEpiviz <- function(file=NULL) {

  # check arguments
  if (!file.exists(file)) {
    stop("File does not exist")
  }

  # load EpivizApp object
  load(file=file)
  saved_app <- app

  # start new workspace
  app$server$start_server()
  app$.open_browser()
  app$service()

  # add charts to workspace
  chart_ids <- ls(envir=saved_app$chart_mgr$.chart_list)
  for (id in chart_ids) {
    chart_obj <- saved_app$chart_mgr$.get_chart_object(id)
    app$chart_mgr$add_chart(chart_obj)
  }
}
