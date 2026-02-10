#!/usr/bin/env python3
import sys
from pylogix import PLC

def read_tag():
    if len(sys.argv) < 4:
        print("Nutzung: python3 cip_tag_reader.py <IP> <PORT> <TAG_NAME> [ANZAHL]")
        return

    ip = sys.argv[1]
    port = int(sys.argv[2])
    tag = sys.argv[3]
    count = int(sys.argv[4]) if len(sys.argv) > 4 else 1

    with PLC() as comm:
        comm.IPAddress = ip
        comm.Port = port
        ret = comm.Read(tag, count)
        
        if ret.Status == 'Success':
            if isinstance(ret.Value, list):
                # Filtert nur druckbare ASCII-Zeichen heraus
                text = "".join([chr(x) for x in ret.Value if 31 < x < 127])
                print(f"[+] Daten gefunden: {text}")
            else:
                print(f"[+] Wert: {ret.Value}")
        else:
            print(f"[-] Fehler: {ret.Status}")

if __name__ == "__main__":
    read_tag()
