# Bibliotheken
packages <- c("tidyverse")
installed <- packages %in% rownames(installed.packages())
if (any(!installed)) install.packages(packages[!installed])
library(tidyverse)

# Überblick über den Datensatz
head(warpbreaks)
str(warpbreaks)

# Häufigkeitsverteilungen
wool_tabelle <- table(warpbreaks$wool)
print(wool_tabelle)
warpbreaks %>% count(wool)

# Kreuztabellen
wool_tension_tbl <- table(warpbreaks$wool, warpbreaks$tension)
print(wool_tension_tbl)
warpbreaks %>% count(wool, tension)
summary(warpbreaks)

# Lage- und Streuungsmaße der Fadenbrüche
mean(warpbreaks$breaks)
median(warpbreaks$breaks)
sd(warpbreaks$breaks)
var(warpbreaks$breaks)
range(warpbreaks$breaks)

# Gruppierte Lagemaße nach Wolltyp
warpbreaks %>%
  group_by(wool) %>%
  summarise(
    mean_brk = mean(breaks),
    median_brk = median(breaks),
    std_brk = sd(breaks)
  )

# Gruppierte Lagemaße nach Wolltyp und Spannung
kombi <- warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(
    mean_break = mean(breaks),
    std_break = sd(breaks)
  )
print(kombi)

# Alternative mit aggregate (Basis R)
aggregate(breaks ~ wool + tension, data = warpbreaks, FUN = mean)
aggregate(breaks ~ wool + tension, data = warpbreaks, FUN = sd)

# Visualisierungen

# Boxplot nach Wolltyp
ggplot(warpbreaks, aes(x = wool, y = breaks, fill = wool)) +
  geom_boxplot() +
  labs(
    title = "Fadenbrüche nach Wolltyp",
    x = "Wolltyp",
    y = "Anzahl der Fadenbrüche"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Boxplot nach Spannung
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_boxplot() +
  labs(
    title = "Fadenbrüche nach Spannung",
    x = "Spannung (niedrig, mittel, hoch)",
    y = "Anzahl der Fadenbrüche"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Kombinierter Boxplot: Wolltyp × Spannung
boxplot(breaks ~ wool * tension, data = warpbreaks,
        col = c('lightgreen', 'lightblue'),
        main = 'Boxplot: Fadenbrüche nach Wolltyp und Spannung',
        xlab = 'Kombination Wolltyp und Spannung',
        ylab = 'Anzahl der Fadenbrüche')

# Mittelwerte mit Fehlerbalken
warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(
    mean_breaks = mean(breaks),
    sd_breaks = sd(breaks)
  ) %>%
  ggplot(aes(x = tension, y = mean_breaks, color = wool, group = wool)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = mean_breaks - sd_breaks, ymax = mean_breaks + sd_breaks), width = 0.1) +
  labs(
    title = "Mittlere Fadenbrüche mit Standardabweichung",
    x = "Spannung",
    y = "Mittlere Anzahl der Fadenbrüche",
    color = "Wolltyp"
  ) +
  theme_minimal()

# Identifikation der Gruppe mit den wenigsten Fadenbrüchen
warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(mean_breaks = mean(breaks)) %>%
  arrange(mean_breaks)
