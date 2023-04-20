#' Convert partial data to a matrix with a metadata list for eventual SummarizedExperiment objects
#'
#' @param data A DataFrame object
#' @param col_names A vector of column names or numbers. (Default: NULL)
#' @param row_names A vector of row names or numbers. (Default: NULL)
#' @param col_subset A vector of columns to subset data with. (Default: NULL)
#' @param row_subset A vector of rows to subset data with. (Default: NULL)
#' @param col_meta A vector of columns to specify as meta data columns. (Default: NULL)
#' @param transpose A bollean to indicate if matrix should be transposed. (Default: FALSE)
#' @param verbose A boolean to print result summary for saving objects. (Default: FALSE)
#' @param merge_verbose A boolean to print result summary for data merges. (Default: FALSE)
#'
#' @return A list of 2 elements with [1] the matrix, and [2] the metadata list.
#' @export
#'
#' @examples
#' \dontrun{
#' ?DRYAD_data
#'
#' col_names = colnames(DRYAD_data)
#' row_names = DRYAD_data$Cell_ID
#'
#' col_subset = col_names[grep("blank", col_names, ignore.case = TRUE)]
#' row_subset = row_names[1:100]
#'
#' DRYAD_matrix = matrixify(data = DRYAD_data,
#'                          col_names = col_names,
#'                          row_names = row_names,
#'                          col_subset = col_subset,
#'                          row_subset = row_subset,
#'                          col_meta = c("Cell_ID", "Centroid_X", "Centroid_Y"),
#'                          transpose = TRUE)
#' }
matrixify = function(data, col_names = NULL, row_names = NULL, col_subset = NULL, row_subset = NULL,
                     col_meta = NULL, transpose = FALSE, verbose = FALSE, merge_verbose = FALSE) {
  # set dimensional names
  colnames(data) = col_names
  rownames(data) = row_names

  # create meta_data list
  meta_data = setNames(vector(mode = "list", length = length(col_meta) + 1),
                       c("axis", col_meta))
  meta_data[["axis"]] = ifelse(transpose, 0, 1)

  # subset data frame
  tmp_data = data[row_subset, union(col_subset, col_meta)]
  # pivot data frame to longer format
  tmp_data_long = tmp_data %>%
    dplyr::mutate(row = rownames(tmp_data)) %>%
    tidyr::pivot_longer(cols = col_subset, names_to = "col", values_to = "values")
  # subset out the zero counts
  tmp_data_long = tmp_data_long[tmp_data_long$values != 0, ]

  # store meta data
  for (c in col_meta) {meta_data[[c]] = tmp_data[, c]}


  # create sparse matrix object of data
  if (transpose) {
    mat = methods::new("dgTMatrix",
                       i = as.integer(match(tmp_data_long$col, colnames(tmp_data[, col_subset])) - 1),
                       j = as.integer(match(tmp_data_long$row, rownames(tmp_data[, col_subset])) - 1),
                       x = as.numeric(tmp_data_long$values),
                       Dim = rev(dim(tmp_data[, col_subset])))
    mat@Dimnames = list(colnames(tmp_data[, col_subset]), rownames(tmp_data[, col_subset]))
  } else {
    mat = methods::new("dgTMatrix",
                       i = as.integer(match(tmp_data_long$row, rownames(tmp_data[, col_subset])) - 1),
                       j = as.integer(match(tmp_data_long$col, colnames(tmp_data[, col_subset])) - 1),
                       x = as.numeric(tmp_data_long$values),
                       Dim = dim(tmp_data[, col_subset]))
    mat@Dimnames = list(rownames(tmp_data[, col_subset]), colnames(tmp_data[, col_subset]))
  }

  return(list(matrix = mat, metadata = meta_data))
}
