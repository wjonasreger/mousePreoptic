
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mousePreopticR

<!-- badges: start -->
<!-- badges: end -->

The goal of `mousePreopticR` is to enable more convenient
sharing/loading of bioinformatics gene expression datasets for analysis
in R, in particular mouse hypothalamic preoptic region cell data from
experiments by Moffit et al. The data can be found at
[GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE113576) and
[DRYAD](https://datadryad.org/stash/dataset/doi:10.5061/dryad.8t8s248).

## Installation

You can install the development version of `mousePreopticR` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("wjonasreger/mousePreopticR")
```

Installing the package using `devtools::install_github` may likely have
issues due to memory size of package data. Alternatively, you can
download `mousePreopticR`
[here](https://github.com/wjonasreger/mousePreopticR/archive/refs/heads/master.zip).

You will need to unzip the package folder, remove *“-master”* from the
package folder name, and relocate it to your desired directory, then
install it with the following code using *your own path to the package*.

``` r
install.packages("/Users/wjonasreger/Documents/mousePreopticR", repos = NULL, type="source")
```

## Usage

This is a basic example which shows you how to setup the package
datasets for analysis:

***NOTE:** The package datasets are split components of original large
datasets due to GitHub size limits. So, the documented datasets (i.e.,
`GEO_barcodes`, `GEO_genes`, `GEO_matrix`, `DRYAD_data`) need to be
composed once after each install/update of the package. Then package
datasets can be loaded anytime after the initial composition step. You
may need to restart your R session after composition is completed.*

``` r
## import packages
library(Matrix)
library(mousePreopticR)
library(monocle3)


## compose datasets (only need to run this once after installation)
# duration: ~3 minutes
composeData()


## load bio datasets
#    - load all datasets: loadData(datasets = "all")
#    - load only bio datasets (Default): loadData(datasets = "bio")
#    - load only example datasets: loadData(datasets = "example")
loadData()


## viewing data
# to learn more about a dataset, use ?data_name (e.g., ?GEO_matrix)
?GEO_matrix


## bioinformatics data structure
cds = new_cell_data_set(expression_data = GEO_matrix,
                        cell_metadata = GEO_barcodes,
                        gene_metadata = GEO_genes)
cds
#> class: cell_data_set 
#> dim: 27998 31299 
#> metadata(1): cds_version
#> assays(1): counts
#> rownames(27998): ENSMUSG00000051951 ENSMUSG00000089699 ...
#>   ENSMUSG00000096730 ENSMUSG00000095742
#> rowData names(2): ensembl gene_short_name
#> colnames(31299): AAACCTGAGATGTGGC-1 AAACCTGCACACAGAG-1 ...
#>   TTTGTCATCGTGGGAA-6 TTTGTCATCTTTACAC-6
#> colData names(2): barcode Size_Factor
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Ok, that’s all! You can now play
*[scientist](https://youtu.be/RB-RcX5DS5A)* and do fancy bioinformatics
analysis with the `mousePreopticR` datasets, or even use it’s
convenience functions to manage other datasets as you wish… but that’s
probably *a lot* of work. There are more exquisite ways to spend your
time such as getting coffee with your friend 😄☕ ☕😄

…You’re still here? Ok [watch this](https://youtu.be/xvFZjo5PgG0) for a
cackle ;)
