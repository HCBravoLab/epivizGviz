# takes in BlocksTrack epiviz chart object and returns AnnotationTrack Gviz object

blocksToAnnotation <- function(grange, name) {

  anno_track <- AnnotationTrack(grange, stacking="dense", shape="box", col=NULL, chromosome=chr, name=name)
  if (!exists("track_list")) {
    track_list <<- list()
  }
  track_list[[length(track_list)+1]] <<- anno_track
}
