#!/bin/bash
set -e

LOG_FILE="../auth.log"
OUTPUT_DIR="../evidence"
BLACKLIST_FILE="$OUTPUT_DIR/blacklisted_ips.txt"

mkdir -p "$OUTPUT_DIR"

echo "=== SSH FAILED LOGIN ANALYSIS ===" > "$BLACKLIST_FILE"

grep "Failed password" "$LOG_FILE" \
| awk '{print $(NF-3)}' \
| sort \
| uniq -c \
| sort -nr >> "$BLACKLIST_FILE"

echo "[+] Blacklist analysis completed."

