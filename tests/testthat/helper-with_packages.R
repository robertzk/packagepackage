# pkgs will be a character vector of packages.
with_packages <- function(expr) {
  dir <- file.path(getwd(), 'packages')
  outdir <- tempdir()
  on.exit(unlink(outdir))
  file.copy(recursive = TRUE, dir, outdir)
  pkgs <- list.files(file.path(outdir, 'packages'), full.names = TRUE)
  eval_env <- list2env(list(pkgs = pkgs), parent = parent.frame())
  eval(substitute(expr), envir = eval_env)
}
