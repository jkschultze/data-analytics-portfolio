# Bibliotheken
library(tidyverse)

# Überblick über den Datensatz
# Erste Zeilen und Struktur
head(chickwts)
str(chickwts)

# Zusammenfassung
summary(chickwts)

# Lagemaße nach Futterart
# Durchschnitt, Median, Standardabweichung, Min, Max, Anzahl pro Futterart
chickwts_summary <- chickwts %>%
  group_by(feed) %>%
  summarise(
    Durchschnittsgewicht = mean(weight),
    Median_Gewicht = median(weight),
    Std_Gewicht = sd(weight),
    Minimalgewicht = min(weight),
    Maximalgewicht = max(weight),
    Anzahl_Küken = n()
  ) %>%
  arrange(desc(Durchschnittsgewicht))

chickwts_summary

# Visualisierungen

# Boxplot: Gewicht nach Futterart
ggplot(chickwts, aes(x = feed, y = weight, fill = feed)) +
  geom_boxplot() +
  labs(
    title = 'Kükengewicht nach Futterart',
    x = 'Futterart',
    y = 'Gewicht (g)'
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Violinplot + Punktwolke (Jitter)
ggplot(chickwts, aes(x = feed, y = weight, fill = feed)) +
  geom_violin(alpha = 0.6) +
  geom_jitter(width = 0.1, alpha = 0.5) +
  labs(
    title = 'Verteilung der Kükengewichte je Futterart',
    x = 'Futterart',
    y = 'Gewicht (g)'
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Balkendiagramm: Durchschnittsgewicht pro Futterart
ggplot(chickwts_summary, aes(x = reorder(feed, -Durchschnittsgewicht), y = Durchschnittsgewicht, fill = feed)) +
  geom_col() +
  geom_text(aes(label = round(Durchschnittsgewicht,1)), vjust = 1.5, color = "white") +
  labs(
    title = 'Durchschnittliches Kükengewicht pro Futterart',
    x = 'Futterart',
    y = 'Durchschnittliches Gewicht (g)'
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Lineares Modell: Einfluss der Futterart
# Referenzlevel für Futterart festlegen
chickwts$feed <- relevel(chickwts$feed, ref = "horsebean")

# Lineares Modell
model <- lm(weight ~ feed, data = chickwts)

summary(model)
