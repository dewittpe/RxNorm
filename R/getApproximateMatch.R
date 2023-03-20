#' RxNorm API Call getApproximateMatch
#'
#' Search for medications that most closely match a given string.
#'
#' See
#' \url{https://lhncbc.nlm.nih.gov/RxNav/APIs/api-RxNorm.getApproximateMatch.html}
#' for more details.
#'
#' @param term a string to serach by
#' @param maxEntries coarse control of number of results (range 1 to 100),
#' default 20
#' @param output format to return results. options are xml, json, data.frame, or
#' data.table.
#' @param ... arguments passed to and from other calls.
#'
#' @references \url{https://lhncbc.nlm.nih.gov/RxNav/APIs/api-RxNorm.getApproximateMatch.html}
#'
#' @return A data.table with columns:
#' \itemize{
#'   \item{rxcui} RxNorm identifier
#'   \item{rxaui} RxNorm RXAUI (string identifier) taht matches
#'   \item{score} Match score (higher is better, among a five set of results)
#'   \item{rank} 1 for all best matches, 2 for all second-best matches, etc.
#'   \item{name} RxNorm concept name
#'   \item{source} Source vocabulary
#'   \item{term} the value of the \code{term} argument passed to
#'   \code{getApproximateMatch}
#' }
#'
#' @examples
#' \dontrun{
#'
#' getApproximateMatch("azthro")
#'
#' }
#' @export
getApproximateMatch <- function(term, maxEntries = 20L, ...) {
  maxEntries <- min(100L, max(1L, floor(maxEntries)))
  u <- getOption("rxnorm_service_domain")
  u <- paste0(u, "/REST/approximateTerm.json?term=", utils::URLencode(term), "&maxEntries=", maxEntries)
  pg <- xml2::read_html(u)
  pg <- rvest::html_text(pg)
  pg <- jsonlite::fromJSON(pg)
  pg <- data.table::as.data.table(pg$approximateGroup$candidate)
  data.table::set(pg, j = "term", value = term)
  pg
}

