#' CSV split function for large CSV files
#'
#' @param data_file A character vector with one element as the path to the file to split
#' @param nb_comp A numeric vector with one element to specify how many components to split the file into
#' @param axis A numeric vector with one element to specify axis to split (0: rows, 1: columns)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' csvSplit(data_file = "data/example_data/data.csv", nb_comp = 2, axis = 0)
#' }
csvSplit = function(data_file, nb_comp, axis = 0) {
  # create data directory
  data_dir = utils::head(strsplit(data_file, "[.]")[[1]], -1)
  dir.create(data_dir, showWarnings = FALSE)

  # load data
  df = utils::read.csv(data_file)
  size = ifelse(axis == 0, nrow(df), ncol(df))
  comp_size = ceiling(size/nb_comp)

  # subset data
  continue = TRUE; iter = 1
  while (continue) {
    # indexes
    start_index = (iter - 1)*comp_size + 1
    end_index = iter*comp_size
    if (end_index > size) {continue = FALSE; end_index = size}
    if (end_index == size) {continue = FALSE; end_index = end_index}
    idx = start_index:end_index

    # subset data
    if (axis == 0) {
      df_tmp = df[idx, ]
    } else {
      df_tmp = df[, idx]
    }

    # save data
    file_path = file.path(data_dir, sprintf("comp_%s.csv", iter))
    utils::write.csv(df_tmp, file_path, row.names = FALSE)
    iter = iter + 1
  }
  print(paste("Split:", data_file))
  print(paste("Data dimension:", nrow(df), ncol(df)))
  print(paste("Number of components:", nb_comp))
  print(paste0("Components saved in: ~/", data_dir))
}
