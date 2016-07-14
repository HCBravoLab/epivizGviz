# takes in StackedLineTrack epiviz chart object and returns DataTrack Gviz object

stackedLineToData <- function(grange, name) {

  data_track <- DataTrack(grange, groups=colnames(mcols(grange)), type=c("horizon"), chromosome=chr, name=name)
  displayPars(data_track) <- list(name=strpslit())
  if (!exists("track_list")) {
    track_list <<- list()
  }
  track_list[[length(track_list)+1]] <<- data_track
}
