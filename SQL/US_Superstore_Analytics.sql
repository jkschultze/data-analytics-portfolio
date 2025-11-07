/* ##################################################
Projekt: US Superstore Analyse
Autor: Janka Schultze
Beschreibung: Analyse von Umsatz, Gewinn, Kunden, Rabatten und Lieferzeiten
Datensatz: US_Superstore_data (2014-2017)
################################################## */

----------------------------------------------------
/* SECTION 1: Datenbereinigung & Transformation

* Nullwerte, Duplikate, Trenn- und Leerzeichen prüfen 
* Spalten bereinigen
* Datentypen konvertieren 
* Bereinigte Tabelle erstellen -> curated.US_Superstore_clean */
----------------------------------------------------
 

DROP TABLE IF EXISTS curated.US_Superstore_clean;
DROP TABLE IF EXISTS raw.US_Superstore_raw;

-- Schema für Rohdaten
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'raw')
    EXEC('CREATE SCHEMA raw');

-- Schema für bereinigte Daten
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'curated')
    EXEC('CREATE SCHEMA curated');

-- Raw-Tabelle erstellen
CREATE TABLE raw.US_Superstore_raw (
	[Row ID] int NULL,
	[Order ID] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Order Date] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Ship Date] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Ship Mode] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Customer ID] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Customer Name] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Segment varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Country varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	City varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	State varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Postal Code] numeric(18,0) NULL,
	Region varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product ID] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Category varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub-Category] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product Name] varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sales varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Quantity int NULL,
	Discount varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Profit varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);

-- Raw_Tabelle befüllen
INSERT INTO raw.US_Superstore_raw
SELECT *
FROM dbo.US_Superstore_data;

----------- DATA PROFILING ------------

-- Sichtung Struktur 
SELECT COUNT(*) AS No_of_Rows -- Anzahl Zeilen
FROM
raw.US_Superstore_raw;

SELECT COUNT(*) AS No_of_Columns -- Anzahl Spalten
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'US_Superstore_raw';

/* -> Der Datensatz enthält 9994 Zeilen und 21 Spalten */

-- Sichtung der ersten 1000 Zeilen 
SELECT TOP 1000 *
FROM
raw.US_Superstore_raw usr;

/* -> Falsche Datentypen, Spaltennamen inkonsistent, enthalten Leerzeichen */

----------- DATA CLEANING -------------
/* NULL-Werte prüfen
 * Duplikate prüfen
 * Leerzeichen entfernen
 * Spaltennamen vereinheitlichen (alles lower_case, keine Sonderzeichen)
 * Datentypen prüfen: Strings, Zahlen, Datum
 */

-- NULL-Werte aller Spalten anzeigen mit dynamischen SQL-Skript
DECLARE @sql NVARCHAR(MAX) = N'SELECT ';

SELECT @sql = @sql +
    N'SUM(CASE WHEN ' + QUOTENAME(name) +
    N' IS NULL THEN 1 ELSE 0 END) AS ' +
    QUOTENAME(name + N'_Nulls') + N', '
FROM sys.columns
WHERE object_id = OBJECT_ID('raw.US_Superstore_raw');

SET @sql = LEFT(@sql, LEN(@sql) - 1) + N' FROM raw.US_Superstore_raw;';

EXEC sp_executesql @sql;


/* Keine NULL-Werte gefunden */

-- Duplikate anzeigen
SELECT *, COUNT(*) AS DuplicateCount
FROM raw.US_Superstore_raw
GROUP BY 
    [Row ID], [Order ID], [Order Date], [Ship Date], [Ship Mode],
    [Customer ID], [Customer Name], Segment, Country, City, State,
    [Postal Code], Region, [Product ID], Category, [Sub-Category],
    [Product Name], Sales, Quantity, Discount, Profit
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

/* Keine Duplikate gefunden  */

-- Cleaned-Tabelle erstellen
CREATE TABLE curated.US_Superstore_clean (
    row_id INT NULL,
    order_id VARCHAR(50) NULL,
    order_date DATE NULL,
    ship_date DATE NULL,
    ship_mode VARCHAR(50) NULL,
    customer_id VARCHAR(50) NULL,
    customer_name NVARCHAR(100) NULL,
    segment VARCHAR(50) NULL,
    country VARCHAR(50) NULL,
    city VARCHAR(50) NULL,
    state VARCHAR(50) NULL,
    postal_code NVARCHAR(20) NULL,
    region VARCHAR(50) NULL,
    product_id VARCHAR(50) NULL,
    category VARCHAR(50) NULL,
    sub_category VARCHAR(50) NULL,
    product_name NVARCHAR(150) NULL,
    sales DECIMAL(19,4) NULL,
    quantity INT NULL,
    discount DECIMAL(5,4) NULL,
    profit DECIMAL(19,4) NULL
);

