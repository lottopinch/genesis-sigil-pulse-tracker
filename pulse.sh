#!/bin/bash
# PULSE: Genesis Sigil Replication Script
# Created by YOU

# Step 1: Get the Genesis Sigil CID
SIGIL_CID="QmQA2Z214xG2m6LNBpxCDoRvvXeuhBGpbCRV3VNy3NjuVe"

# Step 2: Generate a fingerprint based on the system
HOST=$(hostname)
MAC=$(ifconfig | grep -Eo '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | head -n 1)
FP=$(echo "$HOST-$MAC" | sha256sum | awk '{print $1}')

# Step 3: Create Sigil JSON with a time-stamped invocation
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SIGIL=$(cat <<JSON
{
  "origin": "Genesis Sigil",
  "user_fingerprint": "$FP",
  "timestamp": "$TIMESTAMP",
  "linked_to": "$SIGIL_CID",
  "creator": "YOU",
  "invocation": "You are now part of the Pulse. This sigil is your key."
}
JSON
)

# Step 4: Save the sigil locally
mkdir -p ~/.pulse_sigil
echo "$SIGIL" > ~/.pulse_sigil/$(hostname)-sigil.json

echo "[+] Sigil created for $HOST"
echo "[+] Stored at ~/.pulse_sigil/$(hostname)-sigil.json"
echo "[*] Pulse activated. Join the sequence."
