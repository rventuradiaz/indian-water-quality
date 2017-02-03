# This script is sourced in qlikview integration
# Prepare data for plotting heatmap using image function
prepare_data <- function(wq1){
  wq1 <- water.quality1
  require(devtools)
  require(cluster)
  wq1$QualityParameter = as.character(wq1$QualityParameter)
  wq1$Year <- as.character(wq1$Year)
  wq1$VillageName<- as.character(paste(wq1$VillageName, wq1$Year, sep = "-"))
  wq1["Arsenic"] <- 0
  wq1["Arsenic"] <- as.numeric(grepl("Arsenic",wq1$QualityParameter))*1
  wq1["Fluoride"] <- 0
  wq1["Fluoride"] <- as.numeric(grepl("Fluoride",wq1$QualityParameter))*2
  wq1["Iron"] <- 0
  wq1["Iron"] <- as.numeric(grepl("Iron",wq1$QualityParameter))*3
  wq1["Nitrate"] <- 0
  wq1["Nitrate"] <- as.numeric(grepl("Nitrate",wq1$QualityParameter))*4
  wq1["Salinity"] <- 0
  wq1["Salinity"] <- as.numeric(grepl("Salinity",wq1$QualityParameter))*5
wqArsenic <- aggregate(Arsenic ~ StateName +
                         DistrictName +
                         BlockName +
                         PanchayatName +
                         VillageName +
                         HabitationName +
                         Year,
                       data= wq1, sum )
wqFlouride <- aggregate(Fluoride ~ StateName +
                          DistrictName +
                          BlockName +
                          PanchayatName +
                          VillageName +
                          HabitationName +
                          Year,
                        data = wq1, sum )
wqIron <- aggregate(Iron ~ StateName +
                          DistrictName +
                          BlockName +
                          PanchayatName +
                          VillageName +
                          HabitationName +
                          Year, data=wq1, sum )
wqNitrate <- aggregate(Nitrate ~ StateName +
                      DistrictName +
                      BlockName +
                      PanchayatName +
                      VillageName +
                      HabitationName +
                      Year, data=wq1, sum )
wqSalinity <- aggregate(Salinity ~ StateName +
                         DistrictName +
                         BlockName +
                         PanchayatName +
                         VillageName +
                         HabitationName +
                         Year, data=wq1, sum )
wq1s <- merge(wqArsenic, wqFlouride)
wq1s <- merge(wq1s, wqIron)
wq1s <- merge(wq1s, wqNitrate)
wq1s <- merge(wq1s, wqSalinity)
wq1s["All"] <- wq1s[,8]+wq1s[,9]++wq1s[,10] +wq1s[,11] +wq1s[,12]  
wq1s <- wq1s[order(wq1s[,4], wq1s[,1], wq1s[2],  wq1s[3]), ]
tab_ready <- as.matrix(wq1s[,c(13)], ncol=5 )
class(tab_ready )<-"numeric"
is.na(tab_ready) <- sapply(tab_ready, is.infinite)
tab_ready[is.na(tab_ready)] <- 0
tab_ready[is.nan(tab_ready)] <- 0
rownames(tab_ready)<-as.character(wq1s[,"VillageName"])
return(tab_ready)
}