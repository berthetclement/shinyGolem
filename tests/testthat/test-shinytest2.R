library(shinytest2)

# skip()
test_that("{shinytest2} recording: species_values", {
  # Snapshots (screenshots/values) are recorded against a specific OS + R
  # version via platform_variant() and aren't reproducible on CI runners
  # (different R patch versions, fonts, headless browser rendering).
  skip_on_cran()
  skip_on_ci()

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
