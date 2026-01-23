#!/bin/bash

# ------------------------------------------------------------------
# Autor: Tim Gad (timgad794)
# Projekt: LPIC-1 & Security Audit Tool
# ------------------------------------------------------------------

# Farben für Terminal
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Prüfung: Läuft das Skript als root?
if [[ $EUID -ne 0 ]]; then
   printf "${RED}Fehler: Dieses Skript benötigt root-Rechte für den SUID-Check.${NC}\n"
   exit 1
fi

# 1. Variablen & Log-Setup
LOG_DIR="./audit_logs"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/audit_$TIMESTAMP.log"

# Log-Funktion
log_message() {
    printf "$1\n"
    printf "$2\n" >> "$LOG_FILE"
}

# Header
echo "--- Audit gestartet am $(date) ---" > "$LOG_FILE"
log_message "${RED}--- SECURITY & WEB AUDIT START ---${NC}" ""

# 2. Web-Server Check
log_message "${YELLOW}[*] Suche nach Webservern...${NC}" "[*] Webserver-Check:"
if pgrep -x "apache2" > /dev/null; then
    log_message "${GREEN}[+] Apache gefunden.${NC}" "Apache gefunden."
    ls -ld /var/www/html >> "$LOG_FILE" 2>&1
elif pgrep -x "nginx" > /dev/null; then
    log_message "${GREEN}[+] Nginx gefunden.${NC}" "Nginx gefunden."
else
    log_message "${RED}[-] Kein Webserver aktiv.${NC}" "Kein Webserver aktiv."
fi

# 3. SUID-Check (LPIC 104.5)
log_message "\n${YELLOW}[*] SUID-Files (Top 5 Angriffspunkte):${NC}" "[*] SUID-Files:"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -n 5 >> "$LOG_FILE"
find /usr/bin -perm -4000 -type f 2>/dev/null | head -n 5 | sed 's/^/  /'

# 4. Ports-Check (LPIC 109.2)
log_message "\n${YELLOW}[*] Listening Ports:${NC}" "[*] Netzwerk-Ports:"
ss -tuln | grep LISTEN >> "$LOG_FILE"
ss -tuln | grep LISTEN | head -n 5 | sed 's/^/  /'

log_message "\n${GREEN}[+] Audit abgeschlossen. Log: $LOG_FILE${NC}" ""
