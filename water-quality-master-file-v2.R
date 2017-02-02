# Source file to qlikview integration
library(devtools)
water.quality1<-read.csv(file="D:\\Dropbox\\R\\projects\\qlikview-integration\\qlikview-r-integration\\data\\ExportFile.csv",sep=";")
names(water.quality1)<-c( "State.Name","District.Name","Block.Name","Panchayat.Name","Village.Name","Habitation.Name","Year","Quality.Parameter")
source("water-quality-data-preparation-v3.R")



