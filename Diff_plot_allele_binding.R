
library(MASS)
setwd("~/Documents/Coding/Viral_binding_affinity_analysis/umap/pipeline_umap/")
masterfile <- read.csv("master_peptide_umap.csv")

allele1 <- masterfile[masterfile$allele == "HLA-A01:01",]
allele1 <- allele1[is.na(allele1$X1) != 1,]
allele1 <- allele1[is.na(allele1$X2) != 1,]

xrange <- range(as.numeric(masterfile$X1), na.rm=TRUE)
yrange <- range(as.numeric(masterfile$X2), na.rm=TRUE)


d1 = kde2d(masterfile[masterfile$source == "random",]$X1, masterfile[masterfile$source == "random",]$X2, lims=c(xrange, yrange), n=50)
d2 = kde2d(masterfile[masterfile$source == "covid_scores",]$X1, masterfile[masterfile$source == "covid_scores",]$X2, lims=c(xrange, yrange), n=50)
d3 <- d1
d3$z <- d2$z-d1$z
levels <- pretty(c(-1,1)*max(abs(range(d3$z))),n=25)
filled.contour(d1$x,d1$y,d3$z, plot.title = "Covid vs herpes",levels=levels,col=colorRampPalette(c("blue", "white","red"))(length(levels)))


#####
xrange <- range(as.numeric(allele_diff$X1), na.rm=TRUE)
yrange <- range(as.numeric(allele_diff$X2), na.rm=TRUE)


d1 = kde2d(allele1[allele1$source == "covid_scores",]$X1, allele1[allele1$source == "covid_scores",]$X2, lims=c(xrange, yrange), n=50)
d2 = kde2d(allele1[allele1$source == "herpes_6b_scores",]$X1, allele1[allele1$source == "herpes_6b_scores",]$X2, lims=c(xrange, yrange), n=50)
d3 <- d1
d3$z <- d2$z-d1$z
levels <- pretty(c(-1,1)*max(abs(range(d3$z))),n=25)
filled.contour(d1$x,d1$y,d3$z, plot.title = "Covid vs herpes",levels=levels,col=colorRampPalette(c("blue", "white","red"))(length(levels)))


##By scores
d1 = kde2d(allele1[allele1$bindstatus == "500",]$X1, allele1[allele1$bindstatus == "500",]$X2, lims=c(xrange, yrange), n=50)
d2 = kde2d(allele1[allele1$bindstatus == "500plus",]$X1, allele1[allele1$bindstatus == "500plus",]$X2, lims=c(xrange, yrange), n=50)
d3 <- d1
d3$z <- d2$z-d1$z
levels <- pretty(c(-1,1)*max(abs(range(d3$z))),n=25)
filled.contour(d1$x,d1$y,d3$z, levels=levels,col=colorRampPalette(c("blue", "white","red"))(length(levels)))


##By allele
allele_diff <- masterfile[masterfile$bindstatus == "50",]
allele_diff <- allele_diff[is.na(allele_diff$X1) != 1,]
allele_diff <- allele_diff[is.na(allele_diff$X2) != 1,]


xrange <- range(as.numeric(allele_diff$X1), na.rm=TRUE)
yrange <- range(as.numeric(allele_diff$X2), na.rm=TRUE)

d1 = kde2d(allele_diff[allele_diff$allele == "HLA-A01:01",]$X1, allele_diff[allele_diff$allele == "HLA-A01:01",]$X2, lims=c(xrange, yrange), n=50)
d2 = kde2d(allele_diff[allele_diff$allele == "HLA-A02:01",]$X1, allele_diff[allele_diff$allele == "HLA-A02:01",]$X2, lims=c(xrange, yrange), n=50)
d3 <- d1
d3$z <- d2$z-d1$z
levels <- pretty(c(-1,1)*max(abs(range(d3$z))),n=25)
filled.contour(d1$x,d1$y,d3$z, levels=levels,col=colorRampPalette(c("blue", "white","red"))(length(levels)))




#######TEST

#masterfile2 <- masterfile[masterfile$source != "cmv_scores",]

#cmv <- masterfile[masterfile$source == "cmv_scores",]
#cmv[cmv$peptide=="HSVETLPA" && cmv$allele=="HLA-C18:02",]
#weird <- masterfile[masterfile$peptide=="VTFSNVAT" && masterfile$allele=="HLA-C18:02",]

