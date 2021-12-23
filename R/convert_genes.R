#' Adds a column to the df with the human gene name corresponding to the mouse gene
#'
#' This function adds a column `HumanSymbol` to the given df containing the
#' human gene name for the gene present in the column `MouseSymbol`. If no matching gene
#' is found, it adds a NaN value to the column. Uses a conversion file between mouse
#' and human gene symbols (parameter `conversion_file`).
#'
#' @param gene Name of the mouse gene
#' @param conversion_file .csv file containing equivalence b/w human and mouse
#' genes in two columns (HumanSymbol & MouseSymbol)
#' @param old_gene_col Name of column containing the old gene name
#' @param new_gene_col Name of column containing the new gene name
#' @return Dataframe with a new column containing the new gene names
#' @export
convert_genes <- function(df, conversion_file, old_gene_col, new_gene_col) {
  genes_df <- read.csv(file = conversion_file)

  df[new_gene_col] <- apply(df[old_gene_col], 1, function(x) convert_gene(x, genes_df))
  return(df)
}

#' Convert a mouse gene to a human gene
#'
#' This function converts the given mouse gene to the matching human gene. If
#' there is no matching mouse gene, then we return NaN.
#'
#' @param gene Name of the mouse gene
#' @param genes_df Dataframe containing the conversion between the new and old gene names
#' @return Name of the human gene, NaN if no match
convert_gene <- function(gene, genes_df, ogene, ngene) {
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
