## Codelists

Die Codelisten sind in Form von YAML-Dateien im Verzeichnis `codelists` abgelegt. Die Dateien werden zur Laufzeit interpretiert und können somit angepasst werden, ohne Komponenten neu starten zu müssen.

Folgende Codelisten sind vorhanden.

- `contact.yaml` - Werte für den Standard Kontakt für ISO Export
  - `name`: TODO
  - `organisation`: TODO
  - `contact`: TODO
  - `phone`: TODO
  - `email`: TODO
  - `code`: TODO
  - `url`: TODO
  - `roleCode`: TODO
- `cry.yaml` - Liste der Koordinatensysteme
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `extents.yaml` - Liste der Ausdehnungen
  - Felder
    - `value` - Werte die für diese Ausdehnung verwendet werden
      - `minx`
      - `miny`
      - `maxx`
      - `maxy`
    - `title` - Text (wird zur Anzeige verwendet)
- `field_labels.yaml` - Konfiguration der Feldbezeichnungen
  - Felder
    - `profileId` - Eindeutige ID des Feldes
    - `label` - Text, der als Titel des Eingabefeldes angezeigt wird
    - `explanation` - Text, der als Erklärung des Eingabefeldes angezeigt wird
    - `hint` - Text, der beim Fokus unterhalb des Eingabefeldes angezeigt wird
    - `key` - Optional: Technischer Schlüssel (nur für spezielle Felder wie validFrom/validTo, extent, contentDescriptions, legendImage, secondaryDatasource, downloads und attributes)
- `hvd_categories.yaml` - Liste der HVD-Kategorien
  - Felder
    - `key` - Schlüssel (wird im code verwendet)
    - `label` - Text (wird zur Anzeige verwendet)
- `metadatavariables.yaml` - Enthält verschiedene Variablen für den ISO Export
  - `profileName`: TODO
  - `profileVersion`: TODO
  - `registry`: TODO
  - `regionalKey`: TODO
  - `serviceUrl`: TODO
  - `lineage`: TODO
  - `standardFormat`: TODO
  - `standardVersion`: TODO
  - `portalUrl`: TODO
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
- `terms_of_use.yaml` | `terms_of_use_on_privacy.yaml` - Liste der Nutzungsbedingungen
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

## Feld Zugehörigkeit

Die folgende Tabelle zeigt die Zuordnung der Felder zu den Metadaten-Elementen. Die Spalte "Key" gibt den Schlüssel an.
Über diesen Key wird der Hilfetext in der `help/config.yaml` zugeordnet.
Über die ID werden sowohl die codeseitige fixe FieldConfig (Validierung, Kopierfunktion, ...), als auch die Labels aus
der `field_labels.yaml` zugeordnet.

Einige IDs sind mit `*` markiert. Diese liegen im Metadatenprofil aktuell doppelt vor.

