#' @title Easily recode scores
#'
#' @description Easily recode scores (reverse-score),
#' typically for questionnaire answers.
#'
#' For the *easystats* equivalent, see:
#' [datawizard::reverse()].
#'
#' @param x The score to reverse.
#' @param max The maximum score on the scale.
#' @param min The minimum score on the scale (optional unless it isn't 1).
#'
#' @keywords reverse scoring
#' @return A numeric vector, of reversed scores.
#' @export
#' @examples
#' # Reverse score of 5 with a maximum score of 5
#' nice_reverse(5, 5)
#'
#' # Reverse several scores at once
#' nice_reverse(1:5, 5)
#'
#' # Reverse scores with maximum = 4 and minimum = 0
#' nice_reverse(1:4, 4, min = 0)
#'
#' # Reverse scores with maximum = 3 and minimum = -3
#' nice_reverse(-3:3, 3, min = -3)
#'
nice_reverse <- function(x,
                         max,
                         min = 1) {
  max - as.numeric(x) + min
}
