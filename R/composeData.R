#' Compose package datasets from component data
#'
#' Composes and/or converts the following dataset directories/files to .RData format in post-installation
#' when user runs `composeData()`:
#'  - example datasets
#'    - ex_data/ (csv components)
#'    - ex_matrix/ (matrix components)
#'  - bio data
#'    - GEO_barcodes.tsv (tsv dataset)
#'    - GEO_genes.tsv (tsv dataset)
#'    - GEO_matrix/ (matrix components)
#'    - DRYAD_data/ (csv components)
#'
#' @param verbose A boolean to print result summary for saving objects (Default: FALSE)
#' @param merge_verbose A boolean to print result summary for data merges (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' composeData(verbose = FALSE, merge_verbose = FALSE)
#' }
composeData = function(verbose = FALSE, merge_verbose = FALSE) {

  # data directory in package
  data_dir = system.file("extdata", package = "mousePreopticR")


  ### GEO DATA ###
  # convert GEO_barcodes.tsv
  GEO_barcodes = composeTable(name = "GEO_barcodes", col_names = c("barcode"), row_names = "barcode",
                              merge = FALSE, merge_dir = 'extdata', data_dir = 'extdata',
                              verbose = verbose, merge_verbose = FALSE)
  save(GEO_barcodes, file = file.path(data_dir, "GEO_barcodes.Rdata"))

  # convert GEO_genes.tsv
  GEO_genes = composeTable(name = "GEO_genes", col_names = c("ensembl_id", "gene_short_name"), row_names = "ensembl_id",
                           merge = FALSE, merge_dir = 'extdata', data_dir = 'extdata',
                           verbose = verbose, merge_verbose = FALSE)
  save(GEO_genes, file = file.path(data_dir, "GEO_genes.Rdata"))

  # compose and convert /GEO_matrix
  GEO_matrix = composeMatrix(name = "GEO_matrix", col_names = GEO_barcodes$barcode, row_names = GEO_genes$ensembl_id,
                             merge = TRUE, merge_dir = 'extdata', data_dir = 'extdata',
                             verbose = verbose, merge_verbose = FALSE)
  save(GEO_matrix, file = file.path(data_dir, "GEO_matrix.Rdata"))


  ### DRYAD DATA ###
  # compose and convert /DRYAD_data
  DRYAD_data = composeTable(name = "DRYAD_data", col_names = 1, row_names = "Cell_ID",
                            merge = TRUE, merge_dir = 'extdata', data_dir = 'extdata',
                            verbose = verbose, merge_verbose = FALSE)
  save(DRYAD_data, file = file.path(data_dir, "DRYAD_data.Rdata"))
}

