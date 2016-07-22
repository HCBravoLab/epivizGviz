# converts Gviz AnnotationTrack to Epiviz BlocksTrack

convertAnnotation <- function(app, track) {
  gr <- track@range
  name <- track@name
  anno_track <- app$plot(gr, datasource_name=name)
}
