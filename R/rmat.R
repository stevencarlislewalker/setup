##' Random matrix
##'
##' @param rfunc an \code{r} function (e.g. \code{\link{rnorm}})
##' @param nrow,ncol number of rows and columns
##' @param ... parameters to \code{rfunc}
##' @return a random matrix
##' @export
rmat <- function(nrow = 1, ncol = 1, rfunc = rnorm, ...) {
    matrix(rfunc(nrow*ncol, ...), nrow, ncol)
}
