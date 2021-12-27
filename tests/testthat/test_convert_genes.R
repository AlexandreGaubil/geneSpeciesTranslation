library(geneSpeciesTranslation)

df <- read.csv('../test-df.csv')
conversion_file_path <- '../mouse-human-genes.csv'

test_that("convert_genes test", {
  expect_equal(convert_genes(df, conversion_file_path, "MouseSymbol", "HumanSymbol"))
  expect_equal(convert_genes_human_to_mouse(df, ))
})
