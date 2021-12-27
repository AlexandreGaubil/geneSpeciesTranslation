# FIXME: Fix documentation in this file

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
#' @param old_gene Name of column containing the old gene name
#' @param new_gene Name of column containing the new gene name
#' @return Dataframe with a new column containing the new gene names
#' @export
convert_genes <- function(df, conversion_file, old_gene, new_gene) {
  conversion_table <- read.csv(file = conversion_file)

  if (is.data.frame(df)) {
    df[new_gene] <- apply(df[old_gene],
                          1,
                          function(x) convert_gene(x, conversion_table, old_gene, new_gene))
    return(df)
  }

  # The `df` is a list
  else {
    return(lapply(df, function(x) convert_gene(x, conversion_table, old_gene, new_gene)))
  }
}

#' Convert a mouse gene to a human gene
#'
#' This function converts the given mouse gene to the matching human gene. If
#' there is no matching mouse gene, then we return NaN.
#'
#' @param gene Name of the mouse gene
#' @param conversion_table Dataframe containing the conversion between the new and old gene names
#' @return Name of the human gene, NaN if no match
convert_gene <- function(gene, conversion_table, old_gene, new_gene) {
  matches <- conversion_table[conversion_table[old_gene] == gene, ]
  nmatches <- nrow(matches)

  # No matching mouse gene was found in the conversion df
  if ((nmatches <= 0) | is.na(nmatches)) {
    return(NaN)
  }

  # FIXME: check the case where entire `matches` df only has NaN rows

  # A single matching gene was found in the conversion df
  else if ((nmatches == 1) | (length(unique(matches[new_gene, ])) == 1)) {
    return(unique(matches[[new_gene]]))
  }

  # Multiple matching genes were found in the conversion df
  else {
    return(unique(matches[[new_gene]]))
  }
}