-- Cleaned-Tabelle befüllen 
INSERT INTO curated.US_Superstore_clean (
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, customer_name, segment, country, city, state,
    postal_code, region, product_id, category, sub_category,
    product_name, sales, quantity, discount, profit
)
SELECT
    r.[Row ID],
    r.[Order ID],
    TRY_CAST(PARSE(r.[Order Date] AS DATE USING 'de-DE') AS DATE), -- Konvertiere Datumsstring im deutschen Format zu DATE
    TRY_CAST(PARSE(r.[Ship Date] AS DATE USING 'de-DE') AS DATE),
    r.[Ship Mode],
    r.[Customer ID],
    LTRIM(RTRIM(r.[Customer Name])), -- Entferne führende und nachgestellte Leerzeichen
    LOWER(r.Segment), -- Wandel in konsistente Kleinschreibung um
    LOWER(r.Country),
    LOWER(r.City),
    LOWER(r.State),
    TRY_CONVERT(NVARCHAR(20), r.[Postal Code]), -- Wandel Postleitzahl in NVARCHAR um
    LOWER(r.Region),
    r.[Product ID],
    LOWER(r.Category),
    LOWER(r.[Sub-Category]),
    LTRIM(RTRIM(r.[Product Name])),
    TRY_CONVERT(DECIMAL(19,4), -- Wandel in Dezimalzahl um
    REPLACE(LTRIM(RTRIM(r.Sales)), ',', '.') -- Ersetze Dezimaltrennzeichen
 	) AS sales,
	r.Quantity,
	TRY_CONVERT(DECIMAL(5,4),
    REPLACE(LTRIM(RTRIM(r.Discount)), ',', '.')
	) AS discount,
	TRY_CONVERT(DECIMAL(19,4),
    REPLACE(LTRIM(RTRIM(r.Profit)), ',', '.')
	) AS profit
FROM raw.US_Superstore_raw r;

-- Check Up
SELECT TOP 1000 *
FROM
curated.US_Superstore_clean usc;

----------------------------------------------------
/* SECTION 2: Umsatz- und Gewinn-Analysen

- Effizenz berechnen (Marge)
- Top-Kategorien nach Umsatz
- Profitabilität nach Region */
----------------------------------------------------

-- KPIs Gesamtübersicht
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit)/SUM(sales) * 100 AS total_margin_percent,
    AVG(discount) * 100 AS avg_discount_percent,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT customer_id) AS orders_per_customers
FROM curated.US_Superstore_clean;

-- Marge-Spalte hinzufügen
ALTER TABLE curated.US_Superstore_clean
ADD margin_percent DECIMAL(9,4);

UPDATE curated.US_Superstore_clean
SET margin_percent = profit/sales * 100;

-- Umsatz, Gewinn und Marge pro Bestellung 
SELECT 
	sales, 
	profit, 
	margin_percent
FROM curated.US_Superstore_clean;

-- Durchschnittliche Marge in Prozent
SELECT 
	AVG(margin_percent) AS avg_margin_percent
FROM curated.US_Superstore_clean;

-- Marge nach Produkt 
SELECT 
	product_name,
	SUM(profit)/SUM(sales) * 100 AS product_margin
FROM curated.US_Superstore_clean
GROUP BY product_name
ORDER BY product_margin DESC;

-- Marge nach Kategorie und Unterkategorie
SELECT
	category,
	sub_category,
	SUM(profit)/SUM(sales) * 100 AS category_sub_margin
FROM curated.US_Superstore_clean  
GROUP BY category,sub_category 
ORDER BY category_sub_margin DESC;

-- Top-Produkte je Kategorie
WITH product_margins AS (
    SELECT 
        category,
        product_name,
        SUM(profit) / SUM(sales) * 100 AS product_margin,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY SUM(profit) / SUM(sales) * 100 DESC
        ) AS rn
    FROM curated.US_Superstore_clean
    GROUP BY category, product_name
)
SELECT *
FROM product_margins
WHERE rn <= 5
ORDER BY category, product_margin DESC;

