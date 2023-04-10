#' Load package datasets from composed Rdata
#'
#' @param datasets Character vector to select which datasets to load - one of 'all', 'bio', or 'example' (Default: "all")
#' @param verbose A boolean to print result summary for loading objects (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData(datasets = "all", verbose = FALSE)
#' }
loadData = function(datasets = "all", verbose = FALSE) {
  stopifnot("`datasets` must be one of 'all', 'bio', or 'example'" = any(datasets == c("all", "bio", "example")))
  if (datasets == "all" | datasets == "example") {
    # load ex_data
    load(system.file("extdata/ex_data.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load ex_matrix
    load(system.file("extdata/ex_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
  }

  if (datasets == "all" | datasets == "bio") {
    # load GEO_barcodes
    load(system.file("extdata/GEO_barcodes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load GEO_genes
    load(system.file("extdata/GEO_genes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
  }
}
