Umweltdatenanalyse: airquality & CO2
================
Janka Schultze
2025-07-15

<br>

**Beschreibung:**  
Hier werden zwei Umweltdatensätze aus dem R-Standardumfang analysiert:  
- `airquality`: Luftqualitätsdaten aus New York (Mai–September 1973),
inklusive Ozon-, Wind- und Temperaturmessungen.  
- `CO2`: Experimentelle Daten zur CO2-Aufnahme zweier Pflanzenarten
unter verschiedenen Behandlungsbedingungen.

**Ziel:**  
Explorative Analyse der Zusammenhänge zwischen Umweltvariablen,
Identifikation von Mustern und Einflussfaktoren auf Luftqualität und
CO2-Aufnahme.

<br>

## Luftqualitätsanalyse `airquality`

#### Bibliotheken

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.1     ✔ stringr   1.5.2
    ## ✔ ggplot2   4.0.0     ✔ tibble    3.3.0
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.1.0     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

<br>

#### Überblick über den Datensatz

``` r
head(airquality)
```

<div data-pagedtable="false">

<script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Ozone"],"name":[1],"type":["int"],"align":["right"]},{"label":["Solar.R"],"name":[2],"type":["int"],"align":["right"]},{"label":["Wind"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Temp"],"name":[4],"type":["int"],"align":["right"]},{"label":["Month"],"name":[5],"type":["int"],"align":["right"]},{"label":["Day"],"name":[6],"type":["int"],"align":["right"]}],"data":[{"1":"41","2":"190","3":"7.4","4":"67","5":"5","6":"1","_rn_":"1"},{"1":"36","2":"118","3":"8.0","4":"72","5":"5","6":"2","_rn_":"2"},{"1":"12","2":"149","3":"12.6","4":"74","5":"5","6":"3","_rn_":"3"},{"1":"18","2":"313","3":"11.5","4":"62","5":"5","6":"4","_rn_":"4"},{"1":"NA","2":"NA","3":"14.3","4":"56","5":"5","6":"5","_rn_":"5"},{"1":"28","2":"NA","3":"14.9","4":"66","5":"5","6":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>

</div>

``` r
str(airquality)
```

    ## 'data.frame':    153 obs. of  6 variables:
    ##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
    ##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
    ##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
    ##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

``` r
summary(airquality)
```

    ##      Ozone           Solar.R           Wind             Temp      
    ##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
    ##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
    ##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
    ##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
    ##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
    ##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
    ##  NA's   :37       NA's   :7                                       
    ##      Month            Day      
    ##  Min.   :5.000   Min.   : 1.0  
    ##  1st Qu.:6.000   1st Qu.: 8.0  
    ##  Median :7.000   Median :16.0  
    ##  Mean   :6.993   Mean   :15.8  
    ##  3rd Qu.:8.000   3rd Qu.:23.0  
    ##  Max.   :9.000   Max.   :31.0  
    ## 

<br>

#### Visualisierungen

``` r
# Verteilungen und Zusammenhänge
# Histogramm der Tagestemperatur

ggplot(airquality, aes(x = Temp)) +
geom_histogram(binwidth = 2, color = 'black', fill = 'skyblue') +
labs(
title = 'Verteilung der Tagestemperatur in New York',
x = 'Temperatur (°F)',
y = 'Häufigkeit'
) +
theme_minimal()
```

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

<br>

``` r
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
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 37 rows containing non-finite outside the scale range
    ## (`stat_smooth()`).

    ## Warning: Removed 37 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

<br>

``` r
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
```

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

<br>

``` r
# Scatterplot: Temperatur vs. Ozon (nach Monat)
# Schreiben
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
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

<br>

### Insights `airquality`

Temperatur und Ozon: Starke positive Beziehung – höhere Temperaturen
gehen meist mit höherer Ozonkonzentration einher.  
Windgeschwindigkeit: Im Sommer (Juli, August) schwankt der Wind stärker,
was auf unterschiedliche Wetterlagen hindeutet.  
Monatsvergleich: Besonders im Juli/August sind Ozonwerte deutlich höher,
vermutlich aufgrund höherer Sonneneinstrahlung.  
Datenqualität: Fehlende Ozonwerte (NA) treten häufig auf – mögliche
Messausfälle oder unvollständige Aufzeichnungen.

<br>

## Analyse der Pflanzenphysiologie `CO2`

#### Überblick über den Datensatz

``` r
head(CO2)
```

<div data-pagedtable="false">

<script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Plant"],"name":[1],"type":["ord"],"align":["right"]},{"label":["Type"],"name":[2],"type":["fct"],"align":["left"]},{"label":["Treatment"],"name":[3],"type":["fct"],"align":["left"]},{"label":["conc"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["uptake"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"95","5":"16.0","_rn_":"1"},{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"175","5":"30.4","_rn_":"2"},{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"250","5":"34.8","_rn_":"3"},{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"350","5":"37.2","_rn_":"4"},{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"500","5":"35.3","_rn_":"5"},{"1":"Qn1","2":"Quebec","3":"nonchilled","4":"675","5":"39.2","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>

</div>

``` r
str(CO2)
```

    ## Classes 'nfnGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':   84 obs. of  5 variables:
    ##  $ Plant    : Ord.factor w/ 12 levels "Qn1"<"Qn2"<"Qn3"<..: 1 1 1 1 1 1 1 2 2 2 ...
    ##  $ Type     : Factor w/ 2 levels "Quebec","Mississippi": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Treatment: Factor w/ 2 levels "nonchilled","chilled": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ conc     : num  95 175 250 350 500 675 1000 95 175 250 ...
    ##  $ uptake   : num  16 30.4 34.8 37.2 35.3 39.2 39.7 13.6 27.3 37.1 ...
    ##  - attr(*, "formula")=Class 'formula'  language uptake ~ conc | Plant
    ##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
    ##  - attr(*, "outer")=Class 'formula'  language ~Treatment * Type
    ##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
    ##  - attr(*, "labels")=List of 2
    ##   ..$ x: chr "Ambient carbon dioxide concentration"
    ##   ..$ y: chr "CO2 uptake rate"
    ##  - attr(*, "units")=List of 2
    ##   ..$ x: chr "(uL/L)"
    ##   ..$ y: chr "(umol/m^2 s)"

``` r
summary(CO2)
```

    ##      Plant             Type         Treatment       conc          uptake     
    ##  Qn1    : 7   Quebec     :42   nonchilled:42   Min.   :  95   Min.   : 7.70  
    ##  Qn2    : 7   Mississippi:42   chilled   :42   1st Qu.: 175   1st Qu.:17.90  
    ##  Qn3    : 7                                    Median : 350   Median :28.30  
    ##  Qc1    : 7                                    Mean   : 435   Mean   :27.21  
    ##  Qc3    : 7                                    3rd Qu.: 675   3rd Qu.:37.12  
    ##  Qc2    : 7                                    Max.   :1000   Max.   :45.50  
    ##  (Other):42

<br>

#### Visualiserungen

``` r
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
```

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

<br>

``` r
# Einfluss von Behandlung und Pflanzentyp

ggplot(CO2, aes(x = Treatment, y = uptake, fill = Type)) +
geom_boxplot() +
labs(
title = 'CO2-Aufnahme nach Behandlung und Pflanzentyp',
x = 'Behandlung',
y = 'CO2-Aufnahme'
) +
theme_minimal()
```

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

<br>

``` r
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
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](figures/umweltdatenanalyse-airquality-und-co2_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

<br>

### Insights `CO2`

Pflanzentyp: Quebec-Pflanzen zeigen im Durchschnitt eine etwas höhere
CO₂-Aufnahme als Mississippi-Pflanzen.

Behandlung: „Nonchilled“-Bedingungen (nicht gekühlt) fördern deutlich
höhere CO₂-Aufnahme.

Konzentrationseffekt: Die CO₂-Aufnahme steigt mit zunehmender
CO₂-Konzentration an, flacht jedoch ab – klassischer Sättigungseffekt in
der Photosynthese.

Interaktionseffekt: Der Einfluss von CO₂-Konzentration ist abhängig vom
Pflanzentyp – deutet auf unterschiedliche physiologische Anpassungen
hin.

<br>

## Gesamtfazit:

Beide Datensätze zeigen typische Muster umweltbiologischer
Zusammenhänge:  
In der Luftqualitätsanalyse (airquality) wirken Temperatur und
Windbedingungen stark auf die Ozonwerte.  
In der Pflanzenphysiologie (CO2) bestimmen Umweltfaktoren und
biologische Unterschiede maßgeblich die CO₂-Aufnahme.
