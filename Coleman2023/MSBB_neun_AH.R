## This script loads, analyzes, and plots RNAseq differential expression

library(readxl) #loads library for reading excel files
library(tidyverse) #loads tidyverse library
library(DESeq2) #loads DESeq2
library(pheatmap)

setwd("D:/Data/Wainger_Lab/RNA/MSBB/neun_fromBams/gtf_DESeq2")
excelsheet = "msbb_neun_gtfreadcounts_AH231119.xlsx"

#import dataset
genecounts <- read_excel(excelsheet, sheet =1, col_names = TRUE) #loads data from excel
genecounts <- as.data.frame(genecounts) #turns tibble output from above into data.frame
rownames(genecounts) <- genecounts[,1] #makes first column into rownames
genecounts$Gene_Name <- NULL #removes the Gene_name column (rownames have this info)

#make DESeqDataSet, needs matrix of conditions to organize comparisons
condition <- read_excel(excelsheet, sheet =2, col_names = TRUE) #loads data from excel
condition <-as.data.frame(condition)
rownames(condition) <- condition[,1] #makes first column into rownames
condition$Library <- NULL #removes the Gene_name column (rownames have this info)

dds <- DESeqDataSetFromMatrix(countData = genecounts, colData = condition, design = ~Sex+Disease)

#differential expression
de <- DESeq(dds)
res <- results(de)

rlogcounts = rlog(dds,blind=FALSE) #DESeq2 normalization that log2 transforms and scales for library size
rlogcountstable = assay(rlogcounts)

write.csv(rlogcountstable, file="C:/Data/Wainger_Lab/RNA/RNAseq2021/Cortical Neurons/TARDBP_CN_rlog.csv")
write.csv(as.data.frame(res),file='MSBB_Neun_AH_DEwSex.csv')

#PCA
pdf('PCA.pdf',useDingbats=F)
plotPCA(rlogcounts, intgroup='Disease') #plotting using plotPCA
dev.off()

pcaData<-plotPCA(rlogcounts,intgroup=c("Disease","Sex"),returnData=TRUE)
ggplot(pcaData,aes(x=PC1,y=PC2,color=factor(Disease),shape=factor(Sex))) + geom_point(size=3)
  

## volcano plot of data (from https://www.biostars.org/p/282295/)

pdf('volcano.pdf',useDingbats=F)

topT <- as.data.frame(res)

with(topT,plot(log2FoldChange, -log10(padj),pch=20,xlim=c(-5,5)),xlab=bquote(~Log[2]~fold~change),ylab=bquote(~-Log[10]~P~Adj))
with(subset(topT, padj<0.05 & abs(log2FoldChange)>1), points(log2FoldChange, -log10(padj), pch=20, col='red',cex=0.5))

#Adding lines for thresholds
abline(v=0,col='black',lty=3,lwd=1.0)
abline(v=-1,col='black',lty=4,lwd=2.0)
abline(v=1,col='black',lty=4,lwd=2.0)
abline(h=-log10(max(topT$padj[topT$padj<0.05], na.rm=TRUE)),col='black', lty=4, lwd=2)
dev.off()

## plot variable genes
countVar <- apply(rlogcountstable, 1, var) #get variance of each row
highVar <- order(countVar, decreasing=TRUE)[1:100] #find top 150 most variable genes
hmDat <- rlogcountstable[highVar,] #pull top 250 most variable genes

pheatmap(hmDat, cluster_rows=TRUE, show_rownames = FALSE, cluster_cols=TRUE, scale = "row")


  
  
  