#' Title or description of the function
#'
#' @export
#' @importFrom funspotr spot_funs
#'

#' Detect unused packages without explicit pkg::fun() calls
#'
#' @param pkgs A character vector of packages you want to check.
#' @param file_path The path to the R script.
#' @return A vector of unused packages.
unusedPackages <- function(pkgs, file_path) {
  code <- parse(file_path)
  funs <- codetools::findGlobals(code, merge = FALSE)$functions

  find_function_origin <- function(fn) {
    env <- find(fn, mode = "function")
    if (length(env) == 0) return(NA)
    env <- env[1]
    if (startsWith(env, "package:")) {
      return(sub("package:", "", env))
    } else {
      return(NA)
    }
  }

  pkgs_used <- unique(na.omit(sapply(funs, find_function_origin)))
  unused <- setdiff(pkgs, pkgs_used)

  if (length(unused) == 0) {
    message("No unused packages.")
    return(invisible(NULL))
  } else {
    message(paste0(length(unused), " unused package(s):"))
    return(unused)
  }
}
