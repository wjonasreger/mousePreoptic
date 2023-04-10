#' Load package datasets from composed Rdata
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData()
#' }
loadData = function() {
  # load ex_data
  load(system.file("extdata/ex_data.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = TRUE)

  # load ex_matrix
  load(system.file("extdata/ex_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = TRUE)
}
