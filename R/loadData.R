#' Load package datasets from composed Rdata
#'
#' Loads package datasets to global environment. User has the option to load all, only example, or only bio datasets.
#'  - bio data
#'    - mpr_barcodes
#'    - mpr_genes
#'    - mpr_matrix
#'    - mpr_merfish
#'
#' @param verbose A boolean to print result summary for loading objects (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' loadData(verbose = FALSE)
#' }
loadData = function(verbose = FALSE) {
    # load mpr_barcodes
    load(system.file("extdata/mpr_barcodes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load mpr_genes
    load(system.file("extdata/mpr_genes.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load mpr_matrix
    load(system.file("extdata/mpr_matrix.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)

    # load mpr_merfish
    load(system.file("extdata/mpr_merfish.Rdata", package = "mousePreopticR"), envir = globalenv(), verbose = verbose)
}
