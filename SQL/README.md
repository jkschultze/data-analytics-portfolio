# US Superstore Analyse (2014-2017)

![Dashboard-Visualisierung](Dashboard_Retailanalyse_US_Superstore.png) 

---

## Projektbeschreibung
Dieses Projekt analysiert den US Superstore Datensatz (2014-2017) mithilfe von T-SQL auf einem Azure SQL Server.  
Ziel ist es, Umsatz, Gewinn, Kundenverhalten, Rabattstrategien, Lieferzeiten und regionale Unterschiede zu untersuchen.  

---

## Inhalte
Die Analyse umfasst folgende Bereiche:

1. **Datenbereinigung & Transformation**  
   - Entfernen von Duplikaten und NULL-Werten  
   - Bereinigung von Leerzeichen und Spaltennamen  
   - Konvertierung von Datentypen (Datum, Dezimalzahlen)  
   - Erstellung einer bereinigten Tabelle `curated.US_Superstore_clean`

2. **Umsatz- und Gewinn-Analysen**  
   - KPIs: Umsatz, Gewinn, Marge, Durchschnittsrabatte, Bestellungen pro Kunde  
   - Marge nach Produkt, Kategorie und Subkategorie  
   - Top- und Bottom-Produkte/Subkategorien nach Umsatz und Gewinn

3. **Kunden-Analysen**  
   - Umsatz nach Kundensegment (Consumer, Corporate, Home Office)  
   - Top-Kunden nach Umsatz und Gewinn  
   - RFM-Segmentierung (Recency, Frequency, Monetary)  
   - Neukunden pro Jahr und Sättigungstendenzen

4. **Rabatt-Analysen**  
   - Durchschnittlicher Rabatt  
   - Rabatt vs. Gewinn-Analyse  
   - Top- und Bottom-Produkte nach Verlusten durch hohe Rabatte

5. **Zeitreihen- und Saisonalitäts-Analysen**  
   - Umsatz- und Gewinntrends pro Monat/Jahr  
   - Kumulatives Umsatzwachstum  
   - Lieferzeitenanalyse nach Jahr, Monat und Region

6. **Regionale Analysen**  
   - Umsatz, Gewinn und Marge nach Region  
   - Anteil am Gesamtumsatz  
   - Top/Bottom Staaten und Städte nach Bestellungen  

---

## Tools & Technologien
- **SQL Server / T-SQL** auf **Azure SQL Server**  
- **DBeaver** als SQL-Client  
- **GitHub** zur Versionierung und Dokumentation

---

## Datenquelle
US Superstore Dataset (2014–2017)  
Quelle: [Kaggle](https://www.kaggle.com/datasets/juhi1994/superstore)

---

## Dateien im Projekt
- [US Superstore Datensatz (CSV)](US_Superstore_data.csv)
- [SQL-Skript für die Analyse](US_Superstore_Analytics.sql)
- [Dashboard-Visualisierung](Dashboard_Retailanalyse_US_Superstore.png)

---

## Executive Summary – US Superstore Analyse (2014–2017)
### Kundenentwicklung
- Neukundenzuwachs nimmt ab (2014: 595 → 2017: 11), während die Gesamtzahl aktiver Kunden stabil bleibt.
- Bestandskunden tätigen im Schnitt ca. 6 Bestellungen über 4 Jahre → stabiler Umsatz- und Gewinnbeitrag.
- **Handlungsempfehlung:** Gezielte Marketingkampagnen zur Neukundengewinnung starten, insbesondere in Regionen mit niedriger Sichtbarkeit.

### Produkt-Insights
- Top-Seller (Technologieartikel, Stühle, Telefone) treiben Umsatz und Gewinn maßgeblich.
- Weniger profitable Kategorien (Möbel wie Tische, Bücherregale) verursachen Kosten.
- **Handlungsempfehlung:** Top- und Low-Seller zu attraktiven Bundles kombinieren, um Marge zu steigern.

### Kundenbindung & Cross-Selling
- Kundenloyalität ist hoch: einmal gewonnene Kunden bestellen regelmäßig.
- **Handlungsempfehlung:** Cross-Selling, Bundle-Angebote und Coupons einsetzen, z. B. beliebte Stühle mit weniger beliebten Tischen kombinieren.

### Geografische Analyse
- Einige Städte/Regionen haben niedrige Bestellzahlen → ungenutztes Umsatzpotenzial.
- **Handlungsempfehlung:** Marketingmaßnahmen gezielt auf diese Regionen ausrichten.

### Versand & Lieferzeiten
- Lieferzeiten variieren regional; lange Lieferzeiten reduzieren Profitabilität.
- **Handlungsempfehlung:** Versandprozesse optimieren, um Verluste durch verzögerte Lieferungen zu minimieren.
