#!/bin/bash

# ------------------------------------------------------------------
# Autor: Tim Gad (timgad794)
# Projekt: LPIC-1 & Security Audit Tool
# Beschreibung: Prüfung von Webserver-Status, SUID-Bits und Ports
# ------------------------------------------------------------------

# Verzeichnis für Logs erstellen (Best Practice für Audits)
LOG_DIR="./audit_logs"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/audit_$TIMESTAMP.log"

# Definition von Farben für das Terminal
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Funktion zur gleichzeitigen Ausgabe (Terminal & Log-Datei)
log_message() {
    echo -e "$1"
    echo -e "$2" >> "$LOG_FILE"
}

# Start-Header
echo "--- Audit gestartet am $(date) ---" > "$LOG_FILE"
log_message "${RED}--- SECURITY & WEB AUDIT START ---${NC}" ""

# 1. Web-Server Analyse (HTB & LPIC Fokus)
log_message "${YELLOW}[*] Suche nach installierten Webservern...${NC}" "[*] Webserver-Check:"
if pgrep -x "apache2" > /dev/null || pgrep -x "httpd" > /dev/null; then
    log_message "${GREEN}[+] Apache gefunden.${NC}" "Apache gefunden."
    log_message "Prüfe Verzeichnis-Berechtigungen (/var/www/html)..." ""
    ls -ld /var/www/html >> "$LOG_FILE"
elif pgrep -x "nginx" > /dev/null; then
    log_message "${GREEN}[+] Nginx gefunden.${NC}" "Nginx gefunden."
else
    log_message "${RED}[-] Kein bekannter Webserver aktiv.${NC}" "Kein Webserver aktiv."
fi

# 2. SUID-Check (HTB / Privilege Escalation Fokus - LPIC Topic 104.5)
log_message "\n${YELLOW}[*] Suche nach SUID-Files (Potenzielle Angriffspunkte):${NC}" "[*] SUID-Files:"
# Findet Dateien mit gesetztem SUID-Bit, die oft für PrivEsc genutzt werden
find /usr/bin -perm -4000 -type f 2>/dev/null | head -n 10 >> "$LOG_FILE"

# 3. Server-Analyse: Netzwerk-Ports (LPIC Topic 109.2)
log_message "\n${YELLOW}[*] Aktive Listening-Ports (Netzwerk-Analyse):${NC}" "[*] Listening Ports:"
ss -tuln | grep LISTEN >> "$LOG_FILE"

# Abschluss
log_message "\n${GREEN}[+] Audit erfolgreich abgeschlossen.${NC}" "Audit beendet."
log_message "${BLUE}Log gespeichert unter: $LOG_FILE${NC}" ""
