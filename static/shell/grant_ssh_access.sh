#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if a username and a public key were provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 'username' 'ssh-public-key'"
  exit 1
fi

# Define variables
FEDML_SSH_GROUP="fedml_ssh_group"
USERNAME="$1"  # Use the provided username
AUTHORIZED_KEYS_DIR="/home"
PUBLIC_KEY="$2"  # Use the provided public key

# Check if the username already exists
if id "$USERNAME" &>/dev/null; then
  echo "Error: The username '$USERNAME' already exists. Please choose a different username."
  exit 1
fi

# Create the fedml ssh group if it doesn't already exist
sudo groupadd -f $FEDML_SSH_GROUP

# Create a user with the provided username and assign them to the fedml ssh group
sudo useradd -m -s /bin/bash -g $FEDML_SSH_GROUP $USERNAME

# Create the .ssh directory for the user
USER_SSH_DIR="$AUTHORIZED_KEYS_DIR/$USERNAME/.ssh"
sudo mkdir -p $USER_SSH_DIR
sudo chmod 700 $USER_SSH_DIR

# Add the public key to the user's authorized_keys file
AUTHORIZED_KEYS_PATH="$USER_SSH_DIR/authorized_keys"
echo $PUBLIC_KEY | sudo tee $AUTHORIZED_KEYS_PATH > /dev/null
sudo chmod 600 $AUTHORIZED_KEYS_PATH
sudo chown -R $USERNAME:$FEDML_SSH_GROUP $USER_SSH_DIR

# Restrict access to the user's own directory only
sudo chmod -R 700 $AUTHORIZED_KEYS_DIR/$USERNAME

# Ensure no sudo privileges for the user
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/false" | sudo tee $SUDOERS_FILE > /dev/null
sudo chmod 440 $SUDOERS_FILE

# Output the provided username
echo "Access granted to $USERNAME"
