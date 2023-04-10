#' CSV merge function for CSV component files
#'
#' @param data_dir A character vector with one element as the path to the directory of components to merge
#' @param axis A numeric vector with one element to specify axis to merge (0: rows, 1: columns)
#'
#' @return A Data.Frame dataset
#' @export
#'
#' @examples
#' \dontrun{
#' csvMerge(data_dir = "data/example_data/data")
#' }
csvMerge = function(data_dir, axis = 0) {
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
  print(paste("Merge:", data_dir))
  print(paste("Number of components:", length(file_list)))
  print(paste("Data dimension:", nrow(df), ncol(df)))
  return (df)
}
