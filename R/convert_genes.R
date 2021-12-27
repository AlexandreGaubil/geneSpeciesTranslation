#' Converts the gene symbols between two species using a given conversion table
#'
#' This function adds a column (named as the input parameter `new_specie` dictates) to
#' the given df containing the gene symbol for the new specie corresponding to the old specie
#' using the given conversion file. If a list is given as an input (not a data frame), it will
#' just return a list of the corresponding new symbols.
#'
#' @param df Data frame or list containing the set of old genes
#' @param conversion_file .csv file containing equivalence b/w the two species' gene symbols
#' @param old_specie Name of column containing the old specie gene symbols
#' @param new_specie Name of column containing the new specie gene symbols
#' @return Data frame with a new column containing the new gene names or list containing the new gene names (matching input type)
#' @export
convert_genes <- function(df, conversion_file, old_specie, new_specie) {
  conversion_table <- read.csv(file = conversion_file)

  if (is.data.frame(df)) {
    df[new_specie] <- apply(df[old_specie],
                          1,
                          function(x) convert_gene(x, conversion_table, old_specie, new_specie))
    return(df)
  }

  # The `df` is a list
  else {
    return(lapply(df, function(x) convert_gene(x, conversion_table, old_specie, new_specie)))
  }
}

#' Convert a gene to a gene symbol for another specie
#'
#' This function converts the given gene to the matching gene for the new specie
#' specified with `new_specie`. If there is no matching mouse gene, then we return NaN.
#'
#' @param gene Name of the old gene
#' @param conversion_file .csv file containing equivalence b/w the two species (names of the column should match `old_specie` and `new_specie` values)
#' @param old_specie Name of column containing the old gene name
#' @param new_specie Name of column containing the new gene name
#' @return Name of the new gene, NaN if no match
convert_gene <- function(gene, conversion_table, old_specie, new_specie) {
  matches <- conversion_table[conversion_table[old_specie] == gene, ]
  nmatches <- nrow(matches)

  # No matching gene was found in the conversion table
  if ((nmatches <= 0) | is.na(nmatches)) {
    return(NaN)
  }

  # FIXME: check the case where entire `matches` df only has NaN rows

  # A single matching gene was found in the conversion table
  else if ((nmatches == 1) | (length(unique(matches[new_specie, ])) == 1)) {
    return(unique(matches[[new_specie]]))
  }

  # Multiple matching genes were found in the conversion table
  else {
    return(unique(matches[[new_specie]]))
  }
}
