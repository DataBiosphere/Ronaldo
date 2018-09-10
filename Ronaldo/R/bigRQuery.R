#' Function to get the token for bigquery access
#
#' @param project google project
#' @param authHost the URL to request the token from
#' @return the token to access BigQuery
getToken <-  function(project, authHost) {
token <- system("gcloud auth application-default print-access-token", intern=TRUE)
bearer <- sprintf("Bearer %s", token)
samUrl <- sprintf("https://%s/api/google/user/petServiceAccount/%s/key", authHost, project)
json <- httr::GET(
  url = samUrl,
  httr::content_type_json(),
  httr::add_headers(Authorization = bearer))
key <- httr::content(json, "text", encoding = "UTF-8")
return(key)
}
