#' @title Extract all duplicates
#'
#' @description Extract all duplicates, for visual inspection.
#' Note that it also contains the first occurrence of future
#' duplicates, unlike [duplicated()] or [dplyr::distinct()]). Also
#' contains an additional column reporting the number of missing
#' values for that row, to help in the decision-making when
#' selecting which duplicates to keep.
#'
#' @details For the *easystats* equivalent, see:
#' [datawizard::data_unique()].
#' @param data The data frame.
#' @param id The ID variable for which to check for duplicates.
#' @keywords duplicates
#' @export
#' @return A dataframe, containing all duplicates.
#'
#' @examples
#' df1 <- data.frame(
#'   id = c(1, 2, 3, 1, 3),
#'   item1 = c(NA, 1, 1, 2, 3),
#'   item2 = c(NA, 1, 1, 2, 3),
#'   item3 = c(NA, 1, 1, 2, 3)
#' )
#'
#' extract_duplicates(df1, id = "id")
#'
#' # Filter to exclude duplicates
#' df2 <- df1[-c(1, 5), ]
#' df2
#'
#' @importFrom dplyr mutate %>%

extract_duplicates <- function(data, id) {
  check_col_names(data, id)

  Row <- seq_len(nrow(data))
  data <- cbind(Row, data)
  dups.index <- data[[id]] %in% data[[id]][duplicated(data[id])]
  dups <- data[dups.index, ]
  dups.n <- sum(duplicated(dups[[id]]))
  count_na_func <- function(x) sum(is.na(x))

  dups %>%
    mutate(count_na = apply(., 1, count_na_func)) %>%
    arrange(.data[[id]])
}
