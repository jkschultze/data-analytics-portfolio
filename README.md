# Data Analytics Portfolio

Willkommen in meinem Data-Analytics-Portfolio.

Ich beschäftige mich mit der Analyse und Aufbereitung von Daten, um belastbare Erkenntnisse zu gewinnen und Entscheidungen zu unterstützen.  
Mein Schwerpunkt liegt auf Dashboard-Entwicklung und explorativer Datenanalyse.

Ich arbeite mit folgenden Tools und Sprachen:
- T-SQL auf Azure SQL Server
- Power BI und Power Query
- R (z. B. tidyverse, ggplot2, Shiny für interaktive Dashboards)
- Python (z. B. pandas, numpy, matplotlib, seaborn)
- Excel

Die Projekte enthalten jeweils kurze Beschreibungen, verwendete Tools sowie ausgewählte Visualisierungen.

---

## Inhaltsverzeichnis

1. [Redaktions- und Web-Analytics-Dashboards](#redaktions--und-web-analytics-dashboards)
2. [US Superstore Analyse (2014–2017)](#us-superstore-analyse-2014–2017)
3. [Marktanalyse: Immobilienpreise in Deutschland](#marktanalyse-immobilienpreise-in-deutschland)
4. [R Data Portfolio](#r-data-portfolio)  
   - [Mtcars: Verbrauchs- und Leistungsanalyse](#mtcars-verbrauchs--und-leistungsanalyse)  
   - [Airquality & CO2: Umweltdatenanalyse](#airquality--co2-umweltdatenanalyse)  
   - [Star Wars Charakteranalyse](#star-wars-charakteranalyse)  
   - [Chickwts: Futteranalyse](#chickwts-futteranalyse)  
   - [Wetter Finnland 2017](#wetter-finnland-2017)  
   - [Warpbreaks: Fadenbruchanalyse](#warpbreaks-fadenbruchanalyse)  
   - [R Grundlagen](#r-grundlagen)

---

## Redaktions- und Web-Analytics-Dashboards

Die folgenden Projekte analysieren Inhalte, Nutzerverhalten und redaktionelle Muster. Sie kombinieren Python, R und Power BI und zeigen, wie sich redaktionelle Daten modellieren und visualisieren lassen.

### 1. NYT Content Dashboard (Python + Power BI)

![Dashboard-Visualisierung](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Screenshot_NYT_Dashboard.png) 

[Zum interaktiven Dashboard](https://app.powerbi.com/view?r=eyJrIjoiYzllY2UzNjQtN2QwNy00MjFiLWEwNDMtZjQyOGU5NWRkNWRlIiwidCI6Ijg3NDg3NTRjLTcyZDMtNDdiNy1hNzQ5LWRlNTI1YTQwNzY2NCJ9)

Analyse der „Most Popular“ und „Most Shared“ Artikel der New York Times über die NYT API.  
Daten werden per Python-Skript automatisiert abgerufen, bereinigt und historisiert.  
Das Power-BI-Dashboard zeigt u. a.:

- Häufigste Themen, Personen, Orte und Organisationen  
- Verteilung der Ressorts  
- Veröffentlichungszeiten  
- Vergleich von meistgelesenen und meistgeteilten Artikeln  

- [Python Script](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Python/NYT_mostpopular_api.py) 
- [Power BI Projekt](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/NYT_Analyse_Dashboard.pbix)

### 2. Website Traffic Analyse (Python)

![Dashboard-Visualisierung](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Screenshot_Website_Traffic_Analyse.png)

Explorative Datenanalyse eines synthetischen Webtraffic-Datensatzes.  
Schwerpunkte:

- Nutzerverhalten, Engagement, Bounce-Verhalten  
- Traffic-Quellen und Kanalvergleich  
- Outlier Detection  
- Korrelationen zwischen Metriken  

- [Jupyter Notebook](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Python/Website%20Traffic.ipynb)
- [Power BI Projekt](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Website%20_Traffic_Analyse.pbix)

### 3. Website Traffic Dashboard (R Shiny)

### Live Demo
[**Website Traffic Dashboard ansehen**](https://jkschultze.shinyapps.io/webtrafficdashboard/)

[![R](https://img.shields.io/badge/R-4.3.1-blue.svg)](https://www.r-project.org/) [![Shiny](https://img.shields.io/badge/Shiny-App-green.svg)](https://shiny.rstudio.com/)

Interaktive Shiny-App zur Visualisierung eines Webtraffic-Datensatzes.  
Funktionalitäten:

- KPI-Analysen  
- Scatterplots, Korrelationen, Segmentvergleiche  
- Interaktive Tabellen und UI-Komponenten  

- **R Script:** [Shiny-App mit vollständiger Analyse](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/app.R) 

---

## US Superstore Analyse (2014–2017)

![Dashboard-Visualisierung](visuals/Dashboard_Retailanalyse_US_Superstore.png) 

Dieses Projekt analysiert den US-Superstore-Datensatz (2014–2017) mithilfe von T-SQL auf einem Azure SQL Server.  
Ziel ist es, Umsatz, Gewinn, Kundenverhalten, Rabattstrategien, Lieferzeiten und regionale Unterschiede zu untersuchen.

Weitere Inhalte:
- Datenbereinigung
- KPI-Analysen zu Umsatz, Gewinn, Marge, Segmenten, Produkten
- RFM-Analysen
- Zeitreihen zur Umsatz- und Gewinnentwicklung
- Lieferzeiten-Analyse
- Regionale Auswertung

Tools & Technologien:
- Azure SQL Server
- T-SQL
- DBeaver
- GitHub

- [SQL Skript für die Analyse](SQL/US_Superstore_Analytics.sql)

---

## Marktanalyse: Immobilienpreise in Deutschland

![Dashboard-Visualisierung](visuals/Dashboard_Marktanalyse_Immobilien.png)

Dieses Projekt analysiert Daten zu Immobilienpreisen, Mietrenditen und Erschwinglichkeit in 26 deutschen Städten.  
Die Analyse wurde in Power BI erstellt und nutzt Power Query zur Datenaufbereitung.

Schwerpunkte:
- Preis-Einkommens-Verhältnisse
- Mietrenditen
- Erschwinglichkeitsklassifizierung
- KPI- und Dashboard-Visualisierungen

Tools & Technologien:
- Power BI
- Power Query
- GitHub

[Power BI Projekt](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Power%20BI%20/Marktanalyse%20Immobilienpreise%20in%20Deutschland.pbix)

[Zum Report als PDF](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Power%20BI%20/Report%20Marktanalyse%20Immobilienpreise%20in%20Deutschland.pdf)

---

## R Data Portfolio

### Mtcars: Verbrauchs- und Leistungsanalyse

![Visualisierung](visuals/Dashboard_mtcars_Leistungsanalyse.png)

**Beschreibung:**  
Analyse technischer Fahrzeugkennzahlen wie Motorleistung, Gewicht und Kraftstoffverbrauch bei 32 Automodellen.

**Markdown File:** [verbrauchs-und-leistungsanalyse-mtcars.md](R/verbrauchs-und-leistungsanalyse-mtcars.R)  
**R Script:** [verbrauchs-und-leistungsanalyse-mtcars.R](R/verbrauchs-und-leistungsanalyse-mtcars.R)

**Highlights:**
- Scatterplots und Korrelationsanalyse
- Boxplots nach Zylinderzahl und Getriebe
- Tabellarische Übersichten zu Motorleistung & Verbrauch

---

## Airquality & CO2: Umweltdatenanalyse

![Visualisierung](visuals/CO2-Analyse.png)

**Beschreibung:**  
Untersuchung von Wetterdaten (New York) und CO2-Aufnahmeraten unterschiedlicher Pflanzentypen.

**Markdown File:** [umweltdatenanalyse-airquality-und-co2.md](R/umweltdatenanalyse-airquality-und-co2.md)

**R Script:** [umweltdatenanalyse-airquality-und-co2.R](R/umweltdatenanalyse-airquality-und-co2.R)

**Highlights:**
- Temperatur-Histogramme
- Temperatur vs. Ozon (Scatter + Regression)
- CO2-Aufnahme: Boxplots & Balkendiagramme

---

## Star Wars Charakteranalyse

![Visualisierung](visuals/starwars_character.png)

**Beschreibung:**  
Profilanalyse ikonischer Star-Wars-Charaktere: Größe, Masse, Geschlecht, Spezies, Herkunftsplanet, BMI und mehr.

**Markdown File:** [starwars-charakteranalyse.md](R/starwars-charakteranalyse.md)  
**R Script:** [starwars-charakteranalyse.R](R/starwars-charakteranalyse.R)

**Highlights:**
- Größe-vs-Masse Scatter nach Geschlecht
- Häufigkeit verschiedener Spezies
- BMI-Ranking
- Gruppierungen nach Planet, Spezies, Geschlecht

---

## Chickwts: Futteranalyse

![Visualisierung](visuals/chickwts.png)

**Beschreibung:**  
Vergleich von Kükengewichten je Futterart zur Untersuchung möglicher Wachstumsunterschiede.

**Markdown File:** [chickwts-futteranalyse.md](R/chickwts-futteranalyse.md)  
**R Script:** [chickwts-futteranalyse.R](R/chickwts-futteranalyse.R)

**Highlights:**
- Boxplots & Violinplots
- Durchschnittsgewicht pro Futterart
- Einfaches lineares Modell

---

## Wetter Finnland 2017
![Visualisierung](visuals/finnland_weather.png)
**Beschreibung:**  
Auswertung täglicher Klimadaten in Finnland 2017: Temperatur, Niederschlag, Schneehöhe & Saisonalität.

**Markdown File:** [finnland-wetter-2017-monatsstatistiken-und-trends.md](R/finnland-wetter-2017-monatsstatistiken-und-trends.md)  
**R Script:** [finnland-wetter-2017-monatsstatistiken-und-trends.R](R/finnland-wetter-2017-monatsstatistiken-und-trends.R)

**Highlights:**
- Temperatur-Monatsmittel
- Niederschlag-Summen je Monat
- Schneehöhenanalyse & Extremwerte

---

## Warpbreaks: Fadenbruchanalyse

![Visualisierung](visuals/warpbreaks.png)

**Beschreibung:**  
Untersuchung des Bruchverhaltens von Webfäden unter variierenden Spannungen und mit zwei Wolltypen.

**Markdown File:** [warpbreaks-analyse.md](R/warpbreaks-analyse.md)  
**R Script:** [warpbreaks-analyse.R](R/warpbreaks-analyse.R)

**Highlights:**
- Boxplots nach Wolltyp & Spannung
- Lagemaße (Mittelwert, Median, SD)
- Kreuztabellen & Interaktionen

---

## R Grundlagen 
**Beschreibung:**  
Grundlagenübungen zu Datentypen, Datenstrukturen, Kontrollfluss, Funktionen, Statistik, Datenimport & Visualisierung.

**R Script:** [basics.R](R/basics.R)

**Highlights:**
- Arbeiten mit Listen & Dataframes
- Schleifen & Bedingungen
- Statistik-Grundlagen
- Import/Export (CSV, Excel)
- Basis-Plots

---

## Tech-Stack

- T-SQL (Azure SQL Server)
- Power BI
- Power Query
- Python
- R (tidyverse, ggplot2, Shiny)
- GitHub
- Markdown
