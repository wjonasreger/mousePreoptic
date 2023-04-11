#' Load package datasets from composed Rdata
#'
#' Loads package datasets to global environment. User has the option to load all, only example, or only bio datasets.
#'  - example data
#'    - ex_data
#'    - ex_matrix
#'  - bio data
#'    - GEO_barcodes
#'    - GEO_genes
#'    - GEO_matrix
#'    - DRYAD_data
#'
#' @param datasets Character vector to select which datasets to load - one of 'all', 'bio', or 'example' (Default: "bio")
#' @param verbose A boolean to print result summary for loading objects (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData(datasets = "bio", verbose = FALSE)
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

    # load GEO_matrix
    load(system.file("extdata/GEO_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load DRYAD_data
    load(system.file("extdata/DRYAD_data.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
  }
}
