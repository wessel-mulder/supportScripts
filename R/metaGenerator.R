#' Title or description of the function
#'
#' @importFrom rstudioapi getActiveDocumentContext
#' @export

metaGenerator <- function(output_path) {
  # Get the current date
  current_date <- Sys.Date()
  print(current_date)
  
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    this_file <- rstudioapi::getActiveDocumentContext()$path
    script_name <- this_file
      
  }
  
  
  # Metadata content
  text_content <- paste("Synthesized using", script_name, "on", current_date)
  
  # Write the meta text file
  writeLines(text_content, file.path(output_path, "metaData.txt"))
  
  # If script path is known and exists, copy it too
  file.copy(script_name, file.path(output_path, 'script_used.R'),overwrite =T)
  
  # Print confirmation
  cat(text_content, "\n")
}
