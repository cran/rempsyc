#' @title Easily randomization
#'
#' @description Randomize easily with different designs.
#'
#' @param design The design: either between-subject (different groups)
#' or within-subject (repeated-measures on same people).
#' @param Ncondition The number of conditions you want to randomize.
#' @param n The desired sample size. Note that it needs to
#' be a multiple of your number of groups if you are using `between`.
#' @param condition.names The names of the randomized conditions.
#' @param col.names The desired additional column names for a runsheet.
#'
#' @keywords randomization conditions random allocation experimental design
#' @return A dataframe, with participant ID and randomized condition, based
#'         on selected design.
#' @export
#' @examples
#' # Specify design, number of conditions, number of
#' # participants, and names of conditions:
#' nice_randomize(
#'   design = "between", Ncondition = 4, n = 8,
#'   condition.names = c("BP", "CX", "PZ", "ZL")
#' )
#'
#' # Within-Group Design
#' nice_randomize(
#'   design = "within", Ncondition = 4, n = 6,
#'   condition.names = c("SV", "AV", "ST", "AT")
#' )
#'
#' # Make a quick runsheet
#' randomized <- nice_randomize(
#'   design = "within", Ncondition = 4, n = 128,
#'   condition.names = c("SV", "AV", "ST", "AT"),
#'   col.names = c(
#'     "id", "Condition", "Date/Time",
#'     "SONA ID", "Age/Gd.", "Handedness",
#'     "Tester", "Notes"
#'   )
#' )
#' head(randomized)
#'
#' @importFrom dplyr arrange %>% mutate across everything recode
#'
#' @seealso
#' Tutorial: \url{https://rempsyc.remi-theriault.com/articles/randomize}
#'

nice_randomize <- function(design = "between",
                           Ncondition = 3,
                           n = 9,
                           condition.names = c("a", "b", "c"),
                           col.names = c("id", "Condition")) {
  Condition <- data.frame() # to precreate dataframe
  if (design == "between") {
    if (!n %% Ncondition == 0) {
      cat("Warning(!): sample size needs to be a multiple
                                of your number of groups if using 'between'!")
    }
    for (i in 1:(n / Ncondition)) { # Repeat this for number of
      # participants divided by Ncondition (number of complete combinations)
      x <- sample(1:Ncondition, replace = FALSE)
      # (Choose a number between 1 and Ncondition;
      # repeat this Ncondition times with no replacement)
      Condition <- rbind(Condition, t(t(x)), # Add new stats to dataframe
        stringsAsFactors = FALSE
      )
    }
  }
  if (design == "within") {
    for (i in 1:n) {
      # Generate the random values for n participants and Nconditions
      x <- sample(1:Ncondition, replace = FALSE)
      # Choose a number between 1 and Nconditions;
      # repeat this Nconditions times with no replacement
      Condition <- rbind(Condition, x, stringsAsFactors = FALSE)
      # Adds new conditions to dataframe row by row
      # Not as factors as this can create problems
    }
  }
  Condition <- Condition %>%
    mutate(across(everything(), function(x) {
      recode(x, !!!stats::setNames(condition.names, 1:Ncondition))
    }))
  for (i in 1:n) {
    Condition[i, 1] <- paste(Condition[i, ], collapse = " - ")
    # Adds hyphen between conditions for easier read
  }
  if (ncol(Condition) > 2) {
    Condition[, 2:ncol(Condition)] <- NA
  }
  id <- t(t(1:n))
  final_table <- data.frame(id, Condition, matrix(
    NA,
    ncol = length(col.names)
  ))[, seq_along(col.names)]
  names(final_table) <- col.names
  final_table
}
