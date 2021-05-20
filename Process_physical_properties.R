#!/usr/bin/env R


library(umap)
library(data.table)
library(ggplot2)
library(dplyr)

rm(list=setdiff(ls(), "masterfile"))

#args = commandArgs(trailingOnly=TRUE)
#name <- "bk"
#name <- "polio"
#name <- "covid"
#name <- "ebv"
#name <- "betaherpes_6a"
#name <- "herpes_1_17"
#name <- "herpes_2_hg52"
#name <- "herpes_6b"
name <- "cmv"




kmer <- "8mer"
load("~/Documents/Coding/Viral_binding_affinity_analysis/umap/pipeline_umap/umap_only_workspace_8mer")
std_dat_master <- std_dat
rm(std_dat)
setwd("~/Documents/Coding/Viral_binding_affinity_analysis/umap/pipeline_umap/")
#masterfile <- read.csv("master_peptide_umap.csv")
directories <- list.dirs(path = ".", full.names = TRUE, recursive = FALSE)[grep(name, list.dirs(path = ".", full.names = TRUE, recursive = FALSE))]
setwd(directories[1])
directories <- list.dirs(path = ".", full.names = TRUE, recursive = FALSE)
dir_select <- directories[grep(kmer, directories)]
setwd(dir_select)
pep_files <- list.files()

master <- data.frame(Peptide=character(), Allele=character(), bindstatus=character(), source=character())
#rm(plot_vals)
matrix_vals <- matrix(NA,nrow=0, ncol=10)
filenum <- 1


#grepl(basename, featurename)
featurename <- paste("../features/", pep_files[filenum],".features",sep="")
featurecsv <- read.csv(featurename)
basename <- basename(featurename)
basename <- substr(basename, 1,10)
newnum <- 0

for (filenum in 1:5)
{
  tempcsv <- read.csv(pep_files[filenum], header=FALSE)
  featurename <- paste("../features/", pep_files[filenum],".features",sep="")
  featurecsv <- read.csv(featurename)
  newnum <- filenum
  if(grepl(basename,featurename) == FALSE)
  {
    break
  }
  #tempfeatures <- read
  line <- unlist(strsplit(pep_files[filenum], '[.]'))
  allele <- line[1]
  bindstatus <- line[3]
  source <- line[4]
  if(dim(tempcsv)[1] <1)
  {
    next
  }
  std_dat <- predict(std_dat_master, featurecsv[,2:(dim(featurecsv)[2]-1)])
  matrix_vals <- rbind(matrix_vals,std_dat[,1:10])
  matrix <- data.frame(matrix(NA, nrow=dim(tempcsv)[1], ncol=4))
  colnames(matrix) <- c("peptide", "allele", "bindstatus", "source")
  matrix$peptide <- unlist(tempcsv)
  matrix$allele <- allele
  matrix$bindstatus <- bindstatus
  matrix$source <- source
  master <- rbind(master, matrix)
}

#std_dat_random <- load("std_dat")
temp <- cbind(master, matrix_vals)
temp <- temp %>% distinct()
temp <- temp[order(temp$peptide),]
temp <- temp[!duplicated(temp$peptide),]
#head(temp[,5:14])

pred <- predict(umap_vals, temp[,5:14])
mastertemp <- cbind(temp[,1:4], pred)



new_master <- data.frame(Peptide=character(), Allele=character(), bindstatus=character(), source=character())
#rm(plot_vals)
for (filenum in newnum:length(pep_files))
{
  tempcsv <- read.csv(pep_files[filenum], header=FALSE)
  #tempfeatures <- read
  line <- unlist(strsplit(pep_files[filenum], '[.]'))
  allele <- line[1]
  bindstatus <- line[3]
  source <- line[4]
  if(dim(tempcsv)[1] <1)
  {
    next
  }
  matrix <- data.frame(matrix(NA, nrow=dim(tempcsv)[1], ncol=4))
  colnames(matrix) <- c("peptide", "allele", "bindstatus", "source")
  matrix$peptide <- unlist(tempcsv)
  matrix$allele <- allele
  matrix$bindstatus <- bindstatus
  matrix$source <- source
  new_master <- rbind(new_master, matrix)
}

new_matrix_vals <- matrix(NA,nrow=nrow(new_master), ncol=2)
for (i in 1:nrow(new_matrix_vals))
{
  new_matrix_vals[i,1] <- mastertemp[mastertemp$peptide == new_master$peptide[i],][,5]
  new_matrix_vals[i,2] <- mastertemp[mastertemp$peptide == new_master$peptide[i],][,6]
}

new_mastertemp <- cbind(new_master, new_matrix_vals)
#mastertemp <- cbind(master, new_pred)
colnames(mastertemp) <-  c("Peptide", "allele", "bindstatus", "source", "X1", "X2")
colnames(new_mastertemp) <-  c("Peptide", "allele", "bindstatus", "source", "X1", "X2")

masterfile <- rbind(masterfile, mastertemp)
masterfile <- rbind(masterfile, new_mastertemp)
masterfile <- masterfile %>% distinct()

setwd("~/Documents/Coding/Viral_binding_affinity_analysis/umap/pipeline_umap/")
write.csv(masterfile, "master_peptide_umap.csv", row.names=FALSE)
#masterfile <- read.csv("master_peptide_umap.csv")


#masterfile_random <- masterfile[masterfile$source == "random",]
#write.csv(masterfile_random, "master_peptide_umap.csv", row.names=FALSE)



# prcomp(featurecsv[,2:(dim(featurecsv)[2]-2)], scale. = T)
#if(exists("plot_vals"))
#{
#  plot_vals <- rbind(plot_vals, data.frame(std_dat[,1:10]))
#} else{
#  plot_vals <- std_dat[,1:10]
#}
#temp <- cbind(master, matrix_vals)
#temp2 <- cbind(master, matrix_vals)
#temp3 <- cbind(master, matrix_vals)



#pred_copy <- pred
#master_file <- rbind(master_file, cbind(polio_summary[c(1,2)], pred))
#pred <- pred_copy

#master
#pred <- as.data.frame(pred) %>% mutate(allele=allele)
#pred <- pred %>% mutate(bindstatus=bindstatus)
#pred <- pred %>% mutate(source=source)
#pred <- pred %>% mutate(peptide=NA)
#pred <- pred[,c(6,3,4,5,1,2)]
#pred$peptide <- unlist(tempcsv)
#colnames(pred) <- c("Peptide", "allele", "bindstatus", "source", "X1", "X2")



#cwd <- getwd()
#newdir <- paste(cwd,sub('.', "", directories[1]),sep="")
#newdir <- paste(newdir,"/features",sep="")
#setwd(newdir)


#list_files <- list.files()

