#' Compose package datasets from component data
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

  # convert GEO_barcodes.tsv
  GEO_barcodes_path = system.file("extdata", package = "mousePreopticR")
  GEO_barcodes = utils::read.table(file.path(GEO_barcodes_path, "GEO_barcodes.tsv"), header = FALSE, sep = '\t')
  colnames(GEO_barcodes) = c("barcode")
  save(GEO_barcodes, file = file.path(GEO_barcodes_path, "GEO_barcodes.Rdata"))
  if (verbose) cat(paste("Saving objects:", "  GEO_barcodes.Rdata", "", sep = "\n"))

  # convert GEO_genes.tsv
  GEO_genes_path = system.file("extdata", package = "mousePreopticR")
  GEO_genes = utils::read.table(file.path(GEO_genes_path, "GEO_genes.tsv"), header = FALSE, sep = '\t')
  colnames(GEO_genes) = c("ensembl", "short_gene_name")
  save(GEO_genes, file = file.path(GEO_genes_path, "GEO_genes.Rdata"))
  if (verbose) cat(paste("Saving objects:", "  GEO_genes.Rdata", "", sep = "\n"))
}

