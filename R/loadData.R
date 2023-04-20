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
#' @param datasets Character vector to select which datasets to load - one of 'all', 'bio', 'GEO' or 'DRYAD' (Default: "all")
#' @param verbose A boolean to print result summary for loading objects (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData(datasets = "all", verbose = FALSE)
#' }
loadData = function(datasets = "all", verbose = FALSE) {
  stopifnot("`datasets` must be one of 'all', 'bio', 'GEO' or 'DRYAD'" = any(datasets == c("all", "bio", "GEO", "DRYAD")))

  if (datasets %in% c("all", "bio", "GEO")) {
    # load GEO_barcodes
    load(system.file("extdata/GEO_barcodes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load GEO_genes
    load(system.file("extdata/GEO_genes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load GEO_matrix
    load(system.file("extdata/GEO_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
  }

  if (datasets %in% c("all", "bio", "DRYAD")) {
    # load DRYAD_data
    load(system.file("extdata/DRYAD_data.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
  }
}