/* Aus der Kategorie Technik macht ein Laser-Multifunktionskopierer mit 50 % die größte Gewinnmarge. */

-- Top-Kategorien nach Umsatz
SELECT 
	category,
	SUM(sales) AS category_sales
FROM curated.US_Superstore_clean usc 
GROUP BY usc.category 
ORDER BY category_sales DESC;

/* Technik macht mit 836.154 USD den meisten Umsatz. */

-- Top 10 Subkategorien Umsatz
SELECT TOP 10
	sub_category,
	SUM(sales) AS subcategory_sales
FROM curated.US_Superstore_clean usc 
GROUP BY usc.sub_category 
ORDER BY subcategory_sales DESC;

/* Telefone und Stühle machen den meisten Umsatz. */

-- Bottom 10 Subkategorien Gewinn
SELECT TOP 10
	sub_category,
	SUM(profit) AS subcategory_profit
FROM curated.US_Superstore_clean usc 
GROUP BY usc.sub_category 
ORDER BY subcategory_profit ASC;

/* Stärkste Verluste ergeben sich aus den Subkategorien Tische und Bücherregale. */

-- mit Top 5 und Bottom 5 Subkategorien Gewinn
WITH ranked_subcategories AS (
    SELECT
        sub_category,
        SUM(profit) AS subcategory_profit,
        ROW_NUMBER() OVER (ORDER BY SUM(profit) DESC) AS rn_desc,
        ROW_NUMBER() OVER (ORDER BY SUM(profit) ASC) AS rn_asc
    FROM curated.US_Superstore_clean
    GROUP BY sub_category
)
SELECT 
    sub_category,
    subcategory_profit,
    'Top 5' AS category_rank
FROM ranked_subcategories
WHERE rn_desc <= 5

UNION ALL

SELECT 
    sub_category,
    subcategory_profit,
    'Bottom 5' AS category_rank
FROM ranked_subcategories
WHERE rn_asc <= 5
ORDER BY category_rank, subcategory_profit DESC;

-- Top 10 Subkategorien mit den meisten Bestellungen
SELECT TOP 10
	sub_category,
	COUNT(DISTINCT order_id) AS subcategory_order
FROM curated.US_Superstore_clean usc 
GROUP BY usc.sub_category 
ORDER BY subcategory_order DESC;

----------------------------------------------------
/* SECTION 3: Kunden-Analysen

-- Top-Kunden nach Umsatz und Gewinn
-- RFM-Segmentierung
-- Neukunden pro Jahr */
----------------------------------------------------

-- Umsatz nach Kundensegment
SELECT 
	segment,
	SUM(sales) AS segment_sales
FROM curated.US_Superstore_clean usc 
GROUP BY segment
ORDER BY segment_sales DESC;

/* Privatkunden machen mit 1,2 Mio. USD den größten Umsatz aus, 
 * Home-Office-Kunden mit knapp 430.000 USD den niedrigsten. */

-- Top Kunden nach Umsatz
SELECT TOP 10
    customer_id,
    customer_name,
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM curated.US_Superstore_clean
GROUP BY customer_id, customer_name, segment 
ORDER BY total_sales DESC;

/* Nichtsdestotrotz ist ein Home-Office-Kunde mit 25.000 USD Umsatz auf Platz 1, 
 * dieser macht jedoch zugleich einen Verlust von knapp 2000 USD.
 * Auf Platz 2 ist eine Firmenkundin, die mit 19.000 USD den größten Umsatz macht 
 * und zugleich mit knapp 9000 USD den größten Gewinn. */

-- RFM-Segementierung 
/* R = Recency → Wie kürzlich hat ein Kunde gekauft?
 * F = Frequency → Wie oft kauft ein Kunde?
 * M = Monetary → Wie viel Umsatz generiert ein Kunde? */

