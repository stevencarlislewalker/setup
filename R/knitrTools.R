##' Run a subset of knitr chunks
##'
##' @param doc character string of a \code{knitr} document
##' @param chunkNames character string vector of chunk names
##' @return run chunks in \code{.GlobalEnv}
##' @export
runChunks <- function(doc, chunkNames) {
    docLines <- unlist(strsplit(readLines(doc), ";"))
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

##' Get chunk names from a knitr document
##'
##' @param doc character string of a \code{knitr} document
##' @return character string vector with names of chunks (basically
##' ... it's good enough anyways)
##' @export
chunkNames <- function(doc) {
    docLines <- unlist(strsplit(readLines(doc), ";"))
    chunkBegin <- grep(knitr::all_patterns$rnw$chunk.begin, docLines, value = TRUE)
    gsub(">>=", "", gsub("<<", "", sapply(strsplit(chunkBegin, ","), "[", 1)))
}

##' Run all lines in a document containing \code{load} and \code{Rda}
##'
##' @param doc character string of a document name
##' @return run lines in \code{.GlobalEnv}
##' @export
loadData <- function(doc) {
    docLines <- unlist(strsplit(readLines(doc), ";"))
    loadCommands <- grep("Rda",
                         grep("load", docLines, value = TRUE),
                         value = TRUE)
    loadExpr <- lapply(loadCommands, function(i) parse(text = i))
    for(i in seq_along(loadExpr)) {
        print(setNames(noquote(loadCommands[[i]]), ""))
        tryCatch(eval(loadExpr[[i]], envir = .GlobalEnv))
    }
}

##' Purl a subset of knitr chunks
##'
##' @param doc character string of a \code{knitr} document
##' @param chunkNames character string vector of chunk names
##' @param filePrefix character string to \code{\link{paste}} in front
##' of \code{doc}
##' @return writes new files
##' @export
purlChunks <- function(doc, chunkNames, filePrefix = ".") {
    docShort <- paste(filePrefix, doc, sep = "")
    docLines <- unlist(strsplit(readLines(doc), ";"))
    begEnd <- sapply(knitr::all_patterns$rnw[c("chunk.begin", "chunk.end")],
                     grep, x = docLines)
    allChunkNames <- chunkNames(doc)
    chunkInds <- match(chunkNames, allChunkNames)
    codeInds <- mapply(":",
                       begEnd[chunkInds, "chunk.begin"],
                       begEnd[chunkInds, "chunk.end"])
    outLines <- character(0)
    for(i in seq_along(codeInds)) {
        outLines <- c(outLines, docLines[codeInds[[i]]])
    }
    writeLines(outLines, docShort)
    purl(docShort)
}
