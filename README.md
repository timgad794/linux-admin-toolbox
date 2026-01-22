# 🐧 Linux-Admin-Toolbox

Dieses Repository enthält eine Sammlung von Bash-Skripten, die ich im Rahmen meiner Vorbereitung auf die **LPIC-1 Zertifizierung** (101 & 102) und zur Vertiefung meiner **Cybersecurity-Kenntnisse (Hack The Box)** entwickle.

Ziel ist es, theoretisches Wissen über Linux-Systemadministration in praktische Automatisierungslösungen zu übersetzen.

---

## 🛠 Enthaltene Werkzeuge

### 1. System-Check (`system_check.sh`)
Fokus auf Monitoring und Ressourcenmanagement (LPIC Topic 102 & 104).
* **Speicheranalyse:** Prüfung von RAM-Auslastung und Disk-Usage (`df -h`).
* **Log-Checking:** Abfrage von Systemfehlern via `dmesg`.
* **Netzwerk-Status:** Verifizierung aktiver IP-Adressen.
* **Prozess-Monitoring:** Identifikation der Top-CPU-Verbraucher.

### 2. Security-Audit (`security_audit.sh`)
Fokus auf Server-Hardening und Schwachstellenanalyse (LPIC Topic 108 & HTB Prep).
* **Web-Analyse:** Erkennung aktiver Apache/Nginx Instanzen.
* **SUID-Audit:** Suche nach Dateien mit SUID-Bits zur Analyse von Privesc-Vektoren.
* **Netzwerk-Audit:** Übersicht aller offenen Listening-Ports mittels `ss`.
* **Automated Logging:** Alle Audits werden mit Zeitstempel im Ordner `/audit_logs` gespeichert.

---

## 🚀 Installation & Nutzung

1. Repository klonen:
   ```bash
   git clone [https://github.com/timgad794/linux-admin-toolbox.git](https://github.com/timgad794/linux-admin-toolbox.git)
   cd linux-admin-toolbox
