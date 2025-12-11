# --------------------------
# Bibliotheken laden
# --------------------------
library(shiny)
library(tidyverse)
library(DT)
library(plotly)
library(lubridate)
library(corrplot)

# Daten einlesen
traffic <- read.csv2("data.csv", stringsAsFactors = FALSE, header = TRUE)

# Raw-Kopie erstellen
traffic_raw <- traffic

# --------------------------
# Data Profiling und Bereinigung
# --------------------------

# Datencheck und Übersicht
head(traffic)
str(traffic)
summary(traffic)

# Anzahl leerer Strings pro Spalte
sapply(traffic, function(x) sum(x == "", na.rm = TRUE))

# In NA umwandeln
traffic <- traffic %>% 
  mutate(across(c(TimeSpent, Segments), ~na_if(., "")))

# Prüfen
sapply(traffic, function(x) sum(is.na(x)))

# Achtung: Die folgenden fünf Spalten haben jeweils über 80% fehlende Werte:
# - ViewDepth: 7790 von 9439 Werten fehlen (~82%)
# - TimeSpent: 7790 von 9439 Werten fehlen (~82%)
# - RobotsVisits: 7790 von 9439 Werten fehlen (~82%)
# - Mobility: 7790 von 9439 Werten fehlen (~82%)
# - BounceRate: 7790 von 9439 Werten fehlen (~82%)
#
# Für Analysen und Visualisierungen werden nur die vorhandenen Werte genutzt.

# TimeSpent (Verweildauer) in Sekunden umwanden/neue Spalte
traffic$TimeSpent_sec <- period_to_seconds(hms(traffic$TimeSpent))

# CTR in Prozent berechnen/neue Spalte
traffic <- traffic %>% 
  mutate(
    CTR_percent = ifelse(Impressions > 0, (Clicks / Impressions) * 100, NA),
    TimeSpent_sec = period_to_seconds(hms(TimeSpent))
  )
# ============================================================
# Aggregierte Daten für KPIs
# ============================================================
traffic_agg <- traffic %>%
  filter(!is.na(Segments)) %>%
  group_by(Segments) %>%
  summarise(
    avg_clicks = round(mean(Clicks, na.rm = TRUE), 2),
    avg_time = round(mean(TimeSpent_sec, na.rm = TRUE), 2),
    avg_bounce = round(mean(BounceRate, na.rm = TRUE), 3),
    avg_ctr = round(mean(CTR_percent, na.rm = TRUE), 2),  
    avg_wordcount = round(mean(`Word.Count`, na.rm = TRUE), 1),
    avg_title_length = round(mean(`Title.Length`, na.rm = TRUE), 1),
    avg_meta_length = round(mean(`Meta.Description.Length`, na.rm = TRUE), 1),
    avg_h1_length = round(mean(`H1.Length`, na.rm = TRUE), 1),
    avg_inlinks = round(mean(Inlinks, na.rm = TRUE), 1),
    avg_outlinks = round(mean(Outlinks, na.rm = TRUE), 1),
    count = n()
  ) %>%
  ungroup()


# ============================================================
# Shiny UI
# ============================================================
ui <- fluidPage(
  tags$style(HTML("
    body {
      background-color: #f0f8ff;  
    }
    .well { 
      background-color: #ffffff;  
    }
  ")),
  
  titlePanel("Redaktions-Dashboard – Web Traffic Analyse"),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        "segment",
        "Segment auswählen:",
        choices = traffic_agg$Segments,
        multiple = TRUE,
        options = list(placeholder = 'Bitte Segment wählen...')
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("KPIs", 
                 fluidRow(
                   column(4, verbatimTextOutput("kpi_clicks")),
                   column(4, verbatimTextOutput("kpi_time")),
                   column(4, verbatimTextOutput("kpi_bounce"))
                 ),
                 fluidRow(
                   column(4, verbatimTextOutput("kpi_ctr")),
                   column(4, verbatimTextOutput("kpi_wordcount")),
                   column(4, verbatimTextOutput("kpi_links"))
                 )
        ),
        tabPanel("Scatterplots",
                 plotlyOutput("scatter_clicks_time"),
                 plotlyOutput("scatter_title_clicks"),
                 plotlyOutput("scatter_word_time")
        ),
        tabPanel("Korrelationen",
                 plotOutput("corr_plot", height = "600px")
        ),
        tabPanel("Rohdaten",
                 DTOutput("table")
        )
      )
    )
  )
)

