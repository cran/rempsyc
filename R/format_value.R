#' @title Easily format p or r values
#'
#' @description Easily format p or r values. Note: converts to character class
#' for use in figures or manuscripts to accommodate e.g., "< .001".
#'
#' @param p p-value to format.
#' @param r r-value to format.
#' @param d d-value to format.
#' @param precision Level of precision desired, if necessary.
#' @param type Specify r or p value.
#' @param value Value to be formatted, when using the generic `format_value()`.
#' @param prefix To add a prefix before the value.
#' @param suffix To add a suffix after the value.
#' @param sign Logical. Whether to add an equal sign for p-values higher or
#' equal to .001.
#' @param ... To specify precision level, if necessary, when using the
#' generic `format_value()`. Simply add the `precision` argument.
#'
#' @keywords formatting p-value r-value correlation
#' @return A formatted p, r, or d value.
#' @export
#' @examples
#' format_value(0.00041231, "p")
#' format_value(0.00041231, "r")
#' format_value(1.341231, "d")
#' format_p(0.0041231)
#' format_p(0.00041231)
#' format_r(0.41231)
#' format_r(0.041231)
#' format_d(1.341231)
#' format_d(0.341231)
#' @name format_value
format_value <- function(value,
                         type = "d",
                         ...) {
  if (type == "r") {
    format_r(value, ...)
  } else if (type == "p") {
    format_p(value, ...)
  } else if (type == "d") {
    format_d(value, ...)
  }
}

#' @export
#' @rdname format_value
format_p <- function(p,
                     precision = 0.001,
                     prefix = NULL,
                     suffix = NULL,
                     sign = FALSE) {
  digits <- -log(precision, base = 10)
  p <- formatC(p, format = "f", digits = digits)
  if (sign == TRUE) {
    p[p != formatC(0, format = "f", digits = digits)] <- paste0(
      "= ", p[p != formatC(0, format = "f", digits = digits)]
    )
  }
  p[p == formatC(0, format = "f", digits = digits)] <-
    paste0("< ", precision)
  p <- sub("0", "", p)
  p <- paste0(prefix, p, suffix)
  p <- ifelse(p == "  NA", "", p)
  p
}

#' @export
#' @rdname format_value
format_r <- function(r,
                     precision = 0.01) {
  digits <- -log(precision, base = 10)
  r <- formatC(r, format = "f", digits = digits)
  sub("0", "", r)
}

#' @export
#' @rdname format_value
format_d <- function(d,
                     precision = 0.01) {
  digits <- 2
  formatC(d, format = "f", digits = digits)
}
