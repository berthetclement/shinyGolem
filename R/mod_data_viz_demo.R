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
     tabPanel("Plots",
               h3("Smooth curve"), plotOutput(ns("curve")),
               h3("Sample data (by 'Species')"),verbatimTextOutput(ns("sample_data"))),
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
#' @importFrom ggplot2 ggplot aes geom_point geom_smooth facet_wrap theme_minimal
#' @importFrom ggplot2 ggtitle theme element_text
#' @importFrom utils head
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
    output$sample_data <- renderPrint({
      dataset <- datasetInput()
      head(dataset)
    })

    # ggpairs + correlation
    output$curve <- renderPlot({
      ggplot(data=datasetInput(),
             aes(x=Sepal.Width,
                 y=Sepal.Length,
                 color=Species)) +
        geom_point() +
        geom_smooth(se=FALSE) +
        facet_wrap(~Species) +
        theme_minimal()+
        ggtitle("Sepal Analysis")+
        theme(plot.title = element_text(size=15))
      })

  })
}

## To be copied in the UI
# mod_data_viz_demo_ui("data_viz_demo_1")

## To be copied in the server
# mod_data_viz_demo_server("data_viz_demo_1")
