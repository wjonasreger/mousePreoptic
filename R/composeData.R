#' Compose package datasets from component data
#'
#' @export
#'
#' @examples
#' \dontrun{
#' composeData()
#' }
composeData = function() {
  # compose and convert ex_data
  ex_data_path = system.file("extdata/ex_data", package = "mousePreopticR")
  ex_data_targ = system.file("extdata", package = "mousePreopticR")
  ex_data = csvMerge(ex_data_path)
  save(ex_data, file = file.path(ex_data_targ, "ex_data.Rdata"))

  # compose and convert ex_matrix
  ex_matrix_path = system.file("extdata/ex_matrix", package = "mousePreopticR")
  ex_matrix_targ = system.file("extdata", package = "mousePreopticR")
  ex_matrix = matrixMerge(ex_matrix_path)
  save(ex_matrix, file = file.path(ex_matrix_targ, "ex_matrix.Rdata"))
}

