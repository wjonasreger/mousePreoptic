#' Compose package tables from component data
#'
#' Composes and converts the following dataset directories/files to .RData format in post-installation
#' when run in `composeData()`:
#'
#' @param name Character vector of dataset name
#' @param col_names Character vector of columns for dataset. Set to NULL to not specify any column names.
#' @param row_names Character vector of rows for dataset. Set to NULL to not specify any row names.
#' @param merge Boolean to indicate merging of component data.
#' @param merge_dir Character vector of directory pathway to component data if merging is needed. If not specified, data will be accessed from designated package extdata directory. (Default: NULL)
#' @param data_dir Character vector of directory pathway to data file if merging is not needed. Also the destination for the data after composition and conversion. If not specified, data will be saved to designated package extdata directory. (Default: NULL)
#' @param verbose A boolean to print result summary for saving objects. (Default: FALSE)
#' @param merge_verbose A boolean to print result summary for data merges. (Default: FALSE)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' composeTable(name = "GEO_genes",
#'              col_names = c("ensembl_id", "gene_short_name"),
#'              row_names = "ensembl_id",
#'              merge = FALSE,
#'              merge_dir = NULL, data_dir = NULL,
#'              verbose = FALSE, merge_verbose = FALSE)
#' }
composeTable = function(name, col_names, row_names, merge, merge_dir = NULL, data_dir = NULL, verbose = FALSE, merge_verbose = FALSE) {

  # verbosity and directory pathways
  if (verbose) cat(paste("Saving objects:", paste0("  ", name, ".Rdata"), "", sep = "\n"))
  if (is.null(data_dir)) {data_dir = here::here()}
  if (is.null(merge_dir)) {merge_dir = here::here(name)}
  if (data_dir == 'extdata') {data_dir = system.file("extdata", package = "mousePreopticR")}
  if (merge_dir == 'extdata') {merge_dir = system.file(paste0("extdata/", name), package = "mousePreopticR")}

  # compose and load data
  if (merge) {
    data = tableMerge(data_dir = merge_dir, axis = 0, verbose = merge_verbose)
  } else {
    data = utils::read.table(file.path(data_dir, paste0(name, ".tsv")), header = FALSE, sep = '\t')
  }

  # update data column and row names
  if (!is.null(col_names) && is.character(col_names)) {colnames(data) = col_names}
  if (!is.null(row_names) && is.character(row_names)) {rownames(data) = data[[row_names]]}
  if (is.numeric(col_names) && length(col_names) == 1) {colnames(data) = data[col_names, ]; data = data[-col_names, ]}
  if (is.numeric(row_names) && length(row_names) == 1) {rownames(data) = data[, row_names]}

  # return data
  return(data)

}
