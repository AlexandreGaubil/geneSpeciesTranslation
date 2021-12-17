source('load.R')

#' Convert a Mouse Gene to a Human Gene
#'
#' This function converts the given mouse gene to the matching human gene. If 
#' there is no matching mouse gene, then we return NaN.
#'
#' @param gene Name of the mouse gene
#' @return Name of the human gene, NaN if no match
#' @export
mouse_to_human_gene <- function(gene) {
  genes_df <- import_mouse_human_gene_conversion_list()
  
  matches <- genes_df[genes_df$MouseSymbol == gene, ]
  nmatches <- nrow(matches)
  
  # No matching mouse gene was found in the conversion df
  if ((nmatches <= 0) | is.na(nmatches)) {
    return(NaN)
  } 
  
  # A single matching gene was found in the conversion df
  else if ((nmatches == 1) | (length(unique(matches$HumanSymbol)) == 1)) {
    return(matches$HumanSymbol[1])
  }
  
  # Multiple matching genes were found in the conversion df
  else {
    return(matches$HumanSymbol)
  }
}