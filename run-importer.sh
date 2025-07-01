#!/bin/bash

KEYCLOAK_REALM="metadata-editor"
KEYCLOAK_CLIENT_ID="mde"

# Default-Values for optional parameters
CODELISTS_DIR="./codelists/"
VARIABLE_FILE="./mde-backend/variables.json"
IMPORTER_FILE=""
DB_URL="jdbc:postgresql://localhost:5432/mde"
DB_USERNAME="postgres"
DB_PASSWORD="postgres"

# Default-Values for required parameters
DATA_FOLDER=""
KEYCLOAK_CLIENT_SECRET=""
KEYCLOAK_HOST=""

show_help() {
  echo "Benutzung:"
  echo "  $0 [OPTIONEN]"
  echo
  echo "Optionen:"
  echo "  --codelists=PFAD      Pfad zum Codelists-Verzeichnis (optional, Default: ./codelists/)"
  echo "  --variables=DATEI     Pfad zur JSON-Datei mit Variablen (optional, Default: ./mde-backend/variables.json)"
  echo "  --importer=JAR        Pfad zur Importer-JAR-Datei (optional, Default: neueste Version wird automatisch heruntergeladen)"
  echo "  --data=PFAD           Pfad zum Daten-Export-Ordner (erforderlich)"
  echo "  --keycloak-secret     Secret des Keycloak-Clients (erforderlich, wird abgefragt, wenn nicht angegeben)"
  echo "  --keycloak-host       Hostname des Keycloak-Servers (erforderlich)"
  echo "  --db-url=URL          JDBC-URL für die Datenbank (optional, Default: jdbc:postgresql://localhost:5432/mde)"
  echo "  --db-username=USERNAME   Benutzername für die Datenbank (optional, Default: postgres)"
  echo "  --db-password=PASSWORD   Passwort für die Datenbank (optional, Default: postgres)"
  echo "  --help                Zeigt diese Hilfe an"
  echo
  echo "Beispiel:"
  echo "  $0 --importer=../mde-backend/mde-importer/target/mde-importer-0.0.1-SNAPSHOT.jar --data=~/geodata/berlin/export/ --keycloak-host=https://localhost/auth"
  echo "  $0 --codelists=./custom --variables=./vars.json --data=... --importer=... --keycloak-host=..."
  echo "  $0 --data=~/geodata/berlin/export/ --keycloak-host=https://localhost/auth"
}

# Parse parameters
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --codelists=*) CODELISTS_DIR="${1#*=}";;
    --variables=*) VARIABLE_FILE="${1#*=}";;
    --importer=*) IMPORTER_FILE="${1#*=}";;
    --data=*) DATA_FOLDER="${1#*=}";;
    --keycloak-secret=*) KEYCLOAK_CLIENT_SECRET="${1#*=}";;
    --keycloak-host=*) KEYCLOAK_HOST="${1#*=}";;
    --db-url=*) DB_URL="${1#*=}";;
    --db-username=*) DB_USERNAME="${1#*=}";;
    --db-password=*) DB_PASSWORD="${1#*=}";;
    --help) show_help; exit 0;;
    *) echo "Unbekannter Parameter: $1" >&2; echo; show_help; exit 1;;
  esac
  shift
done

# Prompt for KEYCLOAK_CLIENT_SECRET if not provided
if [[ -z "$KEYCLOAK_CLIENT_SECRET" ]]; then
  echo -n "Bitte geben Sie das Secret für den Keycloak Client "$KEYCLOAK_CLIENT_ID" ein: "
  read -s KEYCLOAK_CLIENT_SECRET
  echo
fi

# Check if required parameters are set
if [[ -z "$DATA_FOLDER" || -z "$KEYCLOAK_CLIENT_SECRET" || -z "$KEYCLOAK_HOST" ]]; then
  echo "Fehler: --data-folder, --keycloak-secret und --keycloak-host sind erforderlich." >&2
  echo
  show_help
  exit 1
fi

# Download the (latest) importer if not provided
if [[ -z "$IMPORTER_FILE" ]]; then
  # Fetch the latest release version from GitHub
  LATEST_RELEASE=$(curl -s https://api.github.com/repos/gdi-be/mde-backend/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  if [[ -z "$LATEST_RELEASE" ]]; then
    echo "Fehler: Konnte die neueste Release-Version nicht ermitteln." >&2
    exit 1
  fi
  DOWNLOAD_URL="https://github.com/gdi-be/mde-backend/releases/download/v$LATEST_RELEASE/mde-importer-$LATEST_RELEASE-spring-boot.jar"
  echo "Downloading importer file from $DOWNLOAD_URL…"
  wget -O /tmp/importer.jar "$DOWNLOAD_URL"
  if [[ $? -ne 0 ]]; then
    echo "Fehler: Der Importer konnte nicht heruntergeladen werden." >&2
    exit 1
  fi
  IMPORTER_FILE="/tmp/importer.jar"
fi

# Execute the importer
CODELISTS_DIR="$CODELISTS_DIR" \
VARIABLE_FILE="$VARIABLE_FILE" \
KEYCLOAK_CLIENT_SECRET="$KEYCLOAK_CLIENT_SECRET" \
KEYCLOAK_CLIENT_ID="$KEYCLOAK_CLIENT_ID" \
KEYCLOAK_REALM="$KEYCLOAK_REALM" \
KEYCLOAK_HOST="$KEYCLOAK_HOST" \
DB_URL="$DB_URL" \
"$JAVA_HOME/bin/java" \
  --add-modules jdk.incubator.vector \
  -Dhibernate.search.backend.directory.root=/tmp/lucene \
  -Dmde.assign-users-on-import=true \
  -Dspring.datasource.url="$DB_URL" \
  -Dspring.datasource.username="$DB_USERNAME" \
  -Dspring.datasource.password="$DB_PASSWORD" \
  -jar "$IMPORTER_FILE" \
  -d "$DATA_FOLDER"
