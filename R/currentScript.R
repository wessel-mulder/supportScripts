#' Title or description of the function
#'
#' @export

currentScript <- function() {
  # Rscript
  args <- commandArgs(trailingOnly = FALSE)
  path <- sub("^--file=", "", args[grep("^--file=", args)])
  if (length(path)) return(normalizePath(path))

  # source()
  for (i in sys.frames()) {
    if (!is.null(attr(i, "ofile"))) return(normalizePath(attr(i, "ofile")))
  }

  # RStudio
  if (rstudioapi::isAvailable()) {
    ctx <- rstudioapi::getActiveDocumentContext()
    if (nzchar(ctx$path)) return(ctx$path)
  }

  # If all fail
  stop("Unable to determine the current script path.")
}

