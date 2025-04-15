#' Title or description of the function
#'
#' @export

metaGenerator <- function(output_path) {
  # Determine the script path
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    script_path <- tryCatch({
      rstudioapi::getActiveDocumentContext()$path
    }, error = function(e) NULL)
    script_name <- if (!is.null(script_path)) basename(script_path) else "unknown_script.R"
  } else if (!interactive()) {
    # Get script path when running via Rscript
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("^--file=", args, value = TRUE)
    script_path <- if (length(file_arg) > 0) sub("^--file=", "", file_arg) else NULL
    script_name <- if (!is.null(script_path)) basename(script_path) else "unknown_script.R"
  } else {
    script_path <- NULL
    script_name <- "unknown_script.R"
  }

  # Get the current date
  current_date <- Sys.Date()
  
  # Metadata content
  text_content <- paste("Synthesized using", script_name, "on", current_date)
  
  # Write the meta text file
  writeLines(text_content, file.path(output_path, "metaData.txt"))
  
  # If script path is known and exists, copy it too
  if (!is.null(script_path) && file.exists(script_path)) {
    file.copy(script_path, file.path(output_path, 'script_used.R'))
  }
  
  # Print confirmation
  cat(text_content, "\n")
}
