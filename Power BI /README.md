# Marktanalyse: Immobilienpreise in Deutschland (Power BI Projekt)

## Projektübersicht
Dieses Projekt analysiert 26 deutsche Städte hinsichtlich Immobilienpreisen, Mietrenditen und Erschwinglichkeit.  
Ziel ist es, Unterschiede zwischen Städten sichtbar zu machen und Trends im Verhältnis von Einkommen, Mieten und Kaufpreisen aufzuzeigen.  
Erstellt wurde die Analyse in **Power BI** mit Fokus auf KPI-Dashboards, interaktiven Visualisierungen und Datenaufbereitung in **Power Query**.

---

## Datensatz
- Quelle: [Kaggle – Property Prices in Germany (June 2021)](https://www.kaggle.com/)  
- Umfang: **26 Städte**, **9 Kennzahlen**  
- Hinweis: Nicht alle Bundesländer sind vertreten, da nur größere und wirtschaftlich bedeutende Städte erfasst wurden.

**Wichtige Spalten:**
- `PriceToIncomeRatio` – Verhältnis Kaufpreis zu Einkommen  
- `GrossRentalYieldCityCentre` – Bruttomietrendite im Stadtzentrum  
- `GrossRentalYieldOutsideOfCentre` – Bruttomietrendite außerhalb des Zentrums  
- `PriceToRentRatioCityCentre` – Preis-Miet-Verhältnis im Zentrum  
- `PriceToRentRatioOutsideOfCityCentre` – Preis-Miet-Verhältnis außerhalb  
- `MortgageAsAPercentageOfIncome` – Anteil der Hypothek am Einkommen  
- `AffordabilityIndex` – Maß für Leistbarkeit  

---

## Datenaufbereitung
- Umwandlung von Textfeldern in **Dezimalzahlen** (Gebietsschema angepasst)  
- Prüfung auf fehlende Werte – keine Nullwerte vorhanden  
- **Kategorisierung** des Erschwinglichkeitsindex in drei Gruppen:  
  - Sehr erschwinglich  
  - Mittel  
  - Kaum erschwinglich  

---

## KPIs & DAX Measures
Verwendete Kennzahlen im Dashboard:  
- Durchschnittliches **Preis-Einkommens-Verhältnis**  
- Durchschnittliche **Mietrendite (Zentrum & außerhalb)**  
- Durchschnittlicher **Erschwinglichkeitsindex**  
- Anteil der Städte pro **Erschwinglichkeits-Kategorie**  

**Beispiel-DAX:**
```DAX
DurchschnittlichesPreisEinkommen =
AVERAGE('Immobilien'[PriceToIncomeRatio])
