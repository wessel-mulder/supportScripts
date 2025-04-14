library(funspotr)

unusedPackages <- function(pkgs){
  funs <- spot_funs(rstudioapi::getActiveDocumentContext()$path)
  diff <- setdiff(pkgs,unique(funs$pkgs))
  if(length(diff) == 0){
    print('No unused packages.')
  }
  else{
    print(paste0(length(diff),' unused package.'))
    diff
  }
}

