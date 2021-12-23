#' Adds a column to the df with the human gene name corresponding to the mouse gene
#'
#' This function adds a column `HumanSymbol` to the given df containing the
#' human gene name for the gene present in the column `MouseSymbol`. If no matching gene
#' is found, it adds a NaN value to the column. Uses a conversion file between mouse
#' and human gene symbols (parameter `conversion_file`).
#'
#' @param df Dataframe containing the `MouseSymbol` column
#' @return Dataframe identical to `df`, with an added column called `HumanSymbol`
#' @export
convert_genes_mouse_to_human <- function(df, conversion_file) {
  local_df <- convert_genes(df, conversion_file, "MouseSymbol", "HumanSymbol")
  return(local_df)
}
