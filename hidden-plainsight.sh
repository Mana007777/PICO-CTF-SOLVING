#!/bin/bash


if [ -z "$1" ]; then
    echo "Usage: $0 <image_file>"
    exit 1
fi

IMAGE="$1"


ENCODED=$(exiftool -Comment -s -s -s "$IMAGE")
if [ -z "$ENCODED" ]; then
    echo "No Comment metadata found in $IMAGE"
    exit 1
fi

echo "Encoded metadata found: $ENCODED"


FIRST_DECODE=$(echo "$ENCODED" | base64 --decode)
echo "First decode: $FIRST_DECODE"


PASSWORD=$(echo "$FIRST_DECODE" | cut -d':' -f2)

PASSWORD=$(echo "$PASSWORD" | base64 --decode)
echo "Password for steghide: $PASSWORD"

steghide extract -sf "$IMAGE" -p "$PASSWORD"

echo "Extraction complete. Check current directory for extracted files."
