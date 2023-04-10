#' Matrix split function for large Matrix files
#'
#' @param data_file A character vector with one element as the path to the file to split
#' @param nb_comp A numeric vector with one element to specify how many components to split the file into
#' @param verbose A boolean to print result summary
#'
#' @export
#'
#' @examples
#' \dontrun{
#' matrixSplit(data_file = "data/example_data/matrix.mtx", nb_comp = 2)
#' }
matrixSplit = function(data_file, nb_comp, verbose = FALSE) {
  # create data directory
  data_dir = utils::head(strsplit(data_file, "[.]")[[1]], -1)
  dir.create(data_dir, showWarnings = FALSE)

  # load data
  mat = Matrix::readMM(data_file)
  # df = read.csv(data_file)
  size = length(mat@i)
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

    # save data subset
    utils::write.table(mat@i[idx], file = file.path(data_dir, sprintf("i_comp_%s.txt", iter)),
                quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\n")
    utils::write.table(mat@j[idx], file = file.path(data_dir, sprintf("j_comp_%s.txt", iter)),
                quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\n")
    utils::write.table(mat@x[idx], file = file.path(data_dir, sprintf("x_comp_%s.txt", iter)),
                quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\n")

    iter = iter + 1
  }

  # save dimension metadata
  file_path = file.path(data_dir, "Dim.txt")
  utils::write.table(mat@Dim, file = file_path,
              quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\n")

  message = paste(
    "Splitting object:",
    paste("  Path:", data_file),
    paste("  Data dimension:", length(mat@i), length(mat@j)),
    paste("  Number of components:", nb_comp),
    paste0("  Components saved in: ~/", data_dir),
    "", sep = "\n"
  )
  if (verbose) cat(message)
}
