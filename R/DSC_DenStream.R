#######################################################################
# stream -  Infrastructure for Data Stream Mining
# Copyright (C) 2013 Michael Hahsler, Matthew Bolanos, John Forrest
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


# denstream options:
# -e epsilon 	0.01 (defines the epsilon neighborhood, range: 0 to 1)
# -p minPoints 	10 (min. num. points a cluster must have)
# depricated -b beta	0.001 (range: 0 to 1)
# -m mu		1 (range: 0 to max(double)) -> this is actually minpoints and will get converted to int!
# -l lambda (range: 0 to 1)
# -i initPoints	10000 (number of points to use for initialization)


DSC_DenStream <- function(epsilon,  mu=1, beta=0.2, lambda=0.001,
  initPoints=100, offline=2, processingSpeed=1, recluster=TRUE, k = NULL) {
  #, minPoints=10) {

  ### note:DenStream does not use horizon anymore!
  horizon <- 1000
  ### Java code does parameter checking

  paramList <- list(
    h = horizon,
    e = epsilon,
#    p = minPoints,
    b = beta,
    m = mu,
    i = initPoints,
    l = lambda,
    o = offline,
    s = processingSpeed
    )

  clus <- DSC_MOA_Clusterer("moa/clusterers/denstream/WithDBSCAN", "DenStream",
    paramList)

  # note that reachability and single-link hc are equivalent
  if(recluster) {
    if(is.null(k))
      clus <- DSC_TwoStage(clus,
        DSC_Reachability(epsilon=(offline+1e-9)*epsilon))
    else
      clus <- DSC_TwoStage(clus,
        DSC_Hierarchical(k=k, method="single"))
  }

  clus
}

DSC_DenStream_MOA <- DSC_DenStream
