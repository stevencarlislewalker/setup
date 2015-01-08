##' Run a subset of knitr chunks
##'
##' @param doc character string of a \code{knitr} document
##' @param chunkNames character string vector of chunk names
##' @return run chunks in \code{.GlobalEnv}
##' @export
runChunks <- function(doc, chunkNames) {
    docLines <- readLines(doc)
    begEnd <- sapply(knitr::all_patterns$rnw[c("chunk.begin", "chunk.end")],
                     grep, x = docLines)
    chunkInds <- sapply(chunkNames, grep,
                        x = docLines[begEnd[,"chunk.begin"]])
    codeInds <- mapply(":",
                       begEnd[chunkInds, "chunk.begin"] + 1,
                       begEnd[chunkInds, "chunk.end"] - 1)
    for(i in seq_along(codeInds)) {
        codei <- as.list(docLines[codeInds[[i]]])
        tryCatch(eval(parse(text = codei), envir = .GlobalEnv))
    }
}

##' Run all lines in a document containing \code{load} and \code{Rda}
##'
##' @param doc character string of a document name
##' @return run lines in \code{.GlobalEnv}
##' @export
loadData <- function(doc) {
    docLines <- readLines(doc)
    loadCommands <- grep("Rda",
                         grep("load", docLines, value = TRUE),
                         value = TRUE)
    loadExpr <- lapply(loadCommands, function(i) parse(text = i))
    for(i in seq_along(loadExpr)) {
        print(setNames(noquote(loadCommands[[i]]), ""))
        tryCatch(eval(loadExpr[[i]], envir = .GlobalEnv))
    }
}
