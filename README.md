# 🐧 Linux Admin Toolbox

Dieses Repository enthält eine Sammlung von Bash-Skripten, die ich im Rahmen meiner Vorbereitung auf die **LPIC-1 Zertifizierung** (Prüfungen 101 & 102) entwickle. 

Ziel ist es, theoretisches Wissen über Linux-Systemadministration in praktische Automatisierungslösungen zu übersetzen.

## 🛠 Features des System-Check-Skripts
Mein aktuelles Hauptskript `about-pull-requests_check.sh` (Arbeitstitel) konzentriert sich auf das Monitoring wichtiger Systemressourcen:

* **Speicheranalyse:** Prüfung von RAM-Auslastung und Disk-Usage (df -h).
* **Log-Checking:** Automatisierte Abfrage von Systemfehlern (dmesg / journalctl).
* **Netzwerk-Status:** Verifizierung der aktiven Netzwerk-Schnittstellen und IP-Adressen.
* **Prozess-Monitoring:** Identifikation von Top-Prozessen, die das System belasten.

## 🚀 Installation & Nutzung

1. **Repository klonen:**
   ```bash
   git clone [https://github.com/timgad794/linux-admin-toolbox.git](https://github.com/timgad794/linux-admin-toolbox.git)
   cd linux-admin-toolbox
