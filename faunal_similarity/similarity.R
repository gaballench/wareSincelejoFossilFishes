library(vegan)
library(pvclust)

########## fossil faunal similarity analyses
dataset <- read.delim(file = "fossil_occs.tsv", stringsAsFactors = FALSE)
dataset <- dataset[, -ncol(dataset)]

comMatrix <- dataset[, -c(1, 3)]
rownames(comMatrix) <- comMatrix$Taxon
comMatrix <- comMatrix[,-1]
comMatrix <- t(comMatrix)

### number of occurrences per fauna
sort(x = apply(X = comMatrix, MARGIN = 1, FUN = sum), decreasing = TRUE)

### bootstrap on clustering

# "binary" in method.dist is actually jaccard's distance
fBinary <- pvclust::pvclust(t(comMatrix), method.hclust = "average", method.dist = "binary", nboot=100000, parallel=TRUE)

### plot the dendrogram
pdf(file = "faunalSimBinary.pdf")
plot(fBinary, main = "Faunal similarity")
dev.off()

########## Similarity of modern assemblages

### replace ? with absent 0
system("sed 's/?/0/g' dagosta2017/modern_incidence.tab > dagosta2017/modern_incidence_nomissing.tab")

modernData <- read.delim(file = "dagosta2017/modern_incidence_nomissing.tab", header = FALSE, stringsAsFactors = FALSE)
rownames(modernData) <- modernData[,1] 
modernData <- modernData[-1, ]
modernData <- modernData[,-1]

### bootstrap on clustering

# "binary" in method.dist is actually jaccard's distance
modern_fBinary <- pvclust::pvclust(t(modernData), method.hclust = "average", method.dist = "binary", nboot = 1000, parallel = TRUE)

### plot the dendrogram
pdf(file = "modern_faunalSimBinary.pdf", height = 10, width = 14)
plot(modern_fBinary, main = "Modern faunal similarity")
dev.off()
