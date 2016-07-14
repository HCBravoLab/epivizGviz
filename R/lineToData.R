# takes in LineTrack epiviz chart object and returns DataTrack Gviz object

lineToData <- function(grange, name) {

  data_track <- DataTrack(grange, groups=colnames(mcols(grange)), type=c("smooth"), chromosome=chr, name=name)
  if (!exists("track_list")) {
    track_list <<- list()
  }
  track_list[[length(track_list)+1]] <<- data_track
}
