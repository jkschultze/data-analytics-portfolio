# Redaktions- & Web-Analytics Dashboards  

![Dashboard-Visualisierung](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Screenshot_NYT_Dashboard.png) 

Sammlung verschiedener Analyseprojekte zu Web-Traffic, Content-Performance und API-basierten Redaktionsdaten.

---

## Inhaltsverzeichnis
1. [NYT Content-Performance Dashboard (Power BI + Python)](#1-nyt-content-performance-dashboard-power-bi--python)  
2. [Website Traffic Analyse (Python + Power BI)](#2-website-traffic-analyse-python--power-bi)  
3. [Website Traffic Analyse Dashboard (R Shiny)](#3-website-traffic-analyse-dashboard-r-shiny)

---

# 1. NYT Content-Performance Dashboard (Power BI + Python)

## Projektbeschreibung
Dieses Projekt analysiert die meistgelesenen und meistgeteilten Artikel der New York Times mithilfe der NYT Most Popular API.  
Ein Python-Script ruft wöchentlich Daten ab (Most Viewed und Most Shared) und speichert sie als historische CSV-Dateien, die anschließend in Power BI visualisiert werden.

## Zielsetzung
- Redaktionelle Trends und Themencluster erkennen  
- Analyse häufig geteilter Inhalte nach Kanal (E-Mail, Facebook)  
- Facet-Analysen zu Personen und Themen  
- Zeitliche Muster von Veröffentlichungen untersuchen  

## Inhalte
### Python-Teil
- Abruf der "Most Viewed" und "Most Shared" Artikel (7-Tage-Fenster)
- Erstellung und Pflege historischer Datensätze
- Vermeidung von Duplikaten
- Umbenennen der Spalten für redaktionelle Ausdrucksweise

### Power-BI-Dashboard
- Analyse der meistgelesenen Artikel nach Zeitraum  
- Analyse der meistgeteilten Artikel pro Kanal  
- Visualisierung von Facets (Personen, Deskriptoren)  
- Darstellung der Ressort-Verteilung  
- Zeitliche Entwicklung der Veröffentlichungsaktivität  

## Tools & Technologien
- Python (requests, pandas)
- NYT Most Popular API
- Power BI

## Dateien im Projekt
- [Python Script](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Python/NYT_mostpopular_api.py) 
- [Ordner mit historischen Daten](https://github.com/jkschultze/data-analytics-portfolio/tree/main/WebTrafficDashboards/nyt_csvs)  
- [Power-BI-Dashboard](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/NYT_Analyse_Dashboard.pbix)

---

# 2. Website Traffic Analyse (Python + Power BI)

![Dashboard-Visualisierung](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Screenshot_Website_Traffic_Analyse.png)

## Projektbeschreibung
Dieses Projekt untersucht einen synthetischen Website-Traffic-Datensatz mithilfe von Python. Die Ergebnisse werden in Power BI visualisiert, um Nutzerverhalten, Traffic-Quellen und Engagement-Faktoren zu analysieren.

## Inhalte

### 1. Datenprofiling
- Struktur, Datentypen, Verteilungen  
- Fehlende Werte und Duplikate  
- Statistische Basisanalyse  

### 2. Explorative Datenanalyse
- Histogramme, Boxplots, Countplots  
- Verteilungen von Page Views, Bounce Rate, Session Duration  
- Pairplots und Korrelationsanalyse  

### 3. Traffic-Quellen
- Analyse der Kanäle: SEO, Social, Direct, Paid, Referral  
- Bewertung der Kanalstärke  

### 4. Engagement-Analyse
- Verweildauer  
- Bounce-Verhalten  
- Datenqualitätsprüfung  

### 5. Ausreißeranalyse
- Identifikation über Boxplots  

## Tools & Technologien
- Python (pandas, numpy, matplotlib, seaborn)
- Jupyter Notebook
- Power BI

## Dateien im Projekt
- [Jupyter Notebook](https://github.com/jkschultze/data-analytics-portfolio/blob/main/Python/Website%20Traffic.ipynb)
- [Power-BI-Dashboard](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/Website%20_Traffic_Analyse.pbix)
- [Originaldatei](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/website_wata.csv)

## Zusammenfassung und Erkenntnisse
1. Organischer Traffic ist der dominante Kanal.  
2. Direkter Traffic ist schwach ausgeprägt.  
3. Die Conversion Rate ist untypisch hoch und nicht realistisch.  
4. Die Metriken zeigen kaum reale Zusammenhänge, da der Datensatz synthetisch ist.

## Empfehlungen
- Fokus auf SEO-Optimierung  
- Breitere Nutzung zusätzlicher Traffic-Kanäle  
- Nutzung echter Nutzungsdaten für Engagement-Analysen  
- Realistische Definition und Messung von Konversionen  

---

# 3. Website Traffic Analyse Dashboard (R Shiny)

## Live Demo
[**Website Traffic Dashboard ansehen**](https://jkschultze.shinyapps.io/webtrafficdashboard/)

[![R](https://img.shields.io/badge/R-4.3.1-blue.svg)](https://www.r-project.org/) [![Shiny](https://img.shields.io/badge/Shiny-App-green.svg)](https://shiny.rstudio.com/)

## Projektbeschreibung
Dieses Projekt nutzt R und Shiny, um ein interaktives Dashboard zu erstellen. Es visualisiert KPIs und Engagement-Metriken und zeigt potenzielle Problemartikel sowie Optimierungsmöglichkeiten auf.

## Inhalte

### Datenbereinigung
- Umwandlung von Zeitvariablen  
- Berechnung der CTR  
- Umgang mit fehlenden Werten  

### KPIs pro Segment
- Durchschnittliche CTR, Verweildauer, Bounce Rate  
- Durchschnittliche Textlänge (Word Count)  
- Links und Artikelanzahl  

### Visualisierungen
- Scatterplots  
- Zusammenhänge zwischen Verweildauer, Klicks, Titel-Länge  
- Korrelationsmatrix  

### Rohdatentabelle
- Interaktive Tabelle mit Filterfunktionen  

### Design
- Klare, strukturierte UI  
- Tab-basierte Navigation  

## Tools & Technologien
- R, Shiny  
- tidyverse  
- DT  
- plotly  
- corrplot  
- lubridate  

## Datenquelle
Website Traffic Dataset (Kaggle)

## Dateien im Projekt
- [Originaldatei](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/data.csv)
- **R Script:** [Shiny-App mit vollständiger Analyse](https://github.com/jkschultze/data-analytics-portfolio/blob/main/WebTrafficDashboards/app.R) 

## Executive Summary
- KPIs unterscheiden sich stark zwischen Segmenten.  
- Artikel mit kurzen Titeln und niedriger CTR sollten optimiert werden.  
- Korrelationen geben Hinweise auf Nutzerverhalten.  
- Dashboard ermöglicht Analyse ohne Programmierkenntnisse.

---
