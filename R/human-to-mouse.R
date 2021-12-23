#' Adds a column to the df with the mouse gene name corresponding to the human gene
#'
#' This function adds a column `MouseSymbol` to the given df containing the
#' mouse gene name for the gene present in the column `HumanSymbol`. If no matching gene
#' is found, it adds a NaN value to the column. Uses a conversion file between mouse
#' and human gene symbols (parameter `conversion_file`).
#'
#' @param df Dataframe containing the `HumanSymbol` column
#' @return Dataframe identical to `df`, with an added column called `MouseSymbol`
#' @export
convert_genes_human_to_mouse <- function(df, conversion_file) {
  local_df <- convert_genes(df, conversion_file, "HumanSymbol", "MouseSymbol")
  return(local_df)
}
