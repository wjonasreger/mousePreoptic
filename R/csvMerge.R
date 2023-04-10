#' CSV merge function for CSV component files
#'
#' @param data_dir A character vector with one element as the path to the directory of components to merge
#' @param axis A numeric vector with one element to specify axis to merge (0: rows, 1: columns)
#' @param verbose A boolean to print result summary
#'
#' @return A Data.Frame dataset
#' @export
#'
#' @examples
#' \dontrun{
#' csvMerge(data_dir = "data/example_data/data")
#' }
csvMerge = function(data_dir, axis = 0, verbose = FALSE) {
  # empty data
  df = c()
  # list of component files
  file_list = list.files(data_dir)
  # iteratively read in and bind components
  for (iter in 1:length(file_list)) {
    df_tmp = utils::read.csv( file.path(data_dir, sprintf("comp_%s.csv", iter)) )
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
