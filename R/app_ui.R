#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom shinythemes shinytheme
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # enable busy indicators
    useBusyIndicators(),
    # Your application UI logic
    navbarPage("My App",
               theme = shinytheme("flatly"),
               collapsible = TRUE,
               id="nav",

               tabPanel("Data VIZ DEMO",
                        mod_data_viz_demo_ui("data_viz_demo_1")),

               navbarMenu("More",
                          tabPanel("Summary"),
                          "----",
                          "Section header",
                          tabPanel("Table")
               )
    )

  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "shinyGolem"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
