#!/bin/bash

# ===============================
# JPEG Header Repair Script
# ===============================

FILE="$1"

if [ -z "$FILE" ]; then
    echo "Usage: $0 <jpeg-file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "File not found!"
    exit 1
fi

echo "================================"
echo "[+] Inspecting file header..."
echo "================================"

xxd "$FILE" | head -n 2

echo ""
echo "[+] Checking first bytes..."

HEADER=$(xxd -p -l 2 "$FILE")

if [ "$HEADER" = "ffd8" ]; then
    echo "[✓] JPEG header already correct."
else
    echo "[!] Corrupted header detected."
    echo "[+] Repairing header..."

    # overwrite first 2 bytes with FF D8
    printf '\xFF\xD8' | dd of="$FILE" bs=1 count=2 conv=notrunc 2>/dev/null

    echo "[✓] Header repaired."
fi

echo ""
echo "[+] Checking file ending..."

TAIL=$(xxd -p "$FILE" | tail -n 1 | grep -o 'ffd9')

if [ "$TAIL" != "ffd9" ]; then
    echo "[!] Missing JPEG end marker."
    echo "[+] Appending FF D9..."
    printf '\xFF\xD9' >> "$FILE"
    echo "[✓] End marker added."
else
    echo "[✓] End marker OK."
fi

echo ""
echo "[+] Verifying file type..."
file "$FILE"

echo ""
echo "[+] Previewing repaired header:"
xxd "$FILE" | head -n 2

echo ""
echo "================================"
echo "Repair complete."
echo "Try opening the image."
echo "================================"
