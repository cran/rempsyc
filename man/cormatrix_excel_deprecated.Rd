% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cormatrix_excel_deprecated.R
\name{cormatrix_excel_deprecated}
\alias{cormatrix_excel_deprecated}
\title{Easy export of correlation matrix to Excel}
\usage{
cormatrix_excel_deprecated(
  data,
  filename,
  overwrite = TRUE,
  use = "pairwise.complete.obs"
)
}
\arguments{
\item{data}{The data frame}

\item{filename}{Desired filename (path can be added before hand
but no need to specify extension).}

\item{overwrite}{Whether to allow overwriting previous file.}

\item{use}{How to handle NA (see \code{?cor} for options).}
}
\value{
A Microsoft Excel document, containing the colour-coded
correlation matrix.
}
\description{
Easily output a correlation matrix and export it to
Microsoft Excel, with the first row and column frozen, and
correlation coefficients colour-coded based on their effect size
(0.0-0.2: small (no colour); 0.2-0.4: medium (pink); 0.4-1.0:
large (red)).
}
\examples{
\donttest{
\dontshow{.old_wd <- setwd(tempdir())}
# Basic example
cormatrix_excel_deprecated(mtcars, "cormatrix")
\dontshow{setwd(.old_wd)}
}
}
\keyword{Excel}
\keyword{correlation}
\keyword{internal}
\keyword{matrix}
