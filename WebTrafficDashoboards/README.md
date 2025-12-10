# Website Traffic Analyse Dashboard

**Live Demo:**  
[**Website Traffic Dashboard ansehen**](https://jkschultze.shinyapps.io/webtrafficdashboard/)

[![R](https://img.shields.io/badge/R-4.3.1-blue.svg)](https://www.r-project.org/) [![Shiny](https://img.shields.io/badge/Shiny-App-green.svg)](https://shiny.rstudio.com/)

---

## Projektbeschreibung
Dieses Projekt analysiert Website-Traffic-Daten mithilfe von **R** und **Shiny**.  
Ziel ist es, wichtige Kennzahlen (KPIs) zu visualisieren, Nutzerverhalten zu verstehen und Inhalte gezielt zu optimieren.

Die Analyse hilft Redaktionen dabei:  
- Problemartikel zu identifizieren (hohe Bounce Rate, niedrige CTR)  
- Inhalte zu vergleichen und zu verbessern  
- Datengetriebene Entscheidungen zu treffen  

**Datensatz:** Website-Traffic und Kennzahlen zur Nutzerinteraktion
- 2000 Records, 7 Features  
- Informationen über Page Views, Session Duration, Bounce Rate, Traffic Source, Time on Page, Previous Visits, Conversion Rate  

---

## Inhalte
Die Analyse umfasst folgende Bereiche:

1. **Datenbereinigung & Transformation**  
   - Umwandlung von `TimeSpent` in Sekunden  
   - Berechnung der **CTR in Prozent**  
   - Behandlung fehlender Werte (Spalten mit >80 % NA werden ignoriert)  
   - Erstellung aggregierter KPIs pro Segment  

2. **KPIs pro Segment**  
   - Ø Clicks, Verweildauer, BounceRate, CTR (%)  
   - Ø Word Count, Title Length, Meta Description Length, H1 Length  
   - Ø Inlinks/Outlinks und Artikelanzahl  

3. **Scatterplots & Visualisierung**  
   - Verweildauer vs Clicks  
   - Title Length vs Clicks  
   - Word Count vs Verweildauer  

4. **Korrelationen**  
   - Korrelationsmatrix der wichtigsten numerischen Variablen  
   - Analyse von Zusammenhängen zwischen Content- und Traffic-Metriken  

5. **Rohdaten-Tabelle**  
   - Interaktiv mit Filter & Suchfunktion  
   
6. **Design & UI**  
   - Hellblauer Hintergrund im Browser  
   - Weiße Panels für bessere Lesbarkeit  
   - Interaktive Tabs zur übersichtlichen Navigation  

---

## Tools & Technologien
- **R & Shiny** – Interaktive Web-App  
- **tidyverse** – Datenaufbereitung  
- **DT** – Interaktive Tabellen  
- **plotly** – Interaktive Scatterplots  
- **lubridate** – Zeitberechnungen  
- **corrplot** – Korrelationsvisualisierung  

---

## Datenquelle
Website Traffic Dataset  
Quelle: [Kaggle](https://www.kaggle.com/datasets/anthonytherrien/website-traffic)  

---

## Dateien im Projekt
- [Originaldatensatz](data.csv)
- [Shiny-App mit vollständiger Analyse](app.R)  

---

## Executive Summary – Website Traffic Analyse

### Segment-Insights
- CTR und Verweildauer variieren stark zwischen Segmenten.  
- Hohe Bounce Rates identifizieren Inhalte, die optimiert werden müssen.  
- Segmente mit geringer Sichtbarkeit können gezielt gefördert werden.  

### Content-Optimierung
- Artikel mit kurzer Title Length (<30 Zeichen) oder niedriger CTR sind potenzielle Problemfälle.  
- Lange Artikel mit hoher Verweildauer korrelieren meist mit mehr Klicks.  
- **Handlungsempfehlung:** Content-Titel optimieren, Meta-Descriptions verbessern, inhaltlich aufwerten.  

### Traffic- und Nutzerverhalten
- Korrelationen zwischen CTR, BounceRate, Verweildauer und Word Count geben Hinweise auf Nutzerpräferenzen.  
- Segment-Vergleiche helfen bei redaktionellen Entscheidungen für Content-Priorisierung.  

### Design & Usability
- Interaktive Tabellen, Scatterplots und Korrelationen erleichtern die Analyse ohne Programmierkenntnisse.  


---
