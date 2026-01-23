# 🐧 Linux-Admin- & Security-Toolbox

Dieses Repository dokumentiert meine praktische Ausbildung zum **Linux Systemadministrator** und **Security Specialist**. Es verbindet die theoretischen Lernziele der **LPIC-1** (Linux Professional Institute) mit den praktischen Herausforderungen der **Hack The Box Academy**.

📍 **Ziel:** Junior IT-Rolle im Raum **Dresden**.

---

## 🚀 Kernmodule & Skripte

### 📊 1. System-Monitoring (`system_check.sh`)
Ein Tool zur schnellen Diagnose des Systemzustands, entwickelt zur Automatisierung täglicher Admin-Aufgaben.
- **LPIC-Themen:** 101.3 (Boot-Logs), 102.1 (RAM/CPU-Management), 104.1 (Disk-Management) und 109.2 (Netzwerk-Konfiguration).
- **Features:** Echtzeit-Check von Speicherplatz, RAM-Verfügbarkeit, Netzwerk-Schnittstellen und kritischen Systemmeldungen (`dmesg`).

### 🛡️ 2. Security-Audit (`security_audit.sh`)
Ein sicherheitsorientiertes Skript zur Identifikation von Fehlkonfigurationen und Angriffsvektoren.
- **LPIC-Themen:** 104.5 (Berechtigungen/SUID) und 108.2 (System-Logging).
- **Security-Fokus (HTB):** - Suche nach **SUID-Binaries** (Privilege Escalation Pfade).
    - Erkennung aktiver Web-Infrastrukturen (Apache/Nginx).
    - Port-Audit zur Analyse der Angriffsfläche.
- **Logging:** Erstellt automatisch detaillierte Audit-Logs mit Zeitstempel im Ordner `./audit_logs`.

---

## 🛠 Installation & Nutzung

1. **Repository klonen:**
   ```bash
   git clone [https://github.com/timgad794/linux-admin-toolbox.git](https://github.com/timgad794/linux-admin-toolbox.git)
   cd linux-admin-toolbox
  
   chmod +x *.sh
   sudo ./security_audit.sh
