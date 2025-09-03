library(vegan)
library(pvclust)

### faunal similarity analyses
dataset <- read.delim(file = "fossil_occs.tsv", stringsAsFactors = FALSE)
dataset <- dataset[, -ncol(dataset)]

comMatrix <- dataset[, -c(1, 3)]
rownames(comMatrix) <- comMatrix$Taxon
comMatrix <- comMatrix[,-1]
comMatrix <- t(comMatrix)

### number of occurrences per fauna
sort(x = apply(X = comMatrix, MARGIN = 1, FUN = sum), decreasing = TRUE)

### calculate the distance matrix using Bray-Curtis' method
distMatrixBray <- vegan::vegdist(comMatrix, method = "bray", binary = TRUE)
# rename labels in order to replace dots with spaces
attr(distMatrixBray, "Labels") <- gsub(pattern = "\\.", replacement = " ", x = attr(distMatrixBray, "Labels"))

### bootstrap on clustering

fBinary <- pvclust::pvclust(t(comMatrix), method.hclust = "average", method.dist = "binary")
fBray <- pvclust::pvclust(comMatrix, method.hclust = "average", method.dist = function(x) vegdist(x, method = "bray", binary = TRUE), nboot = 10000)

### plot the dendrogram
pdf(file = "faunalSimBinary.pdf")
plot(fBinary, main = "Faunal similarity")
dev.off()

########## Similarity of modern units

### replace ? with absent 0
system("sed 's/?/0/g' dagosta2017/modern_incidence.tab > dagosta2017/modern_incidence_nomissing.tab")

modernData <- read.delim(file = "dagosta2017/modern_incidence_nomissing.tab", header = FALSE, stringsAsFactors = FALSE)
rownames(modernData) <- modernData[,1] 
modernData <- modernData[-1, ]
modernData <- modernData[,-1]

modernDistMatrixBray <- vegan::vegdist(modernData, method = "bray", binary = TRUE)

modern_fBinary <- pvclust::pvclust(t(modernData), method.hclust = "average", method.dist = "binary", nboot = 1000, parallel = TRUE)

### plot the dendrogram
pdf(file = "modern_faunalSimBinary.pdf", height = 10, width = 14)
plot(modern_fBinary, main = "Modern faunal similarity")
dev.off()
