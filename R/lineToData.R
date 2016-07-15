# converts Epiviz LineTrack to Gviz DataTrack

lineToData <- function(grange, name) {
  if (!exists("track_list")) {track_list <<- list()}
  track_list[[length(track_list)+1]] <<- DataTrack(grange, groups=colnames(mcols(grange)), type=c("smooth"), chromosome=chr, name=name)
}
