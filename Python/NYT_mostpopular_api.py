"""
Data provided by The New York Times
https://developer.nytimes.com/

Dieses Script ruft wöchentlich Daten aus der NYTimes Most Popular API (7-Tage Top Articles)
und Most Shared API (facebook, email) ab und hängt sie an historische CSVs an.
Duplikate werden anhand der Artikel-ID entfernt.
Power BI kann dann einfach die historischen CSVs einlesen und visualisieren.
"""

import os
import requests
import pandas as pd
from datetime import datetime

# --- API-Key aus Environment Variable ---
API_KEY = os.getenv("NYT_API_KEY")
if not API_KEY:
    raise ValueError("API-Key nicht gefunden! Bitte NYT_API_KEY als Umgebungsvariable setzen.")

# --- Unterordner für CSVs ---
working_dir = os.getcwd()
output_folder = os.path.join(working_dir, "nyt_csvs")
os.makedirs(output_folder, exist_ok=True)

# --- Historische CSV-Dateien ---
popular_hist_file = os.path.join(output_folder, "nyt_mostpopular_historic.csv")
shared_hist_file = os.path.join(output_folder, "nyt_mostshared_historic.csv")

# --- Funktion: Most Popular abrufen ---
def fetch_mostpopular(api_key, period=7):
    url = f"https://api.nytimes.com/svc/mostpopular/v2/viewed/{period}.json?api-key={api_key}"
    data = requests.get(url).json()
    articles = []
    for item in data['results']:
        articles.append({
            "Titel": item.get('title'),
            "URL": item.get('url'),
            "Ressort": item.get('section'),
            "Unterrubrik": item.get('subsection'),
            "Veröffentlicht": item.get('published_date'),
            "Aktualisiert": item.get('updated'),
            "Autor": item.get('byline'),
            "Zusammenfassung": item.get('abstract'),
            "Keywords": item.get('adx_keywords'),
            "ID": item.get('id'),
            "Artikeltyp": item.get('type'),
            "Deskriptoren": item.get('des_facet'),
            "Organisationen": item.get('org_facet'),
            "Personen": item.get('per_facet'),
            "Orte": item.get('geo_facet'),
        })
    return pd.DataFrame(articles)

# --- Funktion: Most Shared abrufen ---
def fetch_mostshared(api_key, period=7, share_types=["facebook","email"]):
    articles = []
    for st in share_types:
        url = f"https://api.nytimes.com/svc/mostpopular/v2/shared/{period}/{st}.json?api-key={api_key}"
        response = requests.get(url)
        print(f"Status {response.status_code} für {st}")
        print("Antwort-Text (erste 200 Zeichen):", response.text[:200])

        try:
            data = response.json()
        except Exception as e:
            print(f"Fehler beim JSON-Parsing für {st}: {e}")
            continue

        for item in data['results']:
            articles.append({
                "Channel": st,
                "Titel": item.get('title'),
                "URL": item.get('url'),
                "Ressort": item.get('section'),
                "Unterrubrik": item.get('subsection'),
                "Veröffentlicht": item.get('published_date'),
                "Aktualisiert": item.get('updated'),
                "Autor": item.get('byline'),
                "Zusammenfassung": item.get('abstract'),
                "Keywords": item.get('adx_keywords'),
                "ID": item.get('id'),
                "Artikeltyp": item.get('type'),
                "Deskriptoren": item.get('des_facet'),
                "Organisationen": item.get('org_facet'),
                "Personen": item.get('per_facet'),
                "Orte": item.get('geo_facet'),
            })
    return pd.DataFrame(articles)

# --- Neue Daten abrufen ---
df_popular_new = fetch_mostpopular(API_KEY, period=7)
df_shared_new = fetch_mostshared(API_KEY, period=7)

# --- Channel formatieren: erster Buchstabe groß ---
df_shared_new['Channel'] = df_shared_new['Channel'].str.capitalize()

# --- Historische Daten laden, Duplikate entfernen und speichern ---
def append_to_historic(df_new, hist_file):
    if os.path.exists(hist_file):
        df_hist = pd.read_csv(hist_file, sep=";", encoding="utf-8-sig")
        df_combined = pd.concat([df_hist, df_new], ignore_index=True)
        # Duplikate anhand der ID entfernen
        df_combined.drop_duplicates(subset="ID", inplace=True)
    else:
        df_combined = df_new
    df_combined.to_csv(hist_file, index=False, sep=";", encoding="utf-8-sig")
    return df_combined

df_popular_hist = append_to_historic(df_popular_new, popular_hist_file)
df_shared_hist = append_to_historic(df_shared_new, shared_hist_file)

# --- Feedback ---
today = datetime.today().strftime("%Y-%m-%d")
print(f"Most Popular CSV aktualisiert: {popular_hist_file} ({len(df_popular_hist)} Zeilen insgesamt)")
print(f"Most Shared CSV aktualisiert: {shared_hist_file} ({len(df_shared_hist)} Zeilen insgesamt)")
