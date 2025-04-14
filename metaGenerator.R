
metaGenerator <- function(output_path){
  # Load the rstudioapi package
  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    script_path <- rstudioapi::getActiveDocumentContext()$path
    script_name <- basename(script_path)  # Just the filename
  } else {
    script_path <- NULL
    script_name <- "unknown_script.R"  # Fallback
  }
  
  # Get the current date
  current_date <- Sys.Date()
  
  # Metadata content
  text_content <- paste("Synthesized using", script_path, "on", current_date)
  
  # Write the meta text file
  writeLines(text_content, file.path(output_path, "metaData.txt"))
  
  # If script path is known, copy it too
  if (!is.null(script_path) && file.exists(script_path)) {
    file.copy(script_path, file.path(output_path, 'script_used.R'))
  }
  
  # Print confirmation
  cat(text_content)
}
