# globals
utils::globalVariables(c("Species", "Sepal.Length", "Sepal.Width",
                         "Petal.Length", "Petal.Width", "iris"))


#' data_viz_demo UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList busyIndicatorOptions titlePanel sidebarLayout sidebarPanel
mod_data_viz_demo_ui <- function(id) {
  ns <- NS(id)
  tagList(
    busyIndicatorOptions(spinner_type = get_golem_config(value = "spinner_type_app")),
    # Application title
    titlePanel("Descriptive statistics of Iris dataset"),
    sidebarLayout(
      sidebarPanel(
        h3("Filtering data"),
        selectInput(ns("dataset"), "Choose a flower variety :",
                    choices = c("all iris data", "setosa", "versicolor", "virginica")),
        selectInput(ns("Xvar"), "X variable",
                    choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
        selectInput(ns("Yvar"), "Y variable",
                    choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), selected = "Sepal.Width"),
        numericInput(ns("obs"), "Number of observations to view on table:", 10)
  ),

  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
     tabPanel("Descriptive statistics",
               h3("Scatterplot 'global'"), plotOutput(ns("Scatterplot")),
               h3("Descriptive statistics (by 'Species')"),verbatimTextOutput(ns("Summary"))),
      tabPanel("Plot",
               h3("Boxplot"), plotOutput(ns("boxPlot"))),
      tabPanel("Table",
               h3("Table"), textOutput("NbRows"), tableOutput(ns("view")))
  ))

  ) # fin sidebarLayout
  ) # fin tagList
}

#' data_viz_demo Server Functions
#'
#' @noRd
#' @importFrom shiny moduleServer renderPrint renderPlot reactive
#' @importFrom GGally ggpairs wrap
#' @importFrom ggplot2 aes
mod_data_viz_demo_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    ##
    # reactive data part
    ##

    # reactive data (filtered on "Species")
    datasetInput <- reactive({
      switch(input$dataset,
             "all iris data" = iris,
             "setosa" = subset(iris, iris$Species == "setosa"),
             "versicolor" = subset(iris, iris$Species == "versicolor"),
             "virginica" = subset(iris, iris$Species == "virginica"))
    })

    # select one specific column
    colX <- reactive({
      switch(input$Xvar,
             "Sepal.Length" = iris$Sepal.Length,
             "Sepal.Width" = iris$Sepal.Width,
             "Petal.Length" = iris$Petal.Length,
             "Petal.Width" = iris$Petal.Width)
    })

    colY <- reactive({
      switch(input$Yvar,
             "Sepal.Length" = iris$Sepal.Length,
             "Sepal.Width" = iris$Sepal.Width,
             "Petal.Length" = iris$Petal.Length,
             "Petal.Width" = iris$Petal.Width)
    })

    ##
    # OUPUT / summary part
    ##

    # Generate a summary of the dataset (or subset by Iris.Species)
    output$Summary <- renderPrint({
      dataset <- datasetInput()
      summary(dataset)
    })

    # ggpairs + correlation
    output$Scatterplot <- renderPlot({

      ggpairs(iris,
              columns = 1:4,
              aes(color = Species, alpha = 0.5),
              upper = list(continuous = wrap("cor", size = 2.7)))
      })

  })
}

## To be copied in the UI
# mod_data_viz_demo_ui("data_viz_demo_1")

## To be copied in the server
# mod_data_viz_demo_server("data_viz_demo_1")
