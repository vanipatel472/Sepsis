# Shiny App

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("MIMIC-IV Sepsis Phenotype Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Analysis Controls"),
      sliderInput("k_val", "Number of Clusters (k):", min = 2, max = 10, value = 3),
      radioButtons("viz_type", "Physiological Visualization:",
                   choices = c("K-Means", "HR Distribution")),
      hr(),
      h5("Cohort Metrics"),
      textOutput("cohort_size"),
      br()
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Physiological Analysis", 
                 plotOutput("physPlot"),
                 p("Top: Discovering groups via K-Means. Bottom: Physiological distributions across clusters.")),
        
        tabPanel("Clinical Composition", 
                 plotOutput("compPlot"),
                 p("This chart displays the primary infection sources within each discovered phenotype.")),
        
        tabPanel("Diagnosis Word Cloud", 
                 plotOutput("cloudPlot"),
                 p("The most frequent clinical terms in the cohort."))
      )
    )
  )
)

server <- function(input, output) {
  
  # Reactive Clustering Engine
  run_km <- reactive({
    set.seed(42)
    kmeans(scaled_data, centers = input$k_val, nstart = 25)
  })
  
  output$cohort_size <- renderText({ paste("Analyzing", nrow(hr_features), "Patients") })
  
  # Tab 1: Physiological Plots (Switching between Cluster Map and Ridge Plot)
  output$physPlot <- renderPlot({
    res <- run_km()
    df_plot <- hr_features %>% mutate(phenotype = as.factor(res$cluster))
    
    if (input$viz_type == "K-Means") {
      fviz_cluster(res, data = scaled_data, palette = "jco", 
                   ellipse.type = "convex", geom = "point",
                   main = "Physiological Phenotypes")
    } else {
      ggplot(df_plot, aes(x = mean_hr, y = phenotype, fill = phenotype)) +
        geom_density_ridges(alpha = 0.7) +
        theme_minimal() +
        labs(title = "Heart Rate Intensity by Phenotype", x = "Mean Heart Rate (bpm)", y = "Cluster ID")
    }
  })
  
  output$compPlot <- renderPlot({
    df <- hr_features %>% 
      mutate(pheno = as.factor(run_km()$cluster)) %>% 
      inner_join(primary_dx, by = "stay_id")
    
    ggplot(df, aes(x = pheno, fill = primary_word)) + 
      geom_bar(position = "fill") + 
      theme_minimal() +
      scale_y_continuous(labels = scales::percent) +
      labs(title = "Infection Source Distribution by Phenotype",
           x = "Phenotype Cluster", y = "Composition %", fill = "Diagnosis")
  })
  
  output$cloudPlot <- renderPlot({
    sepsis_tokens %>% 
      count(word) %>% 
      with(wordcloud(word, n, max.words = 30, colors = brewer.pal(8, "Blues")))
  })
}

shinyApp(ui = ui, server = server)

