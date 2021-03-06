% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Benktander.R
\name{Benktander}
\alias{Benktander}
\title{Benktander Reserving method}
\usage{
Benktander(triangle, ultimateClaims, weight = NA)
}
\arguments{
\item{triangle}{Undevelopped triangle as a matrix.}

\item{ultimateClaims}{Ultimate claims by accident year.}

\item{weight}{Boolean matrix with 1 row and 1 column less than the triangle to tell if the link ratio is to be considered: 1 for yes, 0 for no.}
}
\value{
A list containing the following objects:
\itemize{
  \item{triangle: the input triangle }
  \item{developedTriangle: the developed triangle}
  \item{gammas: the Benktander coefficients}
  \item{ibnrByAccidentYear: ibnr reserve by accident year}
  \item{ibnr: total ibnr reserve}}
}
\description{
\code{Benktander} applies the Benktander method to a cumulated claim triangle, as described in this paper: https://www.casact.org/library/astin/vol30no2/333.pdf.
}
\details{
Missing values are handled. There just need to be replaced by a NA.

It is possible to have more than one complete line.
}
\examples{
ultimateClaims <- c(3901463,5433719,5378826,5297906,4858200,5111171,5660771,6784799,5642266,4969825)
outputBT <- Benktander(triangleExampleEngland, ultimateClaims)

}
