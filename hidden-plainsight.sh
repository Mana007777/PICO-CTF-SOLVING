#!/bin/bash

# Check if image filename is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <image_file>"
    exit 1
fi

IMAGE="$1"

# Step 1: Read Comment metadata from the image
ENCODED=$(exiftool -Comment -s -s -s "$IMAGE")
if [ -z "$ENCODED" ]; then
    echo "No Comment metadata found in $IMAGE"
    exit 1
fi

echo "Encoded metadata found: $ENCODED"

# Step 2: Decode the first layer of Base64
FIRST_DECODE=$(echo "$ENCODED" | base64 --decode)
echo "First decode: $FIRST_DECODE"

# Step 3: Extract the password (after 'steghide:')
PASSWORD=$(echo "$FIRST_DECODE" | cut -d':' -f2)

# Step 4: Decode the password again if it's Base64
PASSWORD=$(echo "$PASSWORD" | base64 --decode)
echo "Password for steghide: $PASSWORD"

# Step 5: Extract the hidden file using steghide
steghide extract -sf "$IMAGE" -p "$PASSWORD"

echo "Extraction complete. Check current directory for extracted files."
