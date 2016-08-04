# save EpivizApp representation of a workspace into a ".RData" file

saveEpiviz <- function(app, file, stop_server=TRUE) {

  # check arguments
  if (!is(app, "EpivizApp")) {
    stop("'app' must be an 'EpivizApp' object")
  }
  if (!file.exists(file)) {
    stop("File does not exist")
  }

  # save current location on the app
  if (app$is_server_closed()) {
    stop("The server for 'app' is closed")
  }
  loc <- NULL
  app$get_current_location(function(response) {
    if (response$success) {
      loc <<- response$value
    }})
  app$.url_parms$chr <- loc$seqName
  app$.url_parms$start <- loc$start
  app$.url_parms$end <- loc$end

  # save app to file
  save(app, file=file)

  #close server so app can be restarted
  if (stop_server==TRUE) {
    app$server$stop_server()
  }
}
