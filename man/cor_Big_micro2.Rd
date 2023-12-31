% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cor_Big_micro2.R
\name{cor_Big_micro2}
\alias{cor_Big_micro2}
\title{Correlation network calculation of big microbial community data}
\usage{
cor_Big_micro2(
  ps = ps,
  N = 0,
  p.threshold = 0.05,
  r.threshold = 0.9,
  scale = FALSE,
  method = "spearman",
  met.scale = "TMM",
  p.adj = "BH"
)
}
\arguments{
\item{ps}{phyloseq Object, contains OTU tables, tax table and map table, represented sequences,phylogenetic tree.}

\item{N}{filter OTU tables by abundance.The defult, N=0, extract the top N number relative abundance of OTU.}

\item{p.threshold}{The defult, p.threshold=0.05, it represents significance threshold below 0.05.}

\item{r.threshold}{The defult, r.threshold=0.6, it represents the correlation that the absolute value
of the correlation threshold is greater than 0.6. the value range of correlation threshold from 0 to 1.}

\item{scale}{Whether to standardize microbiome data; TRUE or FALSE need selected.}

\item{method}{method for Correlation calculation,method="pearson" is the default value.
The alternatives to be passed to cor are "spearman" and "kendall".}

\item{met.scale}{Microbiome data normalization methods; could be selected by rela, sampling, log,TMM,RLE,upperquartile et al}

\item{p.adj}{A vector of character strings containing the names of the multiple testing procedures for which adjusted p-values are to be computed. This vector should include any of the following: "Bonferroni", "Holm", "Hochberg", "SidakSS", "SidakSD", "BH", "BY", "ABH", "TSBH".}
}
\value{
list which contains OTU correlation matrix
}
\description{
Correlation network calculation of big microbial community data
}
\examples{
data(ps)
result <- cor_Big_micro(ps = ps,N = 0,p.threshold = 0.05,r.threshold = 0.9,scale = FALSE)
# extract cor matrix
cor = result[[1]]
}
\references{
Tao Wen#, Penghao Xie#, Shengdie Yang, Guoqing Niu, Xiaoyu Liu, Zhexu Ding, Chao Xue, Yong-Xin Liu *, Qirong Shen, Jun Yuan*
ggClusterNet: an R package for microbiome network analysis and modularity-based multiple network layouts
iMeta 2022,DOI: \url{doi: 10.1002/imt2.32}
}
\author{
Contact: Tao Wen \email{taowen@njau.edu.cn} Penghao Xie \email{2019103106@njau.edu.cn} yongxin liu \email{yxliu@genetics.ac.cn} Jun Yuan \email{junyuan@njau.edu.cn}
}
