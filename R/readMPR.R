#' Load in data from local directory similar to Seurat's `Read10X`
#'
#' @param data_dir Directory containing the matrix.mtx, genes.tsv, barcodes.tsv files to load
#' @param cell_column Specify which column of barcodes.tsv to use for cell names. (Default: 1)
#' @param gene_column Specify which column of genes.tsv to use for gene names. (Default: 1)
#' @param colnames List of column names for barcodes and genes data sets (Default: NULL)
#'
#' @return An expression matrix with updated dimension names for genes and cells
#' @export
#'
#' @examples
#' \dontrun{
#' mpr = readMPR(data_dir = "mpr_experiment",
#'                cell_column = 1,
#'                gene_column = 2,
#'                colnames = list(barcodes_col = c("barcode"),
#'                                genes_col = c("ensembl_id", "gene_short_name")))
#' }
readMPR = function(data_dir, cell_column = 1, gene_column = 1, colnames = NULL) {
  # data paths
  barcode_loc = file.path(data_dir, "barcodes.tsv")
  genes_loc = file.path(data_dir, "genes.tsv")
  matrix_loc = file.path(data_dir, "matrix.mtx")

  # check if files exist
  if (!file.exists(barcode_loc)) {stop("Barcode file missing. Expecting ", basename(path = barcode_loc))}
  if (!file.exists(genes_loc)) {stop("Genes file missing. Expecting ", basename(path = genes_loc))}
  if (!file.exists(matrix_loc)) {stop("Expression matrix file missing. Expecting ", basename(path = matrix_loc))}

  # load data
  barcodes = utils::read.table(file = barcode_loc, header = FALSE, sep = "\t")
  genes = utils::read.table(file = genes_loc, header = FALSE, sep = "\t")
  matrix = Matrix::readMM(file = matrix_loc)

  # update column names
  if (!is.null(colnames)) {
    colnames(barcodes) = colnames[["barcodes_col"]]
    colnames(genes) = colnames[["genes_col"]]
  }

  # update matrix count object with dimension names
  matrix@Dimnames = list(genes[, gene_column], barcodes[, cell_column])

  # return matrix object
  return(matrix)
}
