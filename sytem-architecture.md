## Systembeschreibung

Die entwickelte Anwendung ist ein modular aufgebautes System zur Verwaltung von Daten und Diensten. Sie basiert auf einer Container-Infrastruktur, die über _podman_ orchestriert wird. Die Architektur umfasst vier zentrale Komponenten:

---

### 1. **Reverse Proxy und SSL-Terminierung – `mde-nginx`**

Der Dienst **mde-nginx** dient als zentraler Einstiegspunkt für alle externen Anfragen an das System.

- **Aufgaben**:
  - Routing von HTTP- und HTTPS-Anfragen an die internen Dienste.
  - SSL-Terminierung mithilfe eines selbstsignierten Zertifikats.
  - Weiterleitung von Requests an Backend, Client, Keycloak und GNOS (extern).
- **Sicherheit**:
  - HTTPS-Absicherung über selbstsigniertes Zertifikat.
  - Healthcheck zur Überwachung der Erreichbarkeit.
- **Kommunikation**:
  - Externe Ports 80 (HTTP) und 443 (HTTPS) werden bereitgestellt.
  - Abhängigkeit zu den Backend-, Authentifizierungs- und Client-Diensten.

---

### 2. **Benutzerauthentifizierung und -verwaltung – `mde-keycloak`**

Der Dienst **mde-keycloak** stellt ein Identity- und Access-Management-System auf Basis von _Keycloak_ bereit. Keycloak selbst ist an ein externes LDAP-System angebunden und dient zur Steuerung der Authorisierung und Verwaltung von Benutzern.

- **Aufgaben**:
  - Zentrale Benutzer- und Rollenverwaltung.
  - Authentifizierung von Nutzern und Absicherung der Schnittstellen.
  - Verwaltung von Realms, Clients und Zugriffsrichtlinien.
- **Integration**:
  - Nutzung einer PostgreSQL-Datenbank für die Persistenz.
  - Konfiguration für Reverse Proxy-Betrieb mit definiertem Kontextpfad `/auth`.

---

### 3. **Geschäftslogik und Datenverarbeitung – `mde-backend`**

Der Dienst **mde-backend** stellt die eigentliche Business-Logik der Anwendung bereit.

- **Aufgaben**:
  - Verarbeitung von Anfragen der Clients.
  - Zugriff auf externe Dienste (z. B. CSW-Server) zur Datenabfrage.
  - Verwaltung von Code-Listen und variablenbasierten Konfigurationen.
  - Integration der Authentifizierung über Keycloak.
- **Datenhaltung**:
  - Nutzung einer PostgreSQL-Datenbank.
  - Speicherung von Indexdaten im Lucene-Format.
- **Konfiguration**:
  - Anpassbar über eine `variables.json`-Datei und Log4j2-Konfiguration.
  - Zugriff auf Zertifikate für gesicherte Verbindungen.

---

### 4. **Webbasierte Benutzeroberfläche – `mde-client`**

Der Dienst **mde-client** stellt die grafische Benutzeroberfläche (GUI) der Anwendung bereit.

- **Aufgaben**:
  - Darstellung der Inhalte und Funktionen des Backends im Browser.
  - Kommunikation mit dem Backend über definierte APIs.
  - Einbindung der Code-Listen und Konfigurationsvariablen.
- **Technische Umsetzung**:
  - Containerbasiert ausgeliefert.
  - Konfiguration über `.env`-Datei und angebundene Volumes.

---

### Gesamtsystem

Das System arbeitet als integrierte Plattform, bei der **NGINX** als zentrales Gateway dient, **Keycloak** die Authentifizierung übernimmt, das **Backend** die Geschäftslogik ausführt und der **Client** als Benutzeroberfläche fungiert.
Die Kommunikation zwischen den Diensten erfolgt intern über ein Docker-Netzwerk, während externe Zugriffe ausschließlich über den NGINX-Reverse-Proxy möglich sind.
Durch diese Architektur wird eine klare Trennung von Zuständigkeiten, hohe Modularität und Sicherheit erreicht.
