#' Compose package datasets from component data
#'
#' @param verbose A boolean to print result summary for saving objects
#' @param merge_verbose A boolean to print result summary for data merges
#'
#' @export
#'
#' @examples
#' \dontrun{
#' composeData()
#' }
composeData = function(verbose = FALSE, merge_verbose = FALSE) {
  # compose and convert ex_data
  ex_data_path = system.file("extdata/ex_data", package = "mousePreopticR")
  ex_data_targ = system.file("extdata", package = "mousePreopticR")
  ex_data = csvMerge(data_dir = ex_data_path, axis = 0, verbose = merge_verbose)
  save(ex_data, file = file.path(ex_data_targ, "ex_data.Rdata"))
  if (verbose) cat(paste("Saving objects:", "  ex_data.Rdata", "", sep = "\n"))

  # compose and convert ex_matrix
  ex_matrix_path = system.file("extdata/ex_matrix", package = "mousePreopticR")
  ex_matrix_targ = system.file("extdata", package = "mousePreopticR")
  ex_matrix = matrixMerge(data_dir = ex_matrix_path, verbose = merge_verbose)
  save(ex_matrix, file = file.path(ex_matrix_targ, "ex_matrix.Rdata"))
  if (verbose) cat(paste("Saving objects:", "  ex_matrix.Rdata", "", sep = "\n"))
}

