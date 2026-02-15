#!/bin/bash

# Path to the log file
LOG_FILE="server.log"

# Extract FLAGPART lines, remove duplicates, and concatenate them
FLAG=$(grep "FLAGPART:" "$LOG_FILE" | awk -F'FLAGPART: ' '{print $2}' | uniq | tr -d '\n')

# Print the reconstructed flag
echo "The flag is: $FLAG"
