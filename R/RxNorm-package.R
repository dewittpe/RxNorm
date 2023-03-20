.onLoad <- function(x, y) {
  rsd <- options()$rxnorm_service_domain
  if (is.null(rsd)) {
    options(rxnorm_service_domain = "https://rxnav.nlm.nih.gov")
  }
}
