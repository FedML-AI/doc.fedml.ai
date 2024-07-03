#!/bin/bash

# Check if a public key was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <public_key>"
    exit 1
fi

PUBLIC_KEY=$1

# Set the path using the current user's home directory
SSH_DIR="$HOME/.ssh"
AUTH_KEYS_FILE="$SSH_DIR/authorized_keys"

mkdir -p "$SSH_DIR" && \
echo "$PUBLIC_KEY" >> "$AUTH_KEYS_FILE" && \
chmod 700 "$SSH_DIR" && \
chmod 600 "$AUTH_KEYS_FILE"

if [ $? -eq 0 ]; then
    echo "Public key successfully added to $AUTH_KEYS_FILE"
else
    echo "An error occurred while adding the public key"
    exit 1
fi