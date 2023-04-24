#' Convert partial data to a matrix with a metadata list for eventual SummarizedExperiment objects
#'
#' @param data A DataFrame object
#' @param names A list of length three with vectors in "col", "row", and "meta" for naming. (Default: NULL)
#' @param subs A list of length two with vectors in "col" and "row" for subsetting. (Default: NULL)
#' @param transpose A bollean to indicate if matrix should be transposed. (Default: FALSE)
#' @param verbose A boolean to print result summary for saving objects. (Default: FALSE)
#' @param merge_verbose A boolean to print result summary for data merges. (Default: FALSE)
#'
#' @return A list of 2 elements with (1) the matrix, and (2) the metadata list.
#' @export
#'
#' @examples
#' \dontrun{
#' ?mpr_merfish
#'
#' names = list(
#'   col = colnames(mpr_merfish),
#'   row = mpr_merfish$Cell_ID,
#'   meta = c("Cell_ID", "Centroid_X", "Centroid_Y")
#' )
#'
#' subs = list(
#'   col = names[["col"]][grep("blank", names[["col"]], ignore.case = TRUE)],
#'   row = names[["row"]][1:100]
#' )
#'
#' DRYAD_matrix = matrixify(data = mpr_merfish,
#'                          names = names,
#'                          subs = subs,
#'                          transpose = TRUE)
#' }
matrixify = function(data, names = NULL, subs = NULL, transpose = FALSE, verbose = FALSE, merge_verbose = FALSE) {
  # set dimensional names
  colnames(data) = names[["col"]]
  rownames(data) = names[["row"]]

  # create meta_data list
  meta_data = stats::setNames(vector(mode = "list", length = length(names[["meta"]]) + 1),
                       c("axis", names[["meta"]]))
  meta_data[["axis"]] = ifelse(transpose, 0, 1)

  # subset data frame
  tmp_data = data[subs[["row"]], union(subs[["col"]], names[["meta"]])]
  # pivot data frame to longer format
  tmp_data_long = tmp_data
  tmp_data_long = dplyr::mutate(row = rownames(tmp_data))
  tmp_data_long = tidyr::pivot_longer(cols = subs[["col"]], names_to = "col", values_to = "values")
  # tmp_data_long = tmp_data %>%
  #   dplyr::mutate(row = rownames(tmp_data)) %>%
  #   tidyr::pivot_longer(cols = subs[["col"]], names_to = "col", values_to = "values")

  # subset out the zero counts
  tmp_data_long = tmp_data_long[tmp_data_long$values != 0, ]

  # store meta data
  for (c in names[["meta"]]) {meta_data[[c]] = tmp_data[, c]}


  # create sparse matrix object of data
  if (transpose) {
    mat = methods::new("dgTMatrix",
                       i = as.integer(match(tmp_data_long$col, colnames(tmp_data[, subs[["col"]]])) - 1),
                       j = as.integer(match(tmp_data_long$row, rownames(tmp_data[, subs[["col"]]])) - 1),
                       x = as.numeric(tmp_data_long$values),
                       Dim = rev(dim(tmp_data[, subs[["col"]]])))
    mat@Dimnames = list(colnames(tmp_data[, subs[["col"]]]), rownames(tmp_data[, subs[["col"]]]))
  } else {
    mat = methods::new("dgTMatrix",
                       i = as.integer(match(tmp_data_long$row, rownames(tmp_data[, subs[["col"]]])) - 1),
                       j = as.integer(match(tmp_data_long$col, colnames(tmp_data[, subs[["col"]]])) - 1),
                       x = as.numeric(tmp_data_long$values),
                       Dim = dim(tmp_data[, subs[["col"]]]))
    mat@Dimnames = list(rownames(tmp_data[, subs[["col"]]]), colnames(tmp_data[, subs[["col"]]]))
  }

  return(list(matrix = mat, metadata = meta_data))
}
