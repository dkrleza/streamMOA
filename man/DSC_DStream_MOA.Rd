% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DSC_DStream_MOA.R
\name{DSC_DStream_MOA}
\alias{DSC_DStream_MOA}
\title{D-Stream Data Stream Clustering Algorithm}
\usage{
DSC_DStream_MOA(decayFactor = 0.998, Cm = 3, Cl = 0.8, Beta = 0.3)
}
\arguments{
\item{decayFactor}{The decay factor}

\item{Cm}{Controls the threshold for dense grids}

\item{Cl}{Controls the threshold for sparse grids}

\item{Beta}{Adjusts the window of protection for renaming previously deleted grids as sporadic}
}
\description{
This is an interface to the MOA implementation of D-Stream.
A C++ implementation (including reclustering with attraction) is available as \code{\link[stream]{DSC_DStream}}.
}
\details{
D-Stream creates an equally spaced grid and estimates the density in each grid cell using the count of points falling in the cells.
Grid cells are classified based on density into dense, transitional and sporadic cells.
The density is faded after every new point by a decay factor.

\bold{Note:} The MOA implementation of D-Stream currently does not return micro clusters.
}
\examples{
# data with 2 clusters in 2 dimensions
stream = DSD_Gaussians(2,2, mu = rbind(c(-10,-10), c(10,10)))

# cluster with D-Stream
dstream <- DSC_DStream_MOA(decayFactor=0.998)
update(dstream, stream, 10000)
dstream

# plot macro-clusters
plot(dstream, stream, type= "macro")

}
\references{
Yixin Chen and Li Tu. 2007. Density-based clustering for real-time stream data. In Proceedings of the 13th ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (KDD '07). ACM, New York, NY, USA, 133-142.

Li Tu and Yixin Chen. 2009. Stream data clustering based on grid density and attraction. ACM Transactions on Knowledge Discovery from Data, 3(3), Article 12 (July 2009), 27 pages.
}
\author{
Matthias Carnein
}
