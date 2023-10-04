
#=================================
# INSTALL HOMER AND DOWNLOAD DATA
#=================================

# install HOMER
conda install -c bioconda homer

# download the data 
wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE129nnn/GSE129314/suppl/GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt.gz

# unzip the data
gunzip GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt.gz

# take a look at the data 
cat GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | less

#=================
# FORMAT THE DATA 
#=================

# First get rid of the first few lines

# get the row number of the first line that we want
cat GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | grep -n ^chr | less

# get everything below this line (including this line)
cat GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | tail -n +30 | less

# select columns 1-3 and column 10 (that is the format that HOMER accepts)
cat GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | tail -n +30 | cut -f 1-3,10 | less

# save it to a new file
cat GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks.txt | tail -n +30 | cut -f 1-3,10 > GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks_homer.txt

#===========
# RUN HOMER
#===========

# run HOMER (find enriched motifs)
findMotifsGenome.pl GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks_homer.txt hg38 ../results/ -size 200

# Find in which peaks a specific motif appears (e.g. motif ranked 45 in the knownResults file)

# Method 1
findMotifsGenome.pl GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks_homer.txt hg38 ../results/ -find ../results/knownResults/known45.motif > ../results/motif_45_instances.txt

# Method 2
annotatePeaks.pl GSE129314_RUNX1ChIP_MCF10AOEq0.05_peaks_homer.txt hg38 -m ../results/knownResults/known45.motif > ../results/motif_45_instances_annotatePeak_method.txt