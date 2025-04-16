## Codelists

Die Codelisten sind in Form von YAML-Dateien im Verzeichnis `codelists` abgelegt. Die Dateien werden zur Laufzeit interpretiert und können somit angepasst werden, ohne Komponenten neu starten zu müssen.

Folgende Codelisten sind vorhanden.

- `cry.yaml` - Liste der Koordinatensysteme
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `extents.yaml` - Liste der Ausdehnungen
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `field_labels.yaml` - Konfiguration der Feldbezeichnungen
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text, der als Titel des Eingabefeldes angezeigt wird
    - `explanation` - Text, der als Erklärung des Eingabefeldes angezeigt wird (aktuell Placeholder)
    - `hint` - Text, der beim Fokus unterhalb des Eingabefeldes angezeigt wird
    - `subFields` - Kann eine Liste von Subfeldern enthalten, die in der Form `key.subfield` angegeben werden. Diese Subfelder werden dann als Array interpretiert und können auch wieder Subfelder enthalten.
- `hvd_categories.yaml` - Liste der HVD-Kategorien
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `inspire_themes.yaml` - Liste der INSPIRE-Themen
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `iso_themes.yaml` - Liste der ISO-Themen
  - Felder
    - `inspireID`: ID des INSPIRE-Themas (wird für das automatische übernehmen verwendet)
    - `isoID`: ID des ISO-Themas (wird im code verwendet)
    - `isoName`: Name des ISO-Themas (wird zur Anzeige verwendet)
- `privacy.yaml` - Liste der Datenschutzkategorien
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `terms_of_use.yaml` - Liste der Nutzungsbedingungen
  - Felder
    - `id` - Wird in der Datenbank gespeichert
    - `shortname` - Text (wird zur Anzeige verwendet)
    - `active` - Gibt an, ob die Nutzungsbedingungen auswählbar sind (true / false)
    - `matchStrings` - Liste von Strings die vom Importer verwendet wird, um eine Zugehörigkeit zu prüfen
    - `openData` - Gibt an, ob die Nutzungsbedingung OpenData Richtlinien entspricht (true / false)
    - `json` - JSON Representation der Nutzungsbedingungen
      - `id` - ID der Nutzungsbedingungen
      - `name` - Name der Nutzungsbedingungen
      - `url` - URL der Nutzungsbedingungen
      - `source` - Quelle der Nutzungsbedingungen

Die Hilfe wird im Ordner `help` abgelegt. Weitere Informationen finden sie in der Datei `README.md` im Ordner `help`.

## Feld Zugehörigkeit (unvollständig)

Die folgende Tabelle zeigt die Zuordnung der Felder zu den Metadaten-Elementen. Die Spalte "Key" gibt den Schlüssel an (wird im code verwendet). Über diesen Key wird sowohl der
Hilfetext in der entsprechenden Ordner Struktur als auch die Beschriftungen des Eingabefeldes im Metadateneditor zugeordnet.

| ID     | Bezeichnung                   | Key                                         |
|--------|-------------------------------|---------------------------------------------|
| 1      | Titel                         | isoMetadata.title                           |
| 2      | Kurzbeschreibung              | isoMetadata.description                     |
| 3      | Kommentar                     |                                             |
| 4      | Datenschutz                   | clientMetadata.privacy                      |
| 5      | INSPIRE-Typ                   | isoMetadata.metadataProfile                 |
| 6      | HVD                           | clientMetadata.highValueDataset             |
| 7      | Annex                         | isoMetadata.inspireTheme                    |
| 8      | HVD-Kategorie                 |                                             |
| 9      | Erstellung                    | isoMetadata.created                         |
| 10     | Veröffentlichung              | isoMetadata.published                       |
| 11     | Aktualisierung                | isoMetadata.modified                        |
| 12     | Gültigkeit                    | isoMetadata.validFrom / isoMetadata.validTo |
| 13     | Kategorie                     | isoMetadata.topicCategory                   |
| 14     | Pflege                        | isoMetadata.maintenanceFrequency            |
| 15     | Schlagwörter                  | isoMetadata.keywords                        |
| 16     | CRS-IN                        | technicalMetadata.deliveredCrs              |
| 17     | CRS-OUT                       | isoMetadata.crs                             |
| 18     | Ausdehnung                    | isoMetadata.extent                          |
| 19     | Kontaktangaben                | isoMetadata.pointsOfContact                 |
| 20     | _ Name                        |                                             |
| 21     | _ Organisation                |                                             |
| 22     | _ Telefonnummer               |                                             |
| 23     | _ E-Mailadresse               |                                             |
| 24     | NB                            | isoMetadata.termsOfUseId                    |
| 25     | Auswahl-NB                    |                                             |
| 26     | Quelle-NB                     |                                             |
| 27     | Maßstab                       | isoMetadata.scale                           |
| 28     | Auflösung                     | isoMetadata.resolutions                     |
| 29     | Vorschau                      | isoMetadata.preview                         |
| 30     | Inhaltliche Beschreibung      | isoMetadata.contentDescription              |
| 31     | Technische Beschreibung       | isoMetadata.technicalDescription            |
| 32     | Datengrundlage                | isoMetadata.lineage                         |
| 33     | _ Titel                       |                                             |
| 34     | _ Datum                       |                                             |
| 35     | _ Identifier                  |                                             |
| 36     | Verwandte Themen (MTK)        |                                             |
| 37     | Überprüfung                   | isoMetadata.valid                           |
| 38     | Schema-Version                | isoMetadata.inspireAnnexVersion             |
| 39     | Informationen                 | isoMetadata.contentDescriptions             |
| 40     | Anzahl                        |                                             |
| 41     | _ WMTS                        |                                             |
| 42     | _ DienstID WMTS               |                                             |
| 43     | _ Titel des Dienstes          | isoMetadata.services.title                  |
| 44     | _ Kurzbeschreibung des Dienst | isoMetadata.services.shortDescription       |
| 45     | _ DienstID (Arbeitsbereich)   |                                             |
| 46     | _ Vorschau                    |                                             |
| 47     | _ Gesamtlegende               |                                             |
| 48     | _ Anzahl Kartenebenen         |                                             |
| 49     | _ Titel                       |                                             |
| 50     | _ Name                        |                                             |
| 51     | _ Style-Name                  |                                             |
| 52     | _ Style-Titel                 |                                             |
| 53     | _ Legende                     |                                             |
| 54     | _ Kurzbeschreibung            |                                             |
| 55     | _ primäre_DQ                  |                                             |
| 56     | Anzahl                        |                                             |
| 57     | _ Art                         |                                             |
| 58     | _ Titel                       |                                             |
| 59     | _ Kurzbeschreibung            |                                             |
| 60     | _ Layeranzahl                 |                                             |
| 61     | _ Layertitel/Datasettitel     |                                             |
| 62     | _ Layername                   |                                             |
| 63     | _ Anzahl Attribute/Downloads  |                                             |
| 64     | _ Attribut-Name               |                                             |
| 65     | _ Attributalias               |                                             |
| 66     | _ Attribut-Datentyp           |                                             |
| 67     | _ Attribut-Filter-Typ         |                                             |
| 68     | _ Download-Titel              |                                             |
| 69     | _ Download-Dateityp           |                                             |
| 70     | _ Download-URL                |                                             |
| 71     | _ Download-Dateigröße         |                                             |
