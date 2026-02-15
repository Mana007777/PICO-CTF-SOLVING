#!/bin/bash
# Author: Prince Niyonshuti N.
# Description: Extract hidden Base64-encoded flag from PDF metadata.

# Step 1: Download the PDF (optional if already downloaded)
# wget https://challenge-files.picoctf.net/c_amiable_citadel/ec88ce83253c1bd53af98533a401b9ea0b37602fd6276271c724d5cdd126b285/confidential.pdf -O confidential.pdf

# Step 2: Inspect PDF metadata
pdfinfo confidential.pdf

# Step 3: Decode hidden Base64 string from Author field
# The Base64 string found in metadata: cGljb0NURntwdXp6bDNkX20zdGFkYXRhX2YwdW5kIV8wZTJkZTVhMX0=
echo "cGljb0NURntwdXp6bDNkX20zdGFkYXRhX2YwdW5kIV8wZTJkZTVhMX0=" | base64 --decode
