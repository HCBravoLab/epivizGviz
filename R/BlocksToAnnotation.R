# converts Epiviz BlocksTrack to Gviz AnnotationTrack

blocksToAnnotation <- function(grange, name) {
  if (!exists("track_list")) {track_list <<- list()}
  track_list[[length(track_list)+1]] <<- AnnotationTrack(grange, stacking="dense", shape="box", col=NULL, chromosome=chr, name=name)
}
