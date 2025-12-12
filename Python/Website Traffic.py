# Bibliotheken laden
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# Trennzeichen prüfen
with open('/Users/janka-katharinaschultze/Downloads/website_wata.csv', 'r') as f:
    for i in range(5):
        print(f.readline())

# Datensatz laden
df = pd.read_csv('/Users/janka-katharinaschultze/Downloads/website_wata.csv')
df.head()

# Überblick Datensatz
print("Datensatz Überblick")
print(df.info())
print("\nStatistische Kennzahlen")
print(df.describe())
print("\nAnzahl eindeutiger Werte")
print(df.nunique())
print("\nFehlende Werte")
print(df.isna().sum())
print("\nDuplikate")
print(df[df.duplicated()].shape[0])
print("\nForm des Datensatzes:", df.shape)

# Überblick über Traffic - KPIs
# Gesamtseitenaufrufe, durchschnittliche Sitzungsdauer, durchschnittliche Bounce Rate
total_pageviews = df['Page Views'].sum()
avg_session_duration = df['Session Duration'].mean()
avg_bounce_rate = df['Bounce Rate'].mean()
avg_time_on_page = df['Time on Page'].mean()
avg_previous_visits = df['Previous Visits'].mean()
avg_conversion_rate = df['Conversion Rate'].mean()

print(f"Gesamtseitenaufrufe: {total_pageviews}")
print(f"Durchschnittliche Sitzungsdauer: {avg_session_duration:.2f} min")
print(f"Durchschnittliche Bounce Rate: {avg_bounce_rate * 100:.0f}%")
print(f"Durchschnittliche Verweildauer: {avg_time_on_page:.2f} min")
print(f"Durchschnittliche Anzahl vorheriger Besuche: {avg_previous_visits:.2f}")
print(f"Durchschnittliche Conversion Rate: {avg_conversion_rate * 100:.2f}%")

# Verteilung Traffic-Quellen
traffic_counts = df['Traffic Source'].value_counts().reset_index(name="Anzahl")
print(traffic_counts)

# Häufigkeitsdiagramm für die Traffic-Quelle
plt.figure(figsize=(8,5))
sns.countplot(x="Traffic Source",data=df, order=df['Traffic Source'].value_counts().index, hue= "Traffic Source")
plt.title("Anzahl der Sessions nach Traffic-Quelle")
plt.xlabel("Traffic-Quelle")
plt.ylabel("Sessions")

# Kreisdiagramm der Traffic-Quellen
df["Traffic Source"].value_counts().plot(
    kind = "pie", autopct = "%.1f%%",
    figsize=(6,6))
plt.ylabel(None)
plt.title("Anteile der Traffic-Quellen")

# Histogramm für die Verteilung der Seitenaufrufe
plt.figure(figsize=(8,5))
sns.histplot(data = df, x = "Page Views", kde = True, bins = 15)
plt.title("Verteilung der Seitenaufrufe pro Session")
plt.ylabel("Anzahl")
plt.xlabel("Seitenaufrufe")

# Boxplot
plt.figure(figsize=(8,5))
sns.boxplot(data= df, x="Traffic Source", y="Time on Page")
plt.title("Beziehung zwischen Verweildauer und Traffic-Quelle")
plt.xlabel("Traffic-Quelle")
plt.ylabel("Verweildauer")

# Neuen Dataframe ohne kategorische Variabel erstellen
df_num = df.drop('Traffic Source', axis=1)

# Übersicht Boxplots aus numerischen Variablen erstellen
fig, axs = plt.subplots(6,1,dpi=95, figsize=(7,17))
i = 0
for col in df_num.columns:
	axs[i].boxplot(df_num[col], vert=False)
	axs[i].set_ylabel(col)
	i+=1

# Überblick über Beziehungen und Verteilungen
sns.pairplot(df, hue="Traffic Source")

# Heatmap für Korrelationen
corr = df_num.drop('Conversion Rate', axis=1).corr() # Conversion Rate entfernen, da sie nahezu konstant ist (kaum Varianz).

plt.figure(dpi=100)
sns.heatmap(corr, annot= True, cmap= "coolwarm", fmt= '.2f')







