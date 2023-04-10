#' Load package datasets from composed Rdata
#'
#' @param verbose A boolean to print result summary for loading objects
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData()
#' }
loadData = function(verbose = TRUE) {
  # load ex_data
  load(system.file("extdata/ex_data.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

  # load ex_matrix
  load(system.file("extdata/ex_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
}
