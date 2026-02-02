#!/bin/bash

# ------------------------------------------------------------------
# Author: Mohamed Rahmoune (timgad794)
# GitHub: github.com/timgad794
# License: MIT
# ------------------------------------------------------------------

# Farben
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

printf "${BLUE}=======================================${NC}\n"
printf "${BLUE}        LINUX SYSTEM CHECK TOOL        ${NC}\n"
printf "${BLUE}=======================================${NC}\n"
printf "Zeitstempel: $(date '+%d.%m.%Y %H:%M:%S')\n"
printf "Benutzer:    $(whoami)\n"
printf "Hostname:    $(hostname)\n"
# Fix für Zeile 21:
printf "%s\n" "---------------------------------------"

# 1. Festplattenbelegung
printf "${YELLOW}[+] Festplattenbelegung (Root):${NC}\n"
df -h / | awk 'NR==2 { printf "  Speicher belegt: %s von %s (%s)\n", $3, $2, $5 }'

# 2. Arbeitsspeicher (Robusterer Fix)
printf "\n${YELLOW}[+] Arbeitsspeicher (RAM):${NC}\n"
# Wir nehmen 'available' falls vorhanden, sonst 'free'
free -h | awk '/^Mem:/ { print "  Verfügbar: " $7 " / Gesamt: " $2 }'

# 3. Netzwerk-Status
printf "\n${YELLOW}[+] Netzwerk-Status:${NC}\n"
ip -brief addr show scope global | awk '{printf "  %s: %s\n", $1, $3}'

# 4. System-Fehler
printf "\n${YELLOW}[+] Letzte System-Meldungen:${NC}\n"
if [[ $EUID -ne 0 ]]; then
    printf "  [!] Root-Rechte erforderlich für dmesg.\n"
else
    dmesg | tail -n 5 | sed 's/^/  /'
fi

# 5. Top-Prozesse
printf "\n${YELLOW}[+] Top 3 CPU-Verbraucher:${NC}\n"
ps -eo pcpu,comm --sort=-pcpu | head -n 4 | sed 's/^/  /'

# Fix für Zeile 47:
printf "%s\n" "---------------------------------------"
printf "${GREEN}Check erfolgreich abgeschlossen.${NC}\n"
