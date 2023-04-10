library(devtools)

package_path = here::here(); package_path
setwd(package_path)

devtools::load_all()
devtools::document()
devtools::check()

# "illegally" add Rd documentation files to "~/mousePreopticR/man"
# for package datasets that do not technically exist at installation time
# these datasets will exist post-installation when `composeData()` is run
ext_man_path = file.path(package_path, "inst/extdata/man"); ext_man_path
tar_man_path = file.path(package_path, "man"); tar_man_path

rd_files = list.files(ext_man_path); rd_files
file.copy(from = file.path(ext_man_path, rd_files), to = file.path(tar_man_path, rd_files),
          overwrite = TRUE)

devtools::install()

# here::here()
# source(file.path(here::here(), "inst/extdata/setup_package.R"))
