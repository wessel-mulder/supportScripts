#' Title or description of the function
#'
#' @export
#' @importFrom funspotr spot_funs
unusedPackages <- function(pkgs){
  loadInstall(pkgs)
  funs <- funspotr::spot_funs(rstudioapi::getActiveDocumentContext()$path)
  diff <- setdiff(pkgs,unique(funs$pkgs))
  if(length(diff) == 0){
    print('No unused packages.')
  }
  else{
    print(paste0(length(diff),' unused package.'))
    diff
  }
}

