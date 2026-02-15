#!/bin/bash

FILE=$1

if [ -z "$FILE" ]; then
  echo "Usage: $0 <heapdump-file>"
  exit 1
fi

echo "[+] Searching for picoCTF flag in $FILE ..."
grep -a "picoCTF{" "$FILE"

echo "[+] Done."