| ID  | Bezeichnung                            | Key                                                  |
| --- | -------------------------------------- | ---------------------------------------------------- |
| 1   | Titel                                  | isoMetadata.title                                    |
| 2   | Kurzbeschreibung                       | isoMetadata.description                              |
| 3   | Kommentare                             | clientMetadata.comments                              |
| 4   | Datenschutz                            | clientMetadata.privacy                               |
| 5   | INSPIRE-Typ                            | isoMetadata.metadataProfile                          |
| 6   | HVD                                    | isoMetadata.highValueDataset                         |
| 7   | Annex                                  | isoMetadata.inspireTheme                             |
| 8   | HVD-Kategorie                          | isoMetadata.highValueDataCategory                    |
| 9   | Erstellung                             | isoMetadata.created                                  |
| 10  | Veröffentlichung                       | isoMetadata.published                                |
| 11  | Aktualisierung                         | isoMetadata.modified                                 |
| 12  | gültig ab                              | isoMetadata.validFrom                                |
| 24  | gültig bis                             | isoMetadata.validTo                                  |
| 13  | Kategorie                              | isoMetadata.topicCategory                            |
| 14  | Pflege                                 | isoMetadata.maintenanceFrequency                     |
| 15  | Schlagwörter                           | isoMetadata.keywords                                 |
| 16  | CRS-IN                                 | technicalMetadata.deliveredCrs                       |
| 17  | CRS-OUT                                | isoMetadata.crs                                      |
| 18  | Ausdehnung                             | isoMetadata.extent                                   |
| 71  | \_ Minimaler X-Wert                    | isoMetadata.extent.minx                              |
| 72  | \_ Maximaler X-Wert                    | isoMetadata.extent.maxx                              |
| 73  | \_ Minimaler Y-Wert                    | isoMetadata.extent.miny                              |
| 74  | \_ Maximaler Y-Wert                    | isoMetadata.extent.maxy                              |
| 19  | Kontaktangaben                         | isoMetadata.pointsOfContact                          |
| 20  | \_ Name                                | isoMetadata.pointsOfContact.name                     |
| 21  | \_ Organisation                        | isoMetadata.pointsOfContact.organisation             |
| 22  | \_ E-Mailadresse                       | isoMetadata.pointsOfContact.email                    |
| 23  | \_ Telefonnummer                       | isoMetadata.pointsOfContact.phone                    |
| 25  | Auswahl-NB                             | isoMetadata.termsOfUseId                             |
| 26  | Quelle-NB                              | isoMetadata.termsOfUseSource                         |
| 27  | Maßstab                                | isoMetadata.scale                                    |
| 28  | Auflösung                              | isoMetadata.resolutions                              |
| 39  | Darstellungsart                        | isoMetadata.spatialRepresentationType                |
| 29  | Vorschau                               | isoMetadata.preview                                  |
| 30  | Inhaltliche Beschreibung               | isoMetadata.contentDescription                       |
| 31  | Technische Beschreibung                | isoMetadata.technicalDescription                     |
| 32  | Datengrundlage                         | isoMetadata.lineage                                  |
| 33  | \_ Titel                               | isoMetadata.lineage.title                            |
| 34  | \_ Datum                               | isoMetadata.lineage.date                             |
| 35  | \_ Identifier                          | isoMetadata.lineage.identifier                       |
| 36  | Verwandte Themen (MTK)                 | clientMetadata.relatedTopics                         |
| 37  | Überprüfung                            | isoMetadata.valid                                    |
| 38  | Schema-Version                         | isoMetadata.inspireAnnexVersion                      |
| 70  | Schema-Name                            | isoMetadata.inspireAnnexName                         |
| 41  | Weitere Informationen                  | isoMetadata.contentDescriptions                      |
| 42  | \_ Titel                               | isoMetadata.contentDescriptions.title                |
| 43  | \_ Code                                | isoMetadata.contentDescriptions.code                 |
| 44  | \_ URL                                 | isoMetadata.contentDescriptions.url                  |
| 40  | Dienste                                | isoMetadata.services                                 |
| 45  | \_ Identifikator des Kartendienstes    | isoMetadata.services.workspace                       |
| 46  | \_ Vorschau des Kartendienstes         | isoMetadata.services.preview                         |
| 47  | \_ Gesamtlegende                       | isoMetadata.services.legendImage                     |
| 75  | \_ Gesamtlegende URL                   | isoMetadata.services.legendImage.url                 |
| 76  | \_ Gesamtlegende Format                | isoMetadata.services.legendImage.format              |
| 77  | \_ Gesamtlegende Width                 | isoMetadata.services.legendImage.width               |
| 78  | \_ Gesamtlegende Height                | isoMetadata.services.legendImage.height              |
| 48  | \_ Kartenebenen                        | clientMetadata.layers                                |
| 49  | \_ Titel der Kartenebene               | clientMetadata.layers.title                          |
| 50  | \_ Name der Kartenebene                | clientMetadata.layers.name                           |
| 51  | \_ Name des Styles                     | clientMetadata.layers.styleName                      |
| 52  | \_ Titel des Styles                    | clientMetadata.layers.styleTitle                     |
| 53  | \_ Legende                             | clientMetadata.layers.legendImage                    |
| 54  | \_ Kurzbeschreibung                    | clientMetadata.layers.shortDescription               |
| 55  | \_ Ablageort der Daten                 | clientMetadata.layers.datasource                     |
| 56  | \_ sekundäre Datenhaltung              | clientMetadata.layers.secondaryDatasource            |
| 58  | \_ Typ                                 | isoMetadata.services.serviceType                     |
| 59  | \_ Titel                               | isoMetadata.services.title                           |
| 60  | \_ Kurzbeschreibung                    | isoMetadata.services.shortDescription                |
| 61  | \_ Featuretypes                        | isoMetadata.services.featureTypes                    |
| 62  | \_\_ Titel des FeatureTypes            | isoMetadata.services.featureTypes.title              |
| 63  | \_\_ Name des FeatureTypes             | isoMetadata.services.featureTypes.name               |
| 69  | \_\_ Kurzbeschreibung des FeatureTypes | isoMetadata.services.featureTypes.shortDescription   |
| 64  | \_\_ Attribute                         | isoMetadata.services.featureTypes.columns            |
| 65  | \_\_\_ Attribut-Name                   | isoMetadata.services.featureTypes.columns.name       |
| 66  | \_\_\_ Attribut-Alias                  | isoMetadata.services.featureTypes.columns.alias      |
| 67  | \_\_\_ Attribut-Datentyp               | isoMetadata.services.featureTypes.columns.type       |
| 68  | \_\_\_ Attribut-Filter-Typ             | isoMetadata.services.featureTypes.columns.filterType |