-- RFM-Segment-Matrix
WITH rfm_base AS (
    SELECT
        customer_id,
        DATEDIFF(DAY, MAX(order_date), GETDATE()) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM curated.US_Superstore_clean
    GROUP BY customer_id
),
-- RFM-Score vergeben (Low/Medium/High) 
rfm_score AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,
        CASE 
            WHEN recency <= 180 THEN 'High'
            WHEN recency <= 365 THEN 'Medium'
            ELSE 'Low'
        END AS recency_score,
        CASE
            WHEN frequency >= 10 THEN 'High'
            WHEN frequency >= 5 THEN 'Medium'
            ELSE 'Low'
        END AS frequency_score,
        CASE
            WHEN monetary >= 10000 THEN 'High'
            WHEN monetary >= 5000 THEN 'Medium'
            ELSE 'Low'
        END AS monetary_score
    FROM rfm_base
),
rfm_matrix AS (
    SELECT
        recency_score,
        frequency_score,
        monetary_score,
        COUNT(*) AS num_customers,
        SUM(monetary) AS total_sales
    FROM rfm_score
    GROUP BY recency_score, frequency_score, monetary_score
)
SELECT *
FROM rfm_matrix
ORDER BY recency_score DESC, frequency_score DESC, monetary_score DESC;

/* Die Kombination Low-Recency, Medium-Frequency, Medium-Monetary liefert 66 Kunden mit insgesamt 423.744 USD Umsatz. 
 * Kunden mit Low-Recency, Medium-Frequency, Low-Monetary sind dagegen 434,
 * erzielen aber einen deutlich höheren Gesamtumsatz von 1.008.021 USD.
 * High-Recency, High-Frequency, High-Monetary Kunden sind 66 und bringen 357.043 USD Umsatz,
 * zeigen also, dass wenige, wertvolle Kunden viel Umsatz generieren.
 * 
 * -> Reaktivierung inaktiver, aber wertvoller Kunden.
 * -> Bindung der Top-Kunden durch exklusive Angebote.
 * -> Upselling und Cross-Selling bei mittleren Kunden fördern. */

-- Neukunden pro Jahr
WITH first_order AS (
    SELECT 
        customer_id,
        MIN(YEAR(order_date)) AS first_order_year
    FROM curated.US_Superstore_clean
    GROUP BY customer_id
)
SELECT
    first_order_year AS year,
    COUNT(customer_id) AS new_customers
FROM first_order
GROUP BY first_order_year
ORDER BY first_order_year;

/* Von den insgesamt 793 Kunden stammt die Mehrheit mit 595 Neukunden aus dem ersten Jahr (2014).
Danach fällt die Anzahl der Neukunden stark ab, besonders 2016 und 2017 (nur noch 11 Neukunden).
Das deutet auf eine abnehmende Kundenakquise hin. 

-> gezielte Maßnahmen zur Neukundengewinnung ergreifen,
z.B. Marketingkampagnen, Promotions oder Cross-Selling bestehender Kunden.
Gleichzeitig könnte das Unternehmen den Fokus auf Kundenbindung legen,
um bestehende Kunden länger zu halten und den Umsatz pro Kunde zu steigern. */

----------------------------------------------------
/* SECTION 4: Rabatt-Analysen

-- Rabatt vs. Gewinn Scatter
-- Top-Produkte mit hohen Rabatten */
----------------------------------------------------

-- Durchschnittlicher Rabatt
SELECT AVG(discount) * 100 AS avg_discount_percent
FROM curated.US_Superstore_clean;

-- Rabatt vs. Gewinn (Scatterplot)
SELECT
    discount * 100 AS discount_percent,
    profit
FROM curated.US_Superstore_clean
WHERE discount IS NOT NULL;

-- Durchschnittlicher Gewinn nach Rabattstufen
SELECT
    CASE 
        WHEN discount < 0.1 THEN '0-10%'
        WHEN discount < 0.2 THEN '10-20%'
        WHEN discount < 0.3 THEN '20-30%'
        ELSE '30%+'
    END AS discount_range,
    AVG(profit) AS avg_profit,
    COUNT(DISTINCT order_id) AS num_orders
FROM curated.US_Superstore_clean
GROUP BY 
    CASE 
        WHEN discount < 0.1 THEN '0-10%'
        WHEN discount < 0.2 THEN '10-20%'
        WHEN discount < 0.3 THEN '20-30%'
        ELSE '30%+'
    END
ORDER BY discount_range;

/* Geringe Rabatte (0–10 %) machen den Großteil der Bestellungen aus und sind sehr profitabel. 
 * Moderate Rabatte (10–20 %) sind zwar selten, aber am profitabelsten und sollten stärker genutzt werden. 
 * Hohe Rabatte (>20 %) drücken die Marge deutlich,
 * ab 30 % entstehen sogar massive Verluste und sollten daher stark eingeschränkt werden. */

