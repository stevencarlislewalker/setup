##' Gradients
##'
##' @param expr an expression
##' @param variables variables
##' @return gradient object
##' @export
gradient <- function(expr, variables) {
    if(is.character(expr)) expr <- parse(text = expr)
    out <- setNames(vector("list", length(variables)), variables)
    for(i in seq_along(variables)) {
        out[[i]] <- D(expr, variables[[i]])
    }
    class(out) <- "gradient"
    attr(out, "variables") <- variables
    return(out)
}

##' Hessians
##'
##' @param expr an expression
##' @param variables variables
##' @param hessianOnly well...
##' @return hessian object or list of a gradient and hessian object
##' @export
hessian <- function(expr, variables,
                    hessianOnly = TRUE) {
    if(is.character(expr)) expr <- parse(text = expr)
    outGrad <- gradient(expr, variables)
    n <- length(variables)
    outHess <- vector("list", n^2)
    dim(outHess) <- rep(n, 2)
    for(i in 1:n) {
        for(j in 1:n) {
            outHess[i, j][[1]] <- gradient(outGrad[[i]], variables[j])
        }
    }
    class(outHess) <- "hessian"
    attr(outHess, "variables") <- variables
    if(hessianOnly){
        return(outHess)
    } else {
        return(list(gradient = outGrad,
                    hessian = outHess))
    }
}

##' Convert gradient to data frame
##'
##' @param x see data frame
##' @param row.names see data frame
##' @param optional see data frame
##' @param ... see data frame
##' @return data frame
##' @export
as.data.frame.gradient <- function(x, row.names = NULL,
                                   optional = FALSE, ...) {
    if(is.null(row.names)) row.names <- attr(x, "variables")
    x <- as.data.frame(as.character(x), row.names = row.names,
                       optional = optional, ...)
    return(setNames(x, "gradient"))
}

##' Convert hessian to data frame
##'
##' @param x see data frame
##' @param row.names see data frame
##' @param optional see data frame
##' @param ... see data frame
##' @return data frame
##' @export
as.data.frame.hessian <- function(x, row.names = NULL,
                                  optional = FALSE, ...) {
    if(is.null(row.names)) row.names <- attr(x, "variables")
    out <- sapply(x, as.character)
    dim(out) <- dim(x)
    out <- as.data.frame(out, row.names = row.names,
                         optional = optional, ...)
    return(setNames(out, row.names))
}

##' print gradient
##'
##' @param x gradient
##' @param ... ...
##' @export
print.gradient <- function(x, ...) print(as.data.frame(x))

##' print gradient
##'
##' @param x gradient
##' @param ... ...
##' @export
print.hessian <- function(x, ...) print(as.data.frame(x))


