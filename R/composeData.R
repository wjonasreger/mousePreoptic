#' Compose package datasets from component data
#'
#' Composes and/or converts the following dataset directories/files to .RData format in post-installation
#' when user runs `composeData()`:
#'  - bio data
#'    - mpr_barcodes.tsv (tsv dataset)
#'    - mpr_genes.tsv (tsv dataset)
#'    - mpr_matrix/ (matrix components)
#'    - mpr_merfish/ (csv components)
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
  # convert mpr_barcodes.tsv
  mpr_barcodes = composeTable(name = "mpr_barcodes", col_names = c("barcode"), row_names = "barcode",
                              merge = FALSE, merge_dir = 'extdata', data_dir = 'extdata',
                              verbose = verbose, merge_verbose = FALSE)
  save(mpr_barcodes, file = file.path(data_dir, "mpr_barcodes.Rdata"))

  # convert mpr_genes.tsv
  mpr_genes = composeTable(name = "mpr_genes", col_names = c("ensembl_id", "gene_short_name"), row_names = "ensembl_id",
                           merge = FALSE, merge_dir = 'extdata', data_dir = 'extdata',
                           verbose = verbose, merge_verbose = FALSE)
  save(mpr_genes, file = file.path(data_dir, "mpr_genes.Rdata"))

  # compose and convert /mpr_matrix
  mpr_matrix = composeMatrix(name = "mpr_matrix", col_names = mpr_barcodes$barcode, row_names = mpr_genes$ensembl_id,
                             merge = TRUE, merge_dir = 'extdata', data_dir = 'extdata',
                             verbose = verbose, merge_verbose = FALSE)
  save(mpr_matrix, file = file.path(data_dir, "mpr_matrix.Rdata"))


  ### DRYAD DATA ###
  # compose and convert /mpr_merfish
  mpr_merfish = composeTable(name = "mpr_merfish", col_names = 1, row_names = "Cell_ID",
                            merge = TRUE, merge_dir = 'extdata', data_dir = 'extdata',
                            verbose = verbose, merge_verbose = FALSE)
  save(mpr_merfish, file = file.path(data_dir, "mpr_merfish.Rdata"))
}

