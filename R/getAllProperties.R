#' RxNorm API Call getAllProperties
#'
#' Get categores of properties for the RxNorm concept specifed by rxcui
#'
#' See
#' \url{https://lhncbc.nlm.nih.gov/RxNav/APIs/api-RxNorm.getAllProperties.html}
#' for more details.
#'
#' @param rxcui a string
#' @param ... arguments passed to and from other calls.
#'
#' @references \url{https://lhncbc.nlm.nih.gov/RxNav/APIs/api-RxNorm.getAllProperties.html}
#'
#' @return A data.table
#'
#' @examples
#' \dontrun{
#'
#' getAllProperties("204504")
#'
#' }
#' @export
getAllProperties <- function(rxcui, ...) {
  u <- getOption("rxnorm_service_domain")
  u <- paste0(u, "/REST/rxcui/", rxcui, "/allProperties.json?prop=names+codes+attributes")
  pg <- xml2::read_html(u)
  pg <- rvest::html_text(pg)
  pg <- jsonlite::fromJSON(pg)
  # pg <- data.table::as.data.table(pg$approximateGroup$candidate)
  # data.table::set(pg, j = "term", value = term)
  pg
}

