context('pkgapply')

describe("Iterating using a function", {
  test_that("it can make a trivial change to each package's DESCRIPTION", {
    with_packages({
      pkgapply(pkgs, function(pkg) {
        DESCRIPTION_path <- file.path(pkg$path, 'DESCRIPTION')
        DESCRIPTION <- readLines(DESCRIPTION_path)
        DESCRIPTION <- gsub("Depends: R \\([^(]+\\)", "Depends: R (5.0)", DESCRIPTION)
        writeLines(DESCRIPTION, DESCRIPTION_path)
      })

      for (pkg in pkgs) {
        expect_equal(devtools::as.package(pkg)$depends, "R (5.0)")
      }
    })
  })
})
