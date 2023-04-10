
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mousePreopticR

<!-- badges: start -->
<!-- badges: end -->

The goal of mousePreopticR is to enable more convenient sharing/loading
of bioinformatics gene expression datasets for analysis in R, in
particular mouse hypothalamic preoptic region cell data from
[GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE113576) and
[DRYAD](https://datadryad.org/stash/dataset/doi:10.5061/dryad.8t8s248).

## Installation

You can install the development version of mousePreopticR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("wjonasreger/mousePreopticR")
```

## Usage

This is a basic example which shows you how to setup the package
datasets for analysis:

***NOTE:* The package datasets are split components of original large
datasets due to GitHub size limits. So, the documented datasets (i.e.,
`ex_data`, `ex_matrix`) need to be composed once after each
install/update of the package. Then package datasets can be loaded
anytime after the initial composition step. You may need to restart your
R session after composition is completed.**

``` r
# load dependency packages
library(Matrix)
# load mousePreopticR package
library(mousePreopticR)

# compose datasets
composeData()
#> Saving objects:
#>   ex_data.Rdata
#> Saving objects:
#>   ex_matrix.Rdata

# load all datasets
#    - load all datasets (Default): loadData(datasets = "all")
#    - load only example datasets: loadData(datasets = "example")
#    - load only bio datasets: loadData(datasets = "bio")
loadData()
#> Loading objects:
#>   ex_data
#> Loading objects:
#>   ex_matrix

# view data (e.g., ex_matrix)
ex_matrix
#> 4 x 5 sparse Matrix of class "dgTMatrix"
#>                  
#> [1,]  . .  . . 30
#> [2,]  . . 30 .  .
#> [3,]  . .  . .  .
#> [4,] 90 .  . .  .
```
