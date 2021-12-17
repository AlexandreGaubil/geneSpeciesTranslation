import_mouse_human_gene_conversion_list <- function() {
  genes_df <- read.csv(file = './mouse-human-genes.csv')
  return(genes_df)
}