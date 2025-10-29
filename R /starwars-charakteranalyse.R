# Bibliotheken
library(tidyverse)
library(forcats)

# Überblick über den Datensatz
# Überblick über die Struktur des Starwars-Datensatzes
glimpse(starwars)

# Erste 6 Zeilen und Anzahl der Spalten anzeigen
head(starwars)

# Basis-Statistiken
# Anzahl der Charaktere pro Spezies
starwars %>% 
  filter(!is.na(species)) %>% 
  count(species, sort = TRUE)

# Durchschnittliche Größe und Masse pro Geschlecht
starwars %>% 
  filter(!is.na(height) & !is.na(mass) & !is.na(gender)) %>%
  group_by(gender) %>%
  summarise(
    Durchschnittsgröße = mean(height),
    Durchschnittsmasse = mean(mass),
    Anzahl_Charaktere = n()
  )

# Anzahl fehlender Werte
sapply(starwars, function(x) sum(is.na(x)))

# BMI Berechnung
starwars_bmi <- starwars %>%
  filter(!is.na(mass) & !is.na(height)) %>%
  mutate(bmi = mass / (height/100)^2)

# Top 10 Charaktere nach BMI
starwars_bmi %>% arrange(desc(bmi)) %>% select(name, mass, height, bmi) %>% head(10)

# Visualisierungen

# 1. Anzahl der Charaktere pro Spezies
starwars %>% 
  filter(!is.na(species)) %>% 
  ggplot(aes(y = fct_infreq(species))) +
  geom_bar(fill = 'steelblue') +
  labs(title = 'Anzahl der Charaktere pro Spezies', y = 'Spezies', x = 'Anzahl')

# 2. Scatterplot: Masse vs. Größe nach Geschlecht
starwars %>% 
  filter(!is.na(height) & !is.na(mass) & !is.na(gender)) %>%
  ggplot(aes(x = height, y = mass, color = gender)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = 'Masse vs. Größe nach Geschlecht', x = 'Größe (cm)', y = 'Masse (kg)')

# 3. Histogramm: Alter (birth_year)
starwars %>% 
  filter(!is.na(birth_year)) %>%
  ggplot(aes(x = birth_year)) +
  geom_histogram(binwidth = 50, fill = 'lightblue', color = 'black') +
  labs(title = 'Verteilung des Geburtsjahres', x = 'Geburtsjahr', y = 'Anzahl')

# 4. Balkendiagramm: Geschlechterverteilung
starwars %>% 
  filter(!is.na(gender)) %>%
  ggplot(aes(x = gender)) +
  geom_bar(fill = 'salmon') +
  labs(title = 'Geschlechterverteilung', x = 'Geschlecht', y = 'Anzahl')

# 5. Top 10 Heimatwelten
starwars %>% 
  filter(!is.na(homeworld)) %>%
  count(homeworld, sort = TRUE) %>%
  top_n(10) %>%
  ggplot(aes(x = reorder(homeworld, n), y = n)) +
  geom_col(fill = 'lightgreen') +
  coord_flip() +
  labs(title = 'Top 10 Heimatwelten nach Anzahl der Charaktere', x = 'Heimatwelt', y = 'Anzahl')

# 6. BMI-Boxplot nach Geschlecht
starwars_bmi %>%
  filter(!is.na(gender)) %>%
  ggplot(aes(x = gender, y = bmi, fill = gender)) +
  geom_boxplot() +
  labs(title = 'BMI-Verteilung nach Geschlecht', x = 'Geschlecht', y = 'BMI') +
  theme_minimal() +
  theme(legend.position = 'none')

# 7. Scatterplot: Masse vs. Größe facettiert nach Spezies
starwars %>%
  filter(!is.na(height) & !is.na(mass) & !is.na(species)) %>%
  ggplot(aes(x = height, y = mass)) +
  geom_point(alpha = 0.7) +
  facet_wrap(~ species) +
  labs(title = 'Masse vs. Größe nach Spezies', x = 'Größe (cm)', y = 'Masse (kg)')
