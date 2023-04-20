#' Table merge function for table component files
#'
#' @param data_dir A character vector with one element as the path to the directory of components to merge
#' @param axis A numeric vector with one element to specify axis to merge (0: rows, 1: columns) (Default: 0)
#' @param verbose A boolean to print result summary (Default: FALSE)
#'
#' @return A Data.Frame dataset
#' @export
#'
#' @examples
#' \dontrun{
#' tableMerge(data_dir = "data/example_data/data", axis = 0, verbose = FALSE)
#' }
tableMerge = function(data_dir, axis = 0, verbose = FALSE) {
  # empty data
  df = c()
  # list of component files
  file_list = list.files(data_dir)
  # iteratively read in and bind components
  for (iter in 1:length(file_list)) {
    df_tmp = utils::read.table( file.path(data_dir, sprintf("comp_%s.tsv", iter)), sep = '\t', header = FALSE )
    if (axis == 0) {
      df = rbind(df, df_tmp)
    } else {
      df = cbind(df, df_tmp)
    }
  }
  message = paste(
    "Merging objects:",
    paste("  Path:", data_dir),
    paste("  Number of components:", length(file_list)),
    paste("  Data dimension:", nrow(df), ncol(df)),
    "", sep = "\n"
  )
  if (verbose) cat(message)
  return (df)
}
