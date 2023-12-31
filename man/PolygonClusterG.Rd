% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PolygonClusterG.R
\name{PolygonClusterG}
\alias{PolygonClusterG}
\title{Construct a network layout. Arrange network nodes to different locations according to grouping}
\usage{
PolygonClusterG(cor = cor, nodeGroup = netClu, zoom = 1, zoom2 = 1)
}
\arguments{
\item{cor}{Correlation matrix}

\item{nodeGroup}{Classification information of network nodes.Group according to actual requirements, see example}

\item{zoom}{Set the distance between modules}

\item{zoom2}{Scaling module radius size}
}
\value{
result2 Which contains 2 lists.Result2[[1]], consists of OTU and its corresponding coordinates.
Result2[[2]], consists of the network center coordinates of each group
}
\description{
Construct a network layout. Arrange network nodes to different locations according to grouping
}
\examples{
data
data(ps)
result = corMicro (ps = ps,N = 100,r.threshold=0.8,p.threshold=0.05,method = "pearson")
#Extract correlation matrix
cor = result[[1]]
# building the node group
netClu = data.frame(ID = row.names(cor),group =rep(1:3,length(row.names(cor)))[1:length(row.names(cor))] )
netClu$group = as.factor(netClu$group)
result2 = PolygonClusterG(cor = cor,nodeGroup =  netClu )


}
\references{
Yuan J, Zhao J, Wen T, Zhao M, Li R, Goossens P, Huang Q, Bai Y, Vivanco JM, Kowalchuk GA, Berendsen RL, Shen Q
Root exudates drive the soil-borne legacy of aboveground pathogen infection
Microbiome 2018,DOI: \url{doi: 10.1186/s40168-018-0537-x}
}
\author{
Contact: Tao Wen \email{2018203048@njau.edu.cn} Jun Yuan \email{junyuan@njau.edu.cn} Penghao Xie \email{2019103106@njau.edu.cn}
}
