
# This script is sourced in qlikview integration
library(cluster)

water.quality1$Quality.Parameter<-as.character(water.quality1$Quality.Parameter)
water.quality1$Village.Name<-as.character(paste(water.quality1$Village.Name, water.quality1$Year, sep = "-"))
water.quality1["Arsenic"]<-0
water.quality1["Arsenic"]<-as.numeric(grepl("Arsenic",water.quality1$Quality.Parameter))
water.quality1["Fluoride"]<-0
water.quality1["Fluoride"]<-as.numeric(grepl("Fluoride",water.quality1$Quality.Parameter))
water.quality1["Iron"]<-0
water.quality1["Iron"]<-as.numeric(grepl("Iron",water.quality1$Quality.Parameter))
water.quality1["Nitrate"]<-0
water.quality1["Nitrate"]<-as.numeric(grepl("Nitrate",water.quality1$Quality.Parameter))
water.quality1["Salinity"]<-0
water.quality1["Salinity"]<-as.numeric(grepl("Salinity",water.quality1$Quality.Parameter))
by1 = c("State.Name", "District.Name",   "Block.Name",      "Panchayat.Name",  "Village.Name","Habitation.Name","Year")
wqArsenic <- aggregate(Arsenic ~ State.Name + 
                         District.Name + 
                         Block.Name +
                         Panchayat.Name +
                         Village.Name +
                         Habitation.Name +
                         Year, 
                       data= water.quality1, sum )
wqFlouride <- aggregate(Fluoride ~ State.Name +
                          District.Name +
                          Block.Name +
                          Panchayat.Name +
                          Village.Name +
                          Habitation.Name +
                          Year, 
                        data = water.quality1, sum )
wqIron <- aggregate(Iron ~ State.Name + 
                          District.Name + 
                          Block.Name + 
                          Panchayat.Name + 
                          Village.Name + 
                          Habitation.Name +
                          Year, data=water.quality1, sum )
wqNitrate <- aggregate(Nitrate ~ State.Name + 
                      District.Name + 
                      Block.Name + 
                      Panchayat.Name + 
                      Village.Name + 
                      Habitation.Name +
                      Year, data=water.quality1, sum )
wqSalinity <- aggregate(Salinity ~ State.Name + 
                         District.Name + 
                         Block.Name + 
                         Panchayat.Name + 
                         Village.Name +
                         Habitation.Name +
                         Year, data=water.quality1, sum )
wq1s <- merge(wqArsenic, wqFlouride)
wq1s <- merge(wq1s, wqIron)
wq1s <- merge(wq1s, wqNitrate)
wq1s <- merge(wq1s, wqSalinity)
wq1s <- wq1s[order(wq1s[,4], wq1s[,1], wq1s[2],  wq1s[3]), ]
tab_ready <- as.matrix(wq1s[,c(9:13)], ncol=5 )
class(tab_ready )<-"numeric"
is.na(tab_ready) <- sapply(tab_ready, is.infinite)
tab_ready[is.na(tab_ready)] <- 0
tab_ready[is.nan(tab_ready)] <- 0
rownames(tab_ready)<-as.character(wqs[,"Village.Name"])
my_palette <- colorRampPalette(c("pink","blue" ))(256)
#Define custom dist and hclust functions for use with heatmaps
mydist=function(c) {dist(c,method="euclidean")}
myclust=function(c) {hclust(c,method="average")}
