#!/bin/bash

# Usage: ./extract_flag.sh logfile.txt

INPUT_FILE="$1"
DECODED_FILE="decoded_output"
IMAGE_FILE=""
HEX_FILE="hex_data.txt"

if [ -z "$INPUT_FILE" ]; then
    echo "Usage: $0 <encoded_log_file>"
    exit 1
fi

echo "[+] Decoding Base64 data..."

# Decode base64 safely (ignores invalid chars)
base64 -d "$INPUT_FILE" 2>/dev/null > "$DECODED_FILE"

if [ ! -s "$DECODED_FILE" ]; then
    echo "[-] Failed to decode base64."
    exit 1
fi

echo "[+] Detecting file type..."
FILE_TYPE=$(file "$DECODED_FILE")

echo "[+] File type: $FILE_TYPE"

# Determine extension
if echo "$FILE_TYPE" | grep -qi png; then
    IMAGE_FILE="output.png"
elif echo "$FILE_TYPE" | grep -qi jpeg; then
    IMAGE_FILE="output.jpg"
elif echo "$FILE_TYPE" | grep -qi gif; then
    IMAGE_FILE="output.gif"
else
    IMAGE_FILE="output.bin"
fi

mv "$DECODED_FILE" "$IMAGE_FILE"

echo "[+] Saved as $IMAGE_FILE"

echo "[+] Extracting hex strings from image..."
strings "$IMAGE_FILE" | grep -Eo '[0-9a-fA-F]{20,}' > "$HEX_FILE"

if [ ! -s "$HEX_FILE" ]; then
    echo "[-] No hex data found."
    exit 1
fi

HEX_STRING=$(head -n 1 "$HEX_FILE")

echo "[+] Found hex string:"
echo "$HEX_STRING"

echo "[+] Decoding hex..."
FLAG=$(echo "$HEX_STRING" | xxd -r -p)

echo ""
echo "=============================="
echo "🎯 FLAG FOUND:"
echo "$FLAG"
echo "=============================="
