In diesem Bereich werden die Hilfen für die einzelnen Metadatenfelder bereitgestellt.
Die Hilfen sind in Markdown-Dateien organisiert und in einem Verzeichnisbaum abgelegt.

Um die Hilfen den entsprechenden Eingabefeldern im Metadateneditor zuzuordnen, muss die Datei `config.yaml` angepasst werden. Darin wird festgelegt, welcher Hilfetext für welches Eingabefeld verwendet wird.
Der Pfad zur Hilfedatei ist dabei immer relativ zum Verzeichnis `help`.
Die Datei ist so strukturiert, dass sie dem Datenmodell entspricht. Die Schlüssel dürfen entsprechend nicht verändert werden.

Ein Eingabe-Feld kann zum Beispiel wie folgt konfiguriert werden:

```yaml
isoMetadata:
  title:
    MdeAdministrator: "01_basisangaben/title.admin.md"
    MdeQualityAssurance: "01_basisangaben/title.qs.md"
    MdeDataOwner: "01_basisangaben/title.dhs.md"
    # MdeEditor: "01_basisangaben/title.redakteur.md"
    default: "01_basisangaben/title.md"
  services:
    legendImage:
      default: "05_dienste/serviceLegendImage.md"
```

Standardmäßig wird die Hilfedatei mit dem Schlüssel `default` verwendet. Wenn ein Benutzer mit einer bestimmten Rolle angemeldet ist, wird die entsprechende Hilfedatei verwendet. Die Rollenzuordnung stellt sich wie folgt dar:

- MdeAdministrator --> Administrator
- MdeQualityAssurance --> Qualitätsmanagement
- MdeDataOwner --> Datenhaltende Stelle
- MdeEditor --> Redakteur

Sollte für ein Eingabefeld keine Hilfedatei konfiguriert sein, so wird keine Hilfe angezeigt.

Die Struktur des Verzeichnisbaums ist wie folgt:

```plaintext
help/
├── README.md
├── config.yaml
├── isoMetadata
│   ├── title.md
│   ├── title.redakteure.md
│   ├── description.md
│   ├── ...
├── clientMetadata
│   ├── highValueDataset.md
│   ├── ...
├── technicalMetadata
|   ├── deliveredCrs.md
|   ├── ...
```