# ============================================================
# Shiny Server
# ============================================================
server <- function(input, output, session) {
  
  # Gefilterte aggregierte Daten
  filtered_agg <- reactive({
    req(input$segment)
    traffic_agg %>%
      filter(Segments %in% input$segment)
  })
  
  # Gefilterte Rohdaten
  filtered_data <- reactive({
    req(input$segment)
    traffic %>%
      filter(Segments %in% input$segment)
  })
  
  # --------------------------
  # KPI Outputs
  # --------------------------
  output$kpi_clicks <- renderText({
    paste("Ø Clicks:", round(mean(filtered_agg()$avg_clicks, na.rm = TRUE), 2))
  })
  output$kpi_time <- renderText({
    paste("Ø TimeSpent (Sek.):", round(mean(filtered_agg()$avg_time, na.rm = TRUE), 2))
  })
  output$kpi_bounce <- renderText({
    paste("Ø BounceRate:", round(mean(filtered_agg()$avg_bounce, na.rm = TRUE), 3))
  })
  output$kpi_ctr <- renderText({
    paste("Ø CTR (%):", round(mean(filtered_agg()$avg_ctr, na.rm = TRUE), 2), "%")
  })
  output$kpi_wordcount <- renderText({
    paste("Ø Word Count:", round(mean(filtered_agg()$avg_wordcount, na.rm = TRUE), 1))
  })
  output$kpi_links <- renderText({
    paste("Ø Inlinks/Outlinks:", round(mean(filtered_agg()$avg_inlinks, na.rm = TRUE), 1),
          "/", round(mean(filtered_agg()$avg_outlinks, na.rm = TRUE), 1))
  })
  
  # --------------------------
  # Scatterplots
  # --------------------------
  output$scatter_clicks_time <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = TimeSpent_sec, y = Clicks)) +
      geom_point(alpha = 0.5) +
      theme_minimal() +
      labs(title = "Verweildauer vs Clicks", x = "Verweildauer (Sek.)", y = "Clicks")
    ggplotly(p)
  })
  
  output$scatter_title_clicks <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = `Title.Length`, y = Clicks)) +
      geom_point(alpha = 0.5, color = "darkgreen") +
      theme_minimal() +
      labs(title = "Titel-Länge vs Clicks", x = "Titlel-Länge", y = "Clicks")
    ggplotly(p)
  })
  
  output$scatter_word_time <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = `Word.Count`, y = TimeSpent_sec)) +
      geom_point(alpha = 0.5, color = "purple") +
      theme_minimal() +
      labs(title = "Anzahl Wörter vs Verweildauer", x = "Anzahl Wörter", y = "Verweildauer (Sek.)")
    ggplotly(p)
  })
  
  # --------------------------
  # Korrelationen
  # --------------------------
  output$corr_plot <- renderPlot({
    numeric_cols <- filtered_data() %>%
      select(where(is.numeric)) %>%
      select(Clicks, Impressions, CTR_percent, TimeSpent_sec, BounceRate,
             `Word.Count`, `Sentence.Count`, `Title.Length`, `Meta.Description.Length`, `H1.Length`,
             Inlinks, Outlinks)
    
    corr_matrix <- cor(numeric_cols, use = "complete.obs")
    corrplot(corr_matrix, method = "color", type = "upper", tl.col = "black", addCoef.col = "black", number.cex = 0.7)
  })
  
  # --------------------------
  # Rohdaten Tabelle
  # --------------------------
  output$table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10), filter = 'top')
  })
}
# ============================================================
# Shiny-App starten
# ============================================================
shinyApp(ui = ui, server = server)
