# Bibliotheken
library(tidyverse)

# Datensatz einlesen und Überblick
wetter_finnland <- read.csv('data/finnland-weather-2017.csv', header = TRUE)

# Erste Zeilen
head(wetter_finnland)

# Struktur prüfen
str(wetter_finnland)

# Zusammenfassung
summary(wetter_finnland)

# Datenbereinigung & lesbare Spaltennamen
wetter_finnland_leserlich <- wetter_finnland %>% 
  rename(
    Jahr = Year,
    Monat = m,
    Tag = d,
    Zeit = Time,
    Zeitzone = Time.zone,
    `Niederschlag (mm)` = Precipitation.amount..mm.,
    `Schneehöhe (cm)` = Snow.depth..cm.,
    `Temperatur (°C)` = Air.temperature..degC. 
  )

# NA-Werte und Sonderwerte bereinigen
wetter_finnland_bereinigt <- wetter_finnland_leserlich %>%
  mutate(
    `Niederschlag (mm)` = ifelse(`Niederschlag (mm)` == -1, 0, `Niederschlag (mm)`),
    `Schneehöhe (cm)` = as.numeric(ifelse(`Schneehöhe (cm)` %in% c(-1, ''), NA, `Schneehöhe (cm)`))
  )

# Monatliche Aggregation
wetter_finnland_Monate <- wetter_finnland_bereinigt %>% 
  group_by(Monat) %>% 
  summarise(
    Temperatur_Mittel = mean(`Temperatur (°C)`, na.rm = TRUE),
    Temperatur_Max = max(`Temperatur (°C)`, na.rm = TRUE),
    Temperatur_Min = min(`Temperatur (°C)`, na.rm = TRUE),
    Niederschlag_Gesamt = sum(`Niederschlag (mm)`, na.rm = TRUE),
    Schneehöhe_Mittel = mean(`Schneehöhe (cm)`, na.rm = TRUE),
    Tage_Schnee = sum(`Schneehöhe (cm)` > 0, na.rm = TRUE)
  )

wetter_finnland_Monate

# Visualisierungen

# 1. Durchschnittstemperatur pro Monat
ggplot(wetter_finnland_Monate, aes(x = Monat, y = Temperatur_Mittel)) +
  geom_line(color = "tomato", size = 1.2) +
  geom_point(color = "tomato", size = 2) +
  labs(
    title = 'Monatliche Durchschnittstemperatur in Finnland 2017',
    x = 'Monat',
    y = 'Temperatur (°C)'
  ) +
  theme_minimal()

# 2. Gesamtniederschlag pro Monat
ggplot(wetter_finnland_Monate, aes(x = Monat, y = Niederschlag_Gesamt)) +
  geom_col(fill = "steelblue") +
  labs(
    title = 'Gesamtniederschlag pro Monat in Finnland 2017',
    x = 'Monat',
    y = 'Niederschlag (mm)'
  ) +
  theme_minimal()

# 3. Durchschnittliche Schneehöhe pro Monat
ggplot(wetter_finnland_Monate, aes(x = Monat, y = Schneehöhe_Mittel)) +
  geom_col(fill = "lightblue") +
  labs(
    title = 'Durchschnittliche Schneehöhe pro Monat in Finnland 2017',
    x = 'Monat',
    y = 'Schneehöhe (cm)'
  ) +
  theme_minimal()

# 4. Tage mit Schneedecke pro Monat
ggplot(wetter_finnland_Monate, aes(x = Monat, y = Tage_Schnee)) +
  geom_col(fill = "darkblue") +
  labs(
    title = 'Anzahl der Tage mit Schneedecke pro Monat',
    x = 'Monat',
    y = 'Tage'
  ) +
  theme_minimal()
