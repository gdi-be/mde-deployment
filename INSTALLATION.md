# Installation

## Vorbereitung

* `podman`/`podman-compose` muss installiert sein
* das mde-deployment-Repository sollte auf dem Zielserver geklont sein
* die `.env.example` sollte nach `.env` kopiert werden und auf die entsprechende Umgebung angepasst werden, ebenso die `.client-env.example` als `.client-env`
* in `mde-backend` sollte das gleiche mit der `variables-example.json` als `variables.json` passieren

## Durchführung

* erstmals `podman-compose -f docker-compose-test.yml up -d` ausführen
* falls einige container noch nicht gestartet sind (z.B. aufgrund initial fehlender Datenbanken in der postgres) kann das System nochmals neu gestartet werden, z.B. mittels `podman-compose -f docker-compose-test.yml down` und dann nochmal `podman-compose -f docker-compose-test.yml up -d`
* die test-compose-Datei beinhaltet ein GNOS (plus elasticsearch), die prod-Datei enthält dies nicht und erwartet ein vorhandenes (externes)

## Nachbereitung

### Konfiguration Keycloak

Keycloak muss noch über die Oberfläche konfiguriert werden. Es muss zunächst ein Realm angelegt werden, z.B. namens `metadata-editor`. In diesem Realm müssen die Rollen `MdeAdministrator`, `MdeDataOwner`, `MdeEditor` und `MdeQualityAssurance` angelegt werden.

Dann muss in diesem Realm ein Client angelegt werden, zum Beispiel namens `mde`. Dieser muss mit einer gültigen Redirect URI konfiguriert werden, also z.B. `https://metadata.de/*`. Client authentication muss auf on stehen. Ausserdem müssen noch Häkchen bei Direct access grants und Service accounts roles gesetzt werden. Unter Credentials befindet sich das Client-Secret, dass in die env-Dateien eingetragen werden muss.

Falls unter Service accounts roles die realm-management/realm-admin-Rolle fehlt, muss diese noch hinzugefügt werden.

Zum Anbinden eines ActiveDirectory siehe README.

Nutzer können nun die angelegten Rollen entsprechend zugewiesen werden.

## Fehlerbehebung

* falls Berechtigungsprobleme in Verbindung mit den volumes auftreten (das kann je nach podman-Version unterschiedlich sein) kann es helfen, diese entweder manuell zu setzen oder auch mit den volume-flags herumzuspielen (z.B. kann ein zusätzliches `,U` helfen)
* falls self-signed Zertifikate in einer der Komponenten verwendet wird, muss das Zertifikat in die cacerts keystores der betroffenen container importiert werden, z.B. via `keytool -import -file /tmp/localhost.crt -alias DEV -keystore /usr/lib/jvm/temurin-21-jdk-amd64/lib/security/cacerts -noprompt -storepass changeit`
  * falls kein gültiges Zertifikat für das System selbst vorhanden ist, muss es im `mde-backend`-Container importiert werden
  * falls kein gültiges Zertifikat für das ActiveDirectory vorhanden ist, muss es im `mde-keycloak`-Container importiert werden
  * falls kein gültiges Zertifikat für das GNOS vorhanden ist, muss es im `mde-backend`-Container importiert werden

## Updates

Updates können einfach via `git pull` und anschliessendem Neustart eingespielt werden.

## Importer

Die Verwendung des Importers ist in der README des Backends beschrieben.
