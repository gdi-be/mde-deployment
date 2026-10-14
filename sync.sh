#!/bin/bash
set -euo pipefail

# Mirrors backend data into the mde-client folders to avoid permission problems.
# Must be run from the repo base dir (where the docker-compose files live).

if [[ ! -f "./mde-backend/variables.json" ]]; then
  echo "Error: ./mde-backend/variables.json not found." >&2
  exit 1
fi

if [[ ! -d "./codelists" ]]; then
  echo "Error: ./codelists directory not found." >&2
  exit 1
fi

mkdir -p mde-client
cp -fp mde-backend/variables.json mde-client/variables.json
diff -q mde-backend/variables.json mde-client/variables.json
echo "Copied mde-backend/variables.json -> mde-client/variables.json"

rm -rf mde-client-codelists
mkdir -p mde-client-codelists
cp -a codelists/. mde-client-codelists/
diff -rq codelists mde-client-codelists
echo "Copied codelists/. -> mde-client-codelists/"
