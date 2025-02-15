# Deploy to Posit Connect or ShinyApps.io

# specific github actions
if (!interactive()) {
  rsconnect::setAccountInfo(
    Sys.getenv("RSCONNECT_USER"),
    Sys.getenv("RSCONNECT_TOKEN"),
    Sys.getenv("RSCONNECT_SECRET")
  )
}

# In command line.
rsconnect::deployApp(
  appName = desc::desc_get_field("Package"),
  appTitle = desc::desc_get_field("Package"),
  appFiles = c(
    # Add any additional files unique to your app here.
    "R/",
    "inst/",
    "data-raw/",
    "NAMESPACE",
    "DESCRIPTION",
    "app.R"
  ),
  appId = rsconnect::deployments(".")$appID,
  lint = FALSE,
  forceUpdate = TRUE
)
