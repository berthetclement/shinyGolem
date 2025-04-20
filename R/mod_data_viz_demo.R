#' data_viz_demo UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_data_viz_demo_ui <- function(id) {
  ns <- NS(id)
  tagList(

  )
}

#' data_viz_demo Server Functions
#'
#' @noRd
mod_data_viz_demo_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_data_viz_demo_ui("data_viz_demo_1")

## To be copied in the server
# mod_data_viz_demo_server("data_viz_demo_1")
