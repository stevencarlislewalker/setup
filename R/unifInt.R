##' The Uniform Distribution over the Integers
##'
##' @param x vector of quantiles
##' @param min lower limit (if not integer, it is rounded)
##' @param max upper limit (if not integer, it is rounded)
##' @param n number of observations
##' @param log logical; if TRUE, probabilities p are given as log(p).
##' @name UniformInt
NULL

##' @rdname UniformInt
##' @export
runifInt <- function(n, min = 0, max = 1) {
    sample(round(min):round(max), n, replace = TRUE)
}

##' @rdname UniformInt
##' @export
dunifInt <- function(x, min = 0, max = 1, log = FALSE) {
    d <- ifelse((round(x) < round(min)) | (round(x) > round(max)),
                0, 1/(round(max) - round(min)))
    ifelse(log, log(d), d)
}

# TODO: qunifInt and punifInt
