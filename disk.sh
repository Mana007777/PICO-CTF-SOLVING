#!/bin/bash
# find_flag.sh
# Author: Abdullah
# Description: Extract picoCTF flag from a disk image

# Check if disk image is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <disk_image>"
    exit 1
fi

DISK_IMAGE="$1"

# Check if the file exists
if [ ! -f "$DISK_IMAGE" ]; then
    echo "Error: File '$DISK_IMAGE' not found."
    exit 1
fi

echo "[*] Extracting strings from $DISK_IMAGE and searching for picoCTF flag..."

# Extract strings and search for picoCTF flag
FLAG=$(strings "$DISK_IMAGE" | grep -o "picoCTF{[^}]*}")

if [ -n "$FLAG" ]; then
    echo "[+] Flag found: $FLAG"
else
    echo "[-] Flag not found."
fi
