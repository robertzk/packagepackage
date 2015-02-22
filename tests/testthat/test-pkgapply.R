context('pkgapply')
library(testthatsomemore)

describe("Iterating using a function", {
  test_that("it does nothing when passed no packages", {
    assert(pkgapply(c(), identity))
  })

  test_that("it errors when given a non character package", {
    expect_error(pkgapply(5, identity))
  })

  test_that("it errors when the package doesn't exist", {
    expect_error(pkgapply("boop", identity), "No such package")
  })

  change_description <- function(..., check = pkgs) {
    eval.parent(substitute({
      with_packages({
        pkgapply(..., function(pkg) {
          DESCRIPTION_path <- file.path(pkg$path, 'DESCRIPTION')
          DESCRIPTION <- readLines(DESCRIPTION_path)
          DESCRIPTION <- gsub("Depends: R \\([^(]+\\)", "Depends: R (5.0)", DESCRIPTION)
          writeLines(DESCRIPTION, DESCRIPTION_path)
        })

        for (pkg in check) {
          expect_equal(devtools::as.package(pkg)$depends, "R (5.0)")
        }
      })
    }))
  }

  test_that("it can make a trivial change to each package's DESCRIPTION", {
    change_description(pkgs)
  })

  test_that("it can focus on the packages it is told to focus on", {
    change_description(p <- file.path(dirname(pkgs[1]), c("package1", "package3")), check = p)
  })

  test_that("it can be given an explicit dir", {
    change_description(p <- c("package1", "package3"),
      dir = dir <- dirname(pkgs[1]), check = file.path(dir, p))
  })
})
