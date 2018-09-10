#' Function to get the token for bigquery access
#' @export
#' @return the token to access BigQuery
getToken <-  function() {
  token <- system("gcloud auth application-default print-access-token", intern=TRUE)
  bearer <- sprintf("Bearer %s", token)
  project <- Sys.getenv("GOOGLE_PROJECT")
  samHost <- "sam.dsde-dev.broadinstitute.org"  # note this is PROD; replace with dev Sam in a dev notebook
  samUrl <- sprintf("https://%s/api/google/user/petServiceAccount/%s/key", samHost, project)
  json <- httr::GET(
    url = samUrl,
    httr::content_type_json(),
    httr::add_headers(Authorization = bearer))
  key <- httr::content(json, "text", encoding = "UTF-8")
  return(key)
}