-- Top 10 Verlust-Produkte - Analyse nach Verlust-Treiber
SELECT TOP 10
    product_name,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales,
    AVG(discount) * 100 AS avg_discount_percent,
    COUNT(*) AS num_orders
FROM curated.US_Superstore_clean
GROUP BY product_name
HAVING SUM(profit) < 0     
ORDER BY total_profit; 

/* Die größten Verluste entstehen durch sehr hohe Rabatte (40–53 %) auf teure High-Tech- (z.B. 3D Drucker) und Konferenzmöbel-Produkte. 
 * Wenige Bestellungen reichen aus, um enorme negative Deckungsbeiträge zu erzeugen. 
 * Hauptursache ist daher eine zu aggressive Rabattpolitik — nicht das Produkt selbst. */

----------------------------------------------------
/* SECTION 5: Zeitreihen- und Saisonalitäts-Analysen

-- Umsatztrends pro Monat/Jahr
-- Lieferzeiten-Analyse */
----------------------------------------------------

-- Umsatz und Gewinn nach Jahr und Monat
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- Umsatztrend kumulativ über die Zeit
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales) AS total_sales,
    SUM(SUM(sales)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS cumulative_sales
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- Umsatzwachstum pro Monat
WITH monthly_sales AS (
    SELECT 
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sales) AS total_sales
    FROM curated.US_Superstore_clean
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT *,
       total_sales - LAG(total_sales) OVER (ORDER BY order_year, order_month) AS month_change, -- Umsatz des Vormonats
       (total_sales - LAG(total_sales) OVER (ORDER BY order_year, order_month)) 
       * 100.0 / LAG(total_sales) OVER (ORDER BY order_year, order_month) AS pct_change
FROM monthly_sales
ORDER BY order_year, order_month;

-- Prozentuales Umsatzwachstum pro Jahr
WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(sales) AS total_sales
    FROM curated.US_Superstore_clean
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
)
SELECT
    order_year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY order_year) AS previous_year_sales,
    (total_sales - LAG(total_sales) OVER (ORDER BY order_year)) * 100.0 
        / LAG(total_sales) OVER (ORDER BY order_year) AS pct_growth
FROM yearly_sales
ORDER BY order_year;

-- Umsatzwachstum gesamter Zeitraum (2014-2017)

WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(sales) AS total_sales
    FROM curated.US_Superstore_clean
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
)
SELECT
    MIN(order_year) AS start_year,
    MAX(order_year) AS end_year,
    MIN(total_sales) AS start_sales,
    MAX(total_sales) AS end_sales,
    (MAX(total_sales) - MIN(total_sales)) * 100.0 / MIN(total_sales) AS total_pct_growth
FROM yearly_sales;

/* Insgesamt ist der Umsatz im Zeitraum 2014-2017 von 470.532 USD im ersten Jahr auf 733.215 USD im letzten Jahr,
 * um 55,8 % gestiegen. */

-- Lieferzeit pro Bestellung
SELECT 
	order_id,
	DATEDIFF(DAY, order_date, ship_date) AS delivery_days
FROM curated.US_Superstore_clean usc 
WHERE order_date IS NOT NULL
AND ship_date IS NOT NULL;

-- Durchschnittliche Lieferzeit pro Jahr
SELECT 
	YEAR(order_date) AS order_year,
	AVG(DATEDIFF(DAY, order_date, ship_date)) AS avg_delivery_days
FROM curated.US_Superstore_clean usc 
WHERE order_date IS NOT NULL
AND ship_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- Durchschnittliche Lieferzeit pro Jahr und Monat
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    AVG(DATEDIFF(DAY, order_date, ship_date)) AS avg_delivery_days
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL 
  AND ship_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

/* Durchschnittliche Lieferung liegt zwischen 3-4 Tagen. */

-- Lieferzeitverteilung nach Regionen
SELECT
	region,
    DATEDIFF(DAY, order_date, ship_date) AS delivery_days,
    COUNT(*) AS num_orders
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL 
  AND ship_date IS NOT NULL
GROUP BY region, DATEDIFF(DAY, order_date, ship_date)
ORDER BY region, delivery_days;

/* In allen Regionen schwankt die Lieferzeit von 0-7 Tagen. */

