# geneSpeciesTranslation

*R package for conversion between the gene symbols of different species*

Functions this package provides:

- `convert_genes(df, conversion_file, old_specie, new_specie)`: This function adds a column (named as the input parameter `new_specie` dictates) to the given df containing the gene symbol for the new specie corresponding to the old specie using the given conversion file. If a list is given as an input (not a data frame), it will just return a list of the corresponding new symbols.
- `convert_genes_human_to_mouse(df, conversion_file)`: Wrapper for `convert_genes` where the old specie name is `HumanSymbol` and the new specie name is `MouseSymbol`.
- `convert_genes_mouse_to_human(df, conversion_file)`: Wrapper for `convert_genes` where the old specie name is `MouseSymbol` and the new specie name is `HumanSymbol`.
