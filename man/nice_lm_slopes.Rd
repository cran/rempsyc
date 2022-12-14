% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nice_lm_slopes.R
\name{nice_lm_slopes}
\alias{nice_lm_slopes}
\title{Nice formatting of simple slopes for lm models}
\usage{
nice_lm_slopes(model, predictor, moderator, b.label = "b", mod.id = TRUE, ...)
}
\arguments{
\item{model}{The model to be formatted.}

\item{predictor}{The independent variable.}

\item{moderator}{The moderating variable.}

\item{b.label}{What to rename the default "b" column (e.g.,
to capital B if using standardized data for it to be converted
to the Greek beta symbol in the \code{nice_table} function).}

\item{mod.id}{Logical. Whether to display the model number,
when there is more than one model.}

\item{...}{Further arguments to be passed to the \code{lm}
function for the models.}
}
\value{
A formatted dataframe of the simple slopes of the specified lm model,
with DV, levels of IV, degrees of freedom, regression coefficient,
t-value, p-value, and the effect size, the semi-partial correlation
squared.
}
\description{
Extracts simple slopes from \code{lm} model
object and format for a publication-ready format.

Note: this function uses the \code{modelEffectSizes} function
from the \code{lmSupport} package to get the sr2 effect sizes.
}
\examples{
# Make and format model
model <- lm(mpg ~ gear * wt, mtcars)
nice_lm_slopes(model, predictor = "gear", moderator = "wt")

# Make and format multiple models
model2 <- lm(qsec ~ gear * wt, mtcars)
my.models <- list(model, model2)
nice_lm_slopes(my.models, predictor = "gear", moderator = "wt")

}
\seealso{
Checking for moderation before checking simple slopes:
\code{\link{nice_lm}}, \code{\link{nice_mod}},
\code{\link{nice_slopes}}. Tutorial:
\url{https://rempsyc.remi-theriault.com/articles/moderation}
}
\keyword{interaction}
\keyword{moderation}
\keyword{regression}
