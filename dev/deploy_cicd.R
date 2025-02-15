# Deploy to Posit Connect or ShinyApps.io
# In command line.
rsconnect::deployApp(
  appName = desc::desc_get_field("Package"),
  account = "devappcbe",
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