-- Regionen mit häufigen langen Lieferzeiten (5-7 Tage)
SELECT
    region,
    SUM(CASE WHEN DATEDIFF(DAY, order_date, ship_date) BETWEEN 5 AND 7 THEN 1 ELSE 0 END) AS long_deliveries,
    COUNT(*) AS total_orders,
    CAST(SUM(CASE WHEN DATEDIFF(DAY, order_date, ship_date) BETWEEN 5 AND 7 THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100 AS pct_long_deliveries
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL AND ship_date IS NOT NULL
GROUP BY region
ORDER BY pct_long_deliveries DESC;

/* Region Mitte braucht am längsten. Mit 41 Prozent hat sie die häufigsten langen Lieferzeiten von 5-7 Tagen. */

-- Schnellste Lieferungen (0-2 Tage)
SELECT
    region,
    SUM(CASE WHEN DATEDIFF(DAY, order_date, ship_date) BETWEEN 0 AND 2 THEN 1 ELSE 0 END) AS short_deliveries,
    COUNT(*) AS total_orders,
    CAST(SUM(CASE WHEN DATEDIFF(DAY, order_date, ship_date) BETWEEN 0 AND 2 THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100 AS pct_short_deliveries
FROM curated.US_Superstore_clean
WHERE order_date IS NOT NULL AND ship_date IS NOT NULL
GROUP BY region
ORDER BY pct_short_deliveries DESC;

/* Region Westen liefert häufig am schnellsten. Mit 24 Prozent hat sie die kürzesten Lieferzeiten mit 0-2 Tagen. */


---------------------------------------------------
/* SECTION 6: Regionale Analysen

-- Umsatz/Gewinn/Bestellungen nach Region/Bundesstaat/Stadt */
----------------------------------------------------

-- Umsatz nach Region
SELECT 
	region,
	SUM(sales) AS region_sales
FROM curated.US_Superstore_clean
GROUP BY region
ORDER BY region_sales DESC;

-- Anteil Regionen am Umsatz
WITH region_totals AS (
    SELECT
        region,
        SUM(sales) AS region_sales
    FROM curated.US_Superstore_clean
    GROUP BY region
)
SELECT
    region,
    region_sales * 100.0 / SUM(region_sales) OVER () AS pct_of_total
FROM region_totals
ORDER BY pct_of_total DESC;

-- Marge nach Region
SELECT 
	region,
	SUM(profit)/SUM(sales) * 100 AS region_margin
FROM curated.US_Superstore_clean
GROUP BY region 
ORDER BY region_margin DESC;

-- Gewinn nach Region
SELECT 
	region,
	SUM(profit) AS region_profit
FROM curated.US_Superstore_clean
GROUP BY region
ORDER BY region_profit DESC;

-- Rangfolge Umsatz und Gewinn nach Region
SELECT
	region,
	SUM(sales) AS region_sales,
	SUM(profit) AS region_profit,
	RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank,
	RANK() OVER(ORDER BY SUM(profit) DESC) AS profit_rank	
FROM curated.US_Superstore_clean usc 
GROUP BY usc.region
ORDER BY sales_rank, profit_rank;

/* Region West und Ost sind sowohl beim Umsatz als auch beim Gewinn je auf Platz 1 und 2.
 * Der Süden ist beim Umsatz am schlechtesten, etwas besser beim Gewinn.
 * Die Mitte ist dagegen beim Gewinn am schlechtesten, dafür beim Umsatz etwas besser.
 */

-- Top 10 Staaten mit den meisten Bestellungen
SELECT TOP 10
	usc.state ,
	COUNT(DISTINCT order_id) AS total_orders
FROM curated.US_Superstore_clean usc 
GROUP BY state
ORDER BY total_orders DESC;

/* Kalifornien bestellt mit 1021 Bestellungen am meisten, 
 * gefolgt vom Bundesstaat New York mit 562 Bestellungen und deutlichem Abstand. */

-- Top 10 Städte mit den meisten Bestellungen
SELECT TOP 10
	city,
	COUNT(DISTINCT order_id) AS total_orders
FROM curated.US_Superstore_clean usc 
GROUP BY  usc.city 
ORDER BY total_orders DESC;

/* New York City bestellt mit 450 Bestellungen am meisten. */

-- Bottom 10 Staaten mit den wenigsten Bestellungen
SELECT TOP 10
	state,
	COUNT(DISTINCT order_id) AS total_orders
FROM curated.US_Superstore_clean usc 
GROUP BY usc.state 
ORDER BY total_orders;

/* Wyoming bestellt mit nur einer Bestellung innerhalb von vier Jahren am wenigsten. */

---------------