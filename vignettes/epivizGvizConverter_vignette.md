---
title: "epivizGvizConverter User Guide"
author: "Morgan Walter"
date: "2016-07-19"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteIndexEntry{epivizGvizConverter User Guide}
  %\VignetteEncoding{UTF-8}
---

The `epivizGvizConverter` package in R relies on the `epivizrStandalone` and `Gviz` packages available in Bioconductor. Its purpose is to reconstruct Epiviz workspaces created using the epivizr packages into plots formed by the Gviz package. In this vignette, we download data from the `workshopBioc2016` and `bioc2016Addendum` packages. The data sets to be visualized include Gene Expression Barcode data, 450k Illumina Human Methylation data, and gene annotations to go along with them. 


```r
library(workshopBioc2016)
```

```
## Loading required package: epivizr
```

```
## Warning: multiple methods tables found for 'which.max'
```

```
## Warning: multiple methods tables found for 'which.min'
```

```
## Warning: multiple methods tables found for 'which'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'GenomicRanges'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'GenomicRanges'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'GenomicRanges'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'GenomeInfoDb'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'GenomeInfoDb'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'GenomeInfoDb'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'XVector'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'XVector'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'XVector'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'AnnotationDbi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'AnnotationDbi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'AnnotationDbi'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'GenomicFeatures'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'GenomicFeatures'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'GenomicFeatures'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'Biostrings'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'Biostrings'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'Biostrings'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'rtracklayer'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'rtracklayer'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'rtracklayer'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'GenomicAlignments'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'GenomicAlignments'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'GenomicAlignments'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'SummarizedExperiment'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'SummarizedExperiment'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'SummarizedExperiment'
```

```
## Warning: multiple methods tables found for 'arbind'
```

```
## Warning: multiple methods tables found for 'acbind'
```

```
## Warning: replacing previous import 'IRanges::arbind' by
## 'SummarizedExperiment::arbind' when loading 'GenomicAlignments'
```

```
## Warning: replacing previous import 'IRanges::acbind' by
## 'SummarizedExperiment::acbind' when loading 'GenomicAlignments'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'OrganismDbi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'OrganismDbi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'OrganismDbi'
```

```
## Warning: replacing previous import 'IRanges::arbind' by
## 'SummarizedExperiment::arbind' when loading 'epivizrData'
```

```
## Warning: replacing previous import 'IRanges::acbind' by
## 'SummarizedExperiment::acbind' when loading 'epivizrData'
```

```
## Loading required package: minfi
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
## 
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, append, as.data.frame, cbind, colnames,
##     do.call, duplicated, eval, evalq, Filter, Find, get, grep,
##     grepl, intersect, is.unsorted, lapply, lengths, Map, mapply,
##     match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     Position, rank, rbind, Reduce, rownames, sapply, setdiff,
##     sort, table, tapply, union, unique, unsplit, which, which.max,
##     which.min
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
## 
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: lattice
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
## 
## Attaching package: 'S4Vectors'
```

```
## The following objects are masked from 'package:base':
## 
##     colMeans, colSums, expand.grid, rowMeans, rowSums
```

```
## Loading required package: IRanges
```

```
## Loading required package: GenomeInfoDb
```

```
## Loading required package: SummarizedExperiment
```

```
## 
## Attaching package: 'SummarizedExperiment'
```

```
## The following objects are masked from 'package:IRanges':
## 
##     acbind, arbind
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
## Loading required package: bumphunter
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: locfit
```

```
## locfit 1.5-9.1 	 2013-03-22
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'bumphunter'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'bumphunter'
```

```
## Warning: replacing previous import 'BiocGenerics::which' by
## 'IRanges::which' when loading 'minfi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.min' by
## 'IRanges::which.min' when loading 'minfi'
```

```
## Warning: replacing previous import 'BiocGenerics::which.max' by
## 'IRanges::which.max' when loading 'minfi'
```

```
## Warning: replacing previous import 'SummarizedExperiment::acbind' by
## 'IRanges::acbind' when loading 'minfi'
```

```
## Warning: replacing previous import 'SummarizedExperiment::arbind' by
## 'IRanges::arbind' when loading 'minfi'
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

```r
library(bioc2016Addendum)
data(meth_set)
data(gm_set)
data(gratio_set)
data(cgi_gr)
data(bcode_eset)
```

You can also embed plots, for example:

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)


library(workshopBioc2016)
data(meth_set)
data(gm_set)
data(gratio_set)
library(epivizrStandalone)
library(Homo.sapiens)

app <- startStandalone(Homo.sapiens, keep_seqlevels=paste0("chr",c(10,11,20)), chr="chr11", port=7350)

library(GenomicFeatures)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
promoter_regions <- promoters(TxDb.Hsapiens.UCSC.hg19.knownGene,upstream=1000,
           downstream=200)
promoters_track <- app$plot(promoter_regions,datasource_name="Promoters")

# first subset to breast samples
gratio_set_breast <- gratio_set[,which(gratio_set$Tissue=="breast")]

# make a design matrix to use with bumphunter
status <- pData(gratio_set_breast)$Status
mod <- model.matrix(~status)

# cluster cpgs into regions holding potential dmrs
gr <- granges(gratio_set_breast)
chr <- as.factor(seqnames(gr))
pos <- start(gr)
cl <- clusterMaker(chr, pos, maxGap=500)

# find dmrs
bumps <- bumphunter(gratio_set_breast, mod, cluster=cl, cutoff=0.1, B=0)

# categorize dmrs by type
dmr_gr <- with(bumps$table, GRanges(chr, IRanges(start,end), area=area, value=value))
dmr_gr$type <- ifelse(abs(dmr_gr$value) < 0.1, "neither",
                      ifelse(dmr_gr$value<0, "hypo", "hyper"))
table(dmr_gr$type)

# make a GRanges object for each dmr type
hyper_gr <- dmr_gr[dmr_gr$type == "hyper"]
hypo_gr <- dmr_gr[dmr_gr$type == "hypo"]

# add each of these as a datasource on epiviz
hypo_ds <- app$data_mgr$add_measurements(hypo_gr, "Hypo DMRs")
hyper_ds <- app$data_mgr$add_measurements(hyper_gr, "Hyper DMRs")

# add the track
measurements <- c(hypo_ds$get_measurements(), hyper_ds$get_measurements())
dmr_track <- app$chart_mgr$visualize("BlocksTrack", measurements = measurements)

betas <- getBeta(gratio_set)
pd <- pData(gratio_set)
fac <- paste(pd$Tissue, pd$Status, sep=":")
sample_indices <- split(seq(len=nrow(pd)), fac)

mean_betas <- sapply(sample_indices, function(ind) rowMeans(betas[,ind]))

cpg_gr <- granges(gm_set)
mcols(cpg_gr) <- mean_betas
beta_track <- app$plot(cpg_gr,datasource_name="Percent Methylation",type="bp", settings=list(step=1, interpolation="basis"))

give gviz example

<!-- rmarkdown v1 -->
![Gviz Plot](images/gviz_pic.PNG)




