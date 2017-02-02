
library(gplots)
library(car)
library(devtools)

#Load latest version of heatmap.3 function
source_url("https://raw.githubusercontent.com/obigriffith/biostar-tutorials/master/Heatmaps/heatmap.3.R")

# hm<- heatmap.2(scaled, # specify the (scaled) data to be used in the heatmap
#                        cexRow=0.5, cexCol=0.95, # decrease font size of row/column labels
#                        scale="none", # we have already scaled the data
#                        trace=c("none")) # cleaner heatmap

        # Use color brewer
        library(RColorBrewer)
        main_title="W. quality for State"
        par(cex.main=1)
        # windows() ## create window to plot your file
        pdf(file = paste("Rplots_01",".pdf", sep = ""))        
        heatmap.3(x = tab_ready,               # specify the (scaled) data to be used in the heatmap
                  hclustfun=myclust, 
                  distfun=mydist,
                        cexRow=0.5, 
                        cexCol=0.95,          # decrease font size of row/column labels
                        col = my_palette,    # arguments to read in custom colors
                        #          colsep=c(2,3,4), # Adding on the separators that will clarify plot even more
                        #          rowsep = c(6,14,18,25,30,36,42,47), 
                        sepcolor="black", 
                        sepwidth=c(0.01,0.01),  
                        scale="none",         # we have already scaled the data 
                        dendrogram="both",    # no need to see dendrograms in this one 
                        margins=c(6,12),
                  Rowv=TRUE,
                  Colv=TRUE,
                        trace="none", # cleaner heatmap
                  main = main_title

                        )
        


        