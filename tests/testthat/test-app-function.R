library(shinytest2)

# File: tests/testthat/test-app-function.R
test_that("{shinytest2} recording: first_test", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  shiny_app <- run_app()
  app <- AppDriver$new(shiny_app,
                       variant = platform_variant(),
                       name = "first_test",
                       seed = 3,
                       height = 893,
                       width = 1619)

  app$set_inputs(`data_viz_demo_1-dataset` = "setosa")
  app$set_inputs(`data_viz_demo_1-dataset` = "versicolor")
  app$set_inputs(`data_viz_demo_1-dataset` = "virginica")
  app$set_inputs(`data_viz_demo_1-dataset` = "all iris data")
  app$expect_values()
  app$expect_screenshot()
})
#
# test_that("{shintest2}, sidebarPanel has correct choices", {
#   app <- AppDriver$new(
#     app = shinyApp(
#       ui = mod_data_viz_demo_ui("testid"),
#       server = function(input, output, session) {}
#     )
#   )
#
#   # Check selectInput label
#   label_text <- app$get_text(selector = "label")
#   expect_equal(label_text, c("Choose a flower variety :",
#                              "X variable",
#                              "Y variable",
#                              "Number of observations to view on table:"))
#
#   # Bring select choices values
#   choices <- app$get_values()
#
#   # Check values choices rendered
#   expect_true(all(
#     unlist(choices$input) %in%
#       c("all iris data", "Sepal.Length", "Sepal.Width", "10")
#   ))
# })
