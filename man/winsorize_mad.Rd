% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/winsorize_mad.R
\name{winsorize_mad}
\alias{winsorize_mad}
\title{Winsorize based on the absolute median deviation}
\usage{
winsorize_mad(x, criteria = 3)
}
\arguments{
\item{x}{The vector to be winsorized based on the MAD.}

\item{criteria}{How many MAD to use as threshold
(similar to standard deviations)}
}
\value{
A numeric vector of winsorized data.
}
\description{
Winsorize (bring extreme observations to usually
+/- 3 standard deviations) data based on median absolute
deviations instead of standard deviations.
}
\details{
For the \emph{easystats} equivalent, use:
\code{datawizard::winsorize(x, method = "zscore", threshold = 3, robust = TRUE)}.
}
\examples{
winsorize_mad(mtcars$qsec, criteria = 2)
}
\references{
Leys, C., Ley, C., Klein, O., Bernard, P., & Licata, L.
(2013). Detecting outliers: Do not use standard deviation
around the mean, use absolute deviation around the median.
\emph{Journal of Experimental Social Psychology}, \emph{49}(4), 764–766.
https://doi.org/10.1016/j.jesp.2013.03.013
}
\keyword{MAD}
\keyword{mean}
\keyword{median}
\keyword{normalization}
\keyword{outliers}
\keyword{standardization}
