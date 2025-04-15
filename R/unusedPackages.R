#' Title or description of the function
#'
#' @export
#' @importFrom funspotr spot_funs
#'

unusedPackages <- function(pkgs){
  loadInstall(pkgs)
  file_path <- currentScript()
  funs <- funspotr::spot_funs(file_path)
  diff <- setdiff(pkgs, unique(funs$pkgs))

  if (length(diff) == 0) {
    message("No unused packages.")
    return(invisible(NULL))
  } else {
    message(paste0( length(diff), " unused package(s):"))
    return(diff)
  }
}

