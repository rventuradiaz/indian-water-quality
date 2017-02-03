# This script is sourced in qlikview integration
# Prepare data for plotting heatmap using image function
prepare_data <- function(water.quality1){
  require(devtools)
  require(cluster)
  water.quality1$QualityParameter = as.character(water.quality1$QualityParameter)
  water.quality1$Year <- as.character(water.quality1$Year)
  water.quality1$VillageName<- as.character(paste(water.quality1$VillageName, water.quality1$Year, sep = "-"))
  water.quality1["Arsenic"] <- 0
  water.quality1["Arsenic"] <- as.numeric(grepl("Arsenic",water.quality1$QualityParameter))*1
  water.quality1["Fluoride"] <- 0
  water.quality1["Fluoride"] <- as.numeric(grepl("Fluoride",water.quality1$QualityParameter))*2
  water.quality1["Iron"] <- 0
  water.quality1["Iron"] <- as.numeric(grepl("Iron",water.quality1$QualityParameter))*3
  water.quality1["Nitrate"] <- 0
  water.quality1["Nitrate"] <- as.numeric(grepl("Nitrate",water.quality1$QualityParameter))*4
  water.quality1["Salinity"] <- 0
  water.quality1["Salinity"] <- as.numeric(grepl("Salinity",water.quality1$QualityParameter))*5
wqArsenic <- aggregate(Arsenic ~ StateName +
                         DistrictName +
                         BlockName +
                         PanchayatName +
                         VillageName +
                         HabitationName +
                         Year,
                       data= water.quality1, sum )
wqFlouride <- aggregate(Fluoride ~ StateName +
                          DistrictName +
                          BlockName +
                          PanchayatName +
                          VillageName +
                          HabitationName +
                          Year,
                        data = water.quality1, sum )
wqIron <- aggregate(Iron ~ StateName +
                          DistrictName +
                          BlockName +
                          PanchayatName +
                          VillageName +
                          HabitationName +
                          Year, data=water.quality1, sum )
wqNitrate <- aggregate(Nitrate ~ StateName +
                      DistrictName +
                      BlockName +
                      PanchayatName +
                      VillageName +
                      HabitationName +
                      Year, data=water.quality1, sum )
wqSalinity <- aggregate(Salinity ~ StateName +
                         DistrictName +
                         BlockName +
                         PanchayatName +
                         VillageName +
                         HabitationName +
                         Year, data=water.quality1, sum )
WqAll <- aggregate(Arsenic+Flouride+Iron+Nitrate+Salinity ~ StateName +
                     DistrictName +
                     BlockName +
                     PanchayatName +
                     VillageName +
                     HabitationName +
                     Year, data=water.quality1, sum )
wq1s <- merge(wqArsenic, wqFlouride)
wq1s <- merge(wq1s, wqIron)
wq1s <- merge(wq1s, wqNitrate)
wq1s <- merge(wq1s, wqSalinity)
wq1s <- merge(wq1s, WqAll)
wq1s <- wq1s[order(wq1s[,4], wq1s[,1], wq1s[2],  wq1s[3]), ]
tab_ready <- as.matrix(wq1s[,c(13)], ncol=5 )
class(tab_ready )<-"numeric"
is.na(tab_ready) <- sapply(tab_ready, is.infinite)
tab_ready[is.na(tab_ready)] <- 0
tab_ready[is.nan(tab_ready)] <- 0
rownames(tab_ready)<-as.character(wq1s[,"VillageName"])
return(tab_ready)
}