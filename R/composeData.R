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

  # convert GEO_barcodes.tsv
  if (verbose) cat(paste("Saving objects:", "  GEO_barcodes.Rdata", "", sep = "\n"))
  GEO_barcodes_path = system.file("extdata", package = "mousePreopticR")
  GEO_barcodes = utils::read.table(file.path(GEO_barcodes_path, "GEO_barcodes.tsv"), header = FALSE, sep = '\t')
  colnames(GEO_barcodes) = c("barcode")
  rownames(GEO_barcodes) = GEO_barcodes$barcode
  save(GEO_barcodes, file = file.path(GEO_barcodes_path, "GEO_barcodes.Rdata"))

  # convert GEO_genes.tsv
  if (verbose) cat(paste("Saving objects:", "  GEO_genes.Rdata", "", sep = "\n"))
  GEO_genes_path = system.file("extdata", package = "mousePreopticR")
  GEO_genes = utils::read.table(file.path(GEO_genes_path, "GEO_genes.tsv"), header = FALSE, sep = '\t')
  colnames(GEO_genes) = c("ensembl", "gene_short_name")
  rownames(GEO_genes) = GEO_genes$ensembl
  save(GEO_genes, file = file.path(GEO_genes_path, "GEO_genes.Rdata"))

  # compose and convert GEO_matrix
  if (verbose) cat(paste("Saving objects:", "  GEO_matrix.Rdata", "", sep = "\n"))
  GEO_matrix_path = system.file("extdata/GEO_matrix", package = "mousePreopticR")
  GEO_matrix_targ = system.file("extdata", package = "mousePreopticR")
  GEO_matrix = matrixMerge(data_dir = GEO_matrix_path, verbose = merge_verbose)
  GEO_matrix@Dimnames = list(GEO_genes$ensembl, GEO_barcodes$barcode)
  save(GEO_matrix, file = file.path(GEO_matrix_targ, "GEO_matrix.Rdata"))

  # compose and convert DRYAD_data
  if (verbose) cat(paste("Saving objects:", "  DRYAD_data.Rdata", "", sep = "\n"))
  DRYAD_data_path = system.file("extdata/DRYAD_data", package = "mousePreopticR")
  DRYAD_data_targ = system.file("extdata", package = "mousePreopticR")
  DRYAD_data = csvMerge(data_dir = DRYAD_data_path, axis = 0, verbose = merge_verbose)
  save(DRYAD_data, file = file.path(DRYAD_data_targ, "DRYAD_data.Rdata"))
}

