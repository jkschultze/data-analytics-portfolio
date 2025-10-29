# Bibliotheken
library(tidyverse)

# Luftqualitätsanalyse `airquality`
# Überblick über den Datensatz
head(airquality)
str(airquality)
summary(airquality)

# Visualisierungen

# Histogramm der Tagestemperatur
ggplot(airquality, aes(x = Temp)) +
  geom_histogram(binwidth = 2, color = 'black', fill = 'skyblue') +
  labs(
    title = 'Verteilung der Tagestemperatur in New York',
    x = 'Temperatur (°F)',
    y = 'Häufigkeit'
  ) +
  theme_minimal()

# Scatterplot: Temperatur vs. Ozon
ggplot(airquality, aes(x = Temp, y = Ozone)) +
  geom_point(color = "darkblue") +
  geom_smooth(method = 'lm', se = FALSE, color = "red", linetype = "dashed") +
  labs(
    title = 'Beziehung zwischen Temperatur und Ozonkonzentration',
    x = 'Temperatur (°F)',
    y = 'Ozon (ppb)'
  ) +
  theme_minimal()

# Boxplot: Windgeschwindigkeit pro Monat
ggplot(airquality, aes(x = as.factor(Month), y = Wind, fill = as.factor(Month))) +
  geom_boxplot() +
  labs(
    title = 'Windgeschwindigkeit pro Monat',
    x = 'Monat',
    y = 'Windgeschwindigkeit (mph)'
  ) +
  guides(fill = 'none') +
  theme_minimal()

# Scatterplot: Temperatur vs. Ozon (nach Monat)
airquality_clean <- airquality %>% filter(!is.na(Ozone))

ggplot(airquality_clean, aes(x = Temp, y = Ozone)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = 'lm', se = FALSE, color = "orange") +
  facet_wrap(~ Month) +
  labs(
    title = 'Beziehung zwischen Temperatur und Ozonkonzentration pro Monat',
    x = 'Temperatur (°F)',
    y = 'Ozon (ppb)'
  ) +
  theme_minimal()

# Analyse der Pflanzenphysiologie `CO2`
# Überblick über den Datensatz
head(CO2)
str(CO2)
summary(CO2)

# Durchschnittliche CO₂-Aufnahme nach Pflanzentyp
mean_uptake_type <- CO2 %>%
  group_by(Type) %>%
  summarise(Mean_Uptake = mean(uptake))

ggplot(mean_uptake_type, aes(x = Type, y = Mean_Uptake, fill = Type)) +
  geom_col() +
  labs(
    title = 'Durchschnittliche CO₂-Aufnahme nach Pflanzentyp',
    x = 'Pflanzentyp',
    y = 'Durchschnittliche CO₂-Aufnahme'
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Einfluss von Behandlung und Pflanzentyp
ggplot(CO2, aes(x = Treatment, y = uptake, fill = Type)) +
  geom_boxplot() +
  labs(
    title = 'CO2-Aufnahme nach Behandlung und Pflanzentyp',
    x = 'Behandlung',
    y = 'CO2-Aufnahme'
  ) +
  theme_minimal()

# CO2-Aufnahme im Verhältnis zur CO2-Konzentration
ggplot(CO2, aes(x = conc, y = uptake, color = Type)) +
  geom_point(size = 2) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = 'CO2-Aufnahme in Abhängigkeit von der CO2-Konzentration',
    x = 'CO2-Konzentration (ppm)',
    y = 'CO2-Aufnahme'
  ) +
  theme_minimal()
