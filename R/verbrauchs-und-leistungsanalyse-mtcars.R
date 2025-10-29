# Prüfe und installiere benötigte Pakete automatisch
packages <- c("tidyverse", "GGally")

installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed])
}

# Lade Pakete
library(tidyverse)
library(GGally)

# Zeige die ersten Zeilen
head(mtcars)

# Struktur und Variablen prüfen
str(mtcars)

# Häufigkeitstabelle der Zylinderanzahl (Base R)
zylinder_tabelle <- table(mtcars$cyl)
print(zylinder_tabelle)

# Relative Häufigkeit in Prozent
prop.table(zylinder_tabelle) * 100

# Alternative mit dplyr
mtcars %>% count(cyl) %>% mutate(anteil = n / sum(n) * 100)

# Mittelwert und Median berechnen (mpg)
mean(mtcars$mpg)
median(mtcars$mpg)

# Modus berechnen (häufigster Wert)
modus_tabelle <- table(mtcars$mpg)
names(modus_tabelle)[which.max(modus_tabelle)]

# Varianz
var(mtcars$mpg)

# Standardabweichung
sd(mtcars$mpg)  

# Spannweite (min, max)
range(mtcars$mpg)    

# Spannweite als Differenz
diff(range(mtcars$mpg)) 

# Quantile und Interquartilsabstand
quantile(mtcars$mpg)
IQR(mtcars$mpg)

# Beziehung zwischen Zylinderanzahl und Getriebeart

# Kreuztabelle von Zylindern und Getriebetyp
kreuztabelle <- table(mtcars$cyl, mtcars$am)
print(kreuztabelle)

# Alternative mit dplyr
mtcars %>% count(cyl, am)

# Balkendiagramm: Häufigkeit der Zylinderanzahl
ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Häufigkeit der Zylinderanzahl",
    x = "Zylinder",
    y = "Anzahl der Autos"
  ) +
  theme_minimal()

# Boxplot: Kraftstoffverbrauch (mpg) nach Zylinderanzahl
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(
    title = "Kraftstoffverbrauch nach Zylinderanzahl",
    x = "Zylinder",
    y = "Kraftstoffverbrauch"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Boxplot: Kraftstoffverbrauch nach Getriebeart
ggplot(mtcars, aes(x = factor(am), y = mpg, fill = factor(am))) +
  geom_boxplot() +
  labs(
    title = "Kraftstoffverbrauch nach Getriebeart",
    x = "Getriebeart (0 = Automatik, 1 = Schaltgetriebe)",
    y = "Kraftstoffverbrauch"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Scatterplot: mpg vs. Gewicht (wt), farblich nach Zylinder
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(
    title = "Verbrauch vs. Gewicht nach Zylinderanzahl",
    x = "Gewicht (1000 lbs)",
    y = "Kraftstoffverbrauch",
    color = "Zylinder"
  ) + 
  theme_minimal()

# Scatterplot mit Facetten nach Getriebeart (am)
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  facet_wrap(~ am, labeller = as_labeller(c(`0` = "Automatik", `1` = "Schaltgetriebe"))) +
  labs(
    title = "Verbrauch vs. Gewicht nach Zylinderanzahl und Getriebeart",
    x = "Gewicht (1000 lbs)",
    y = "Kraftstoffverbrauch",
    color = "Zylinder"
  ) +
  theme_minimal()

# Scatterplot: Motorleistung (hp) vs. Verbrauch (mpg)
ggplot(mtcars, aes(x = hp, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  labs(
    title = "Kraftstoffverbrauch vs. Motorleistung",
    x = "Motorleistung (hp)", 
    y = "Kraftstoffverbrauch",
    color = "Zylinder"
  ) +
  theme_minimal()

# Gewicht vs. Beschleunigung (Viertelmeile, qsec)
ggplot(mtcars, aes(x = wt, y = qsec, color = factor(cyl))) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dotted") +
  labs(
    title = "Beschleunigung (Viertelmeile) vs. Gewicht",
    x = "Gewicht (1000 lbs)",
    y = "Beschleunigungszeit qsec",
    color = "Zylinder"
  ) +
  theme_minimal()

library(ggplot2)
library(dplyr)
library(patchwork)

# mtcars vorbereiten
mtcars2 <- mtcars %>% 
  mutate(cyl = factor(cyl))

# Farben für Zylinder
zylinder_colors <- c("4" = "#66c2a5", "6" = "#fc8d62", "8" = "#8da0cb")

# Einzelplots erstellen
p1 <- ggplot(mtcars2, aes(x=mpg, y=hp, color=cyl)) +
  geom_point(size=3) +
  scale_color_manual(values=zylinder_colors, name="Zylinder") +
  theme_minimal() +
  labs(x="mpg", y="hp")

p2 <- ggplot(mtcars2, aes(x=mpg, y=wt, color=cyl)) +
  geom_point(size=3) +
  scale_color_manual(values=zylinder_colors, name="Zylinder") +
  theme_minimal() +
  labs(x="mpg", y="wt")

p3 <- ggplot(mtcars2, aes(x=mpg, y=qsec, color=cyl)) +
  geom_point(size=3) +
  scale_color_manual(values=zylinder_colors, name="Zylinder") +
  theme_minimal() +
  labs(x="mpg", y="qsec")

p4 <- ggplot(mtcars2, aes(x=hp, y=wt, color=cyl)) +
  geom_point(size=3) +
  scale_color_manual(values=zylinder_colors, name="Zylinder") +
  theme_minimal() +
  labs(x="hp", y="wt")

# Matrix zusammenfügen (2x2)
(p1 | p2) / (p3 | p4) +
  plot_annotation(
    title = "Paarweise Zusammenhänge zwischen Kraftstoffverbrauch (mpg),\nMotorleistung (hp), Gewicht (wt) und Beschleunigung (qsec)"
  )

library(dplyr)
library(ggplot2)
library(reshape2)

# mtcars vorbereiten
mtcars2 <- mtcars %>% 
  mutate(
    cyl = factor(cyl),
    am = factor(am, labels = c("Automatik", "Manuell"))
  )

# Wichtige Variablen auswählen
vars <- c("mpg", "hp", "wt", "qsec")

# Korrelationsmatrix
cor_mat <- cor(mtcars2[, vars])

# In long format für ggplot umwandeln
cor_long <- melt(cor_mat)

# Heatmap erstellen
ggplot(cor_long, aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,
                       limits = c(-1,1), name = "Korrelation") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 4) +
  theme_minimal() +
  labs(
    title = "Korrelationen im mtcars-Datensatz",
    subtitle = "Kraftstoffverbrauch (mpg), Motorleistung (hp), Gewicht (wt), Beschleunigung (qsec)",
    x = NULL,
    y = NULL
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

