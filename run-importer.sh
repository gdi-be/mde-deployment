#!/bin/bash

# Default-Values for optional parameters
CODELISTS_DIR="./codelists/"
VARIABLE_FILE="./mde-backend/variables.json"

# Default-Values for required parameters
DATA_FOLDER=""
IMPORTER_FILE=""

show_help() {
  echo "Benutzung:"
  echo "  $0 [OPTIONEN]"
  echo
  echo "Optionen:"
  echo "  --codelists=PFAD      Pfad zum Codelists-Verzeichnis (optional, Default: ./codelists/)"
  echo "  --variables=DATEI     Pfad zur JSON-Datei mit Variablen (optional, Default: ./mde-backend/variables.json)"
  echo "  --data=PFAD           Pfad zum Daten-Export-Ordner (erforderlich)"
  echo "  --importer=JAR        Pfad zur Importer-JAR-Datei (erforderlich)"
  echo "  --keycloak-secret     Secret des Keycloak-Clients (erforderlich)"
  echo "  --keycloak-host       Hostname des Keycloak-Servers (erforderlich)"
  echo "  --help                Zeigt diese Hilfe an"
  echo
  echo "Beispiel:"
  echo "  $0 --importer=../mde-backend/mde-importer/target/mde-importer-0.0.1-SNAPSHOT.jar --data=~/geodata/berlin/export/"
  echo "  $0 --codelists=./custom --variables=./vars.json --data=... --importer=..."
}

# Parse parmaeters
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --codelists=*) CODELISTS_DIR="${1#*=}";;
    --variables=*) VARIABLE_FILE="${1#*=}";;
    --data=*) DATA_FOLDER="${1#*=}";;
    --importer=*) IMPORTER_FILE="${1#*=}";;
    --keycloak-secret=*) KEYCLOAK_CLIENT_SECRET="${1#*=}";;
    --keycloak-host=*) KEYCLOAK_HOST="${1#*=}";;
    --help) show_help; exit 0;;
    *) echo "Unbekannter Parameter: $1" >&2; echo; show_help; exit 1;;
  esac
  shift
done

# Check if required parameters are set
if [[ -z "$DATA_FOLDER" || -z "$IMPORTER_FILE" ]]; then
  echo "Fehler: --data-folder und --importer sind erforderlich." >&2
  echo
  show_help
  exit 1
fi

# Execute the importer
CODELISTS_DIR="$CODELISTS_DIR" \
VARIABLE_FILE="$VARIABLE_FILE" \
KEYCLOAK_CLIENT_SECRET="$KEYCLOAK_CLIENT_SECRET" \
KEYCLOAK_CLIENT_ID=mde \
KEYCLOAK_REALM=metadata-editor \
KEYCLOAK_HOST=$KEYCLOAK_HOST \
"$JAVA_HOME/bin/java" \
  --add-modules jdk.incubator.vector \
  -Dhibernate.search.backend.directory.root=/tmp/lucene \
  -jar "$IMPORTER_FILE" \
  -d "$DATA_FOLDER"
