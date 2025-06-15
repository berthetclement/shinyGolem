library(shinytest2)

# skip()
test_that("{shinytest2} recording: species_values", {
  shiny_app <- run_app()

  app <- AppDriver$new(app_dir = shiny_app,
                       variant = platform_variant(),
                       name = "species_values",
                       height = 893,
                       width = 1619)
  app$expect_screenshot()
  app$expect_values(output = "data_viz_demo_1-sample_data")
  app$set_inputs(`data_viz_demo_1-dataset` = "setosa")
  app$expect_values(output = "data_viz_demo_1-sample_data")
  app$set_inputs(`data_viz_demo_1-dataset` = "versicolor")
  app$expect_values(output = "data_viz_demo_1-sample_data")
  app$set_inputs(`data_viz_demo_1-dataset` = "virginica")
  app$expect_values(output = "data_viz_demo_1-sample_data")
})
