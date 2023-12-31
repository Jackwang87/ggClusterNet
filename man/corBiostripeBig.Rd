% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/corBiostripeBig.R
\name{corBiostripeBig}
\alias{corBiostripeBig}
\title{Inter-Domain Ecological Network, we call this biostripe network}
\usage{
corBiostripeBig(
  data = NULL,
  group = NULL,
  ps = NULL,
  r.threshold = 0.6,
  p.threshold = 0.05,
  method = "spearman"
)
}
\arguments{
\item{ps}{phyloseq Object, contains OTU tables, tax table and map table, represented sequences,phylogenetic tree.}

\item{r.threshold}{The defult, r.threshold=0.6, it represents the correlation that the absolute value
of the correlation threshold is greater than 0.6. the value range of correlation threshold from 0 to 1.}

\item{p.threshold}{The defult, p.threshold=0.05, it represents significance threshold below 0.05.}

\item{method}{method for Correlation calculation,method="pearson" is the default value. The alternatives to be passed to cor are "spearman" and "kendall".}

\item{N}{filter OTU tables by abundance.The defult, N=0.02, extract the top 0.02 relative abundance of OTU.}
}
\value{
list which contains OTU correlation matrix
}
\description{
Inter-Domain Ecological Network, we call this biostripe network
}
\examples{
data(ps)
result <- corMicro(ps = ps,N = 0.02,r.threshold=0.6,p.threshold=0.05,method = "pearson")
# extract cor matrix
cor = result[[1]]
}
\references{
Yuan J, Zhao J, Wen T, Zhao M, Li R, Goossens P, Huang Q, Bai Y, Vivanco JM, Kowalchuk GA, Berendsen RL, Shen Q
Root exudates drive the soil-borne legacy of aboveground pathogen infection
Microbiome 2018,DOI: \url{doi: 10.1186/s40168-018-0537-x}
}
\author{
Contact: Tao Wen \email{2018203048@njau.edu.cn} Jun Yuan \email{junyuan@njau.edu.cn} Penghao Xie \email{2019103106@njau.edu.cn}
}
