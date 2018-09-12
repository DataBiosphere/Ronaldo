#' Function to gets the key for the user's pet service account
#' @export
#' @param authEnv the environment to auth against
#' @return the token to access BigQuery
getToken <-  function(authEnv = "prod") {
  token <-
    system("gcloud auth application-default print-access-token",
           intern = TRUE)
  bearer <- sprintf("Bearer %s", token)
  project <- Sys.getenv("GOOGLE_PROJECT")
  samHost <-
    sprintf("sam.dsde-%s.broadinstitute.org", authEnv)  # note this is PROD; replace with dev Sam in a dev notebook
  samUrl <-
    sprintf("https://%s/api/google/user/petServiceAccount/%s/key",
            samHost,
            project)
  json <- httr::GET(url = samUrl,
                    httr::content_type_json(),
                    httr::add_headers(Authorization = bearer))
  key <- httr::content(json, "text", encoding = "UTF-8")
  key
}
