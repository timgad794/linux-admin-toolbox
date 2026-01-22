#!/bin/bash

# ------------------------------------------------------------------
# Autor: Tim Gad (timgad794)
# Projekt: LPIC-1 & Security Audit Tool
# ------------------------------------------------------------------

# 1. Variablen & Log-Setup
LOG_DIR="./audit_logs"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/audit_$TIMESTAMP.log"

# Farben für Terminal
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# 2. Log-Funktion (Robust für Bash & Sh)
log_message() {
    echo -e "$1"
    echo -e "$2" >> "$LOG_FILE"
}

# Header in Log schreiben
echo "--- Audit gestartet am $(date) ---" > "$LOG_FILE"

# 3. Audit-Start
log_message "${RED}--- SECURITY & WEB AUDIT START ---${NC}" ""

# Web-Server Check
log_message "${YELLOW}[*] Suche nach Webservern...${NC}" "[*] Webserver-Check:"
if pgrep -x "apache2" > /dev/null; then
    log_message "${GREEN}[+] Apache gefunden.${NC}" "Apache gefunden."
    ls -ld /var/www/html >> "$LOG_FILE" 2>&1
elif pgrep -x "nginx" > /dev/null; then
    log_message "${GREEN}[+] Nginx gefunden.${NC}" "Nginx gefunden."
else
    log_message "${RED}[-] Kein Webserver aktiv.${NC}" "Kein Webserver aktiv."
fi

# SUID-Check (Wichtig für HTB & LPIC 104.5)
log_message "\n${YELLOW}[*] SUID-Files (Angriffspunkte):${NC}" "[*] SUID-Files:"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -n 5 >> "$LOG_FILE"

# Ports-Check (LPIC 109.2)
log_message "\n${YELLOW}[*] Listening Ports:${NC}" "[*] Netzwerk-Ports:"
ss -tuln | grep LISTEN >> "$LOG_FILE"

log_message "\n${GREEN}[+] Audit abgeschlossen. Log: $LOG_FILE${NC}" ""
