#!/bin/bash

LOG_FILE="server.log"

FLAG=$(grep "FLAGPART:" "$LOG_FILE" | awk -F'FLAGPART: ' '{print $2}' | uniq | tr -d '\n')

echo "The flag is: $FLAG"
