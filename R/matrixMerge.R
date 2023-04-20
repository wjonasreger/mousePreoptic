#' Matrix merge function for Matrix component files
#'
#' @param data_dir A character vector with one element as the path to the directory of components to merge
#' @param verbose A boolean to print result summary (Default: FALSE)
#'
#' @return A dgTMatrix object dataset
#' @export
#'
#' @examples
#' \dontrun{
#' matrixMerge(data_dir = "data/example_data/matrix", verbose = FALSE)
#' }
matrixMerge = function(data_dir, verbose = FALSE) {
  i = c(); j = c(); x = c()
  # list of component files
  file_list = list.files(data_dir)

  # iteratively read in and append data
  for (iter in 1:((length(file_list)-1)/3)) {
    i = c(i, scan(file = file.path(data_dir, sprintf("i_comp_%s.txt", iter)), what = integer(), quiet = TRUE))
    j = c(j, scan(file = file.path(data_dir, sprintf("j_comp_%s.txt", iter)), what = integer(), quiet = TRUE))
    x = c(x, scan(file = file.path(data_dir, sprintf("x_comp_%s.txt", iter)), what = double(), quiet = TRUE))
  }
  Dim = scan(file = file.path(data_dir, "Dim.txt"), what = integer(), quiet = TRUE)

  # create new dgTMatrix
  mat = methods::new("dgTMatrix", i = i, j = j, x = x, Dim = Dim)
  # mat = methods::new("dgCMatrix", i = i, j = j, x = x, Dim = Dim)

  message = paste(
    "Merging objects:",
    paste("  Path:", data_dir),
    paste("  Number of components:", ((length(file_list)-1)/3)),
    paste("  Number of files:", length(file_list)),
    paste("  Data dimension:", length(mat@i), length(mat@j)),
    "", sep = "\n"
  )
  if (verbose) cat(message)
  return (mat)
}
