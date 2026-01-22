
#!/bin/bash

# ------------------------------------------------------------------
# Autor: Tim Gad
# Projekt: LPIC-1 Übung - System-Check Tool (Dresden IT-Einstieg)
# Beschreibung: Monitoring von CPU, RAM, Disk und Netzwerk
# ------------------------------------------------------------------

# Definition von Farben für eine professionelle Terminal-Ausgabe
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color (Reset)

echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}       LINUX SYSTEM CHECK TOOL         ${NC}"
echo -e "${BLUE}=======================================${NC}"
echo -e "Zeitstempel: $(date '+%d.%m.%Y %H:%M:%S')"
echo -e "Benutzer:    $(whoami)"
echo -e "Hostname:    $(hostname)"
echo "---------------------------------------"

# 1. Festplattenbelegung (LPIC Topic 104.1)
echo -e "${YELLOW}[+] Festplattenbelegung (Root-Partition):${NC}"
df -h / | grep -v "Filesystem" | awk '{ print "Speicher belegt: " $5 " von " $2 }'
# Zeigt alle Partitionen kurz an
df -h --total | grep "total"

echo ""

# 2. Arbeitsspeicher (LPIC Topic 102.1)
echo -e "${YELLOW}[+] Arbeitsspeicher (RAM):${NC}"
free -h | grep "Mem:" | awk '{ print "Verfügbar: " $7 " / Gesamt: " $2 }'

echo ""

# 3. Netzwerk-Konfiguration (LPIC Topic 109.2)
echo -e "${YELLOW}[+] Netzwerk-Status:${NC}"
# Zeigt IP-Adressen ohne Loopback an
ip -brief addr show scope global | awk '{print $1 ": " $3}'

echo ""

# 4. System-Fehler aus den Logs (LPIC Topic 108.2)
echo -e "${YELLOW}[+] Letzte kritische System-Meldungen:${NC}"
dmesg | tail -n 5 | sed 's/^/  /'

echo ""

# 5. Top-Prozesse (LPIC Topic 103.5)
echo -e "${YELLOW}[+] Top 3 CPU-Verbraucher:${NC}"
ps -eo pcpu,comm --sort=-pcpu | head -n 4 | sed 's/^/  /'

echo "---------------------------------------"
echo -e "${GREEN}Check erfolgreich abgeschlossen.${NC}"
