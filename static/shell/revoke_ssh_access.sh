#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if a username was provided
if [ -z "$1" ]; then
  echo "Usage: $0 'username'"
  exit 1
fi

# Define variables
USERNAME="$1"
FEDML_SSH_GROUP="fedml_ssh_group"
AUTHORIZED_KEYS_DIR="/home"
USER_HOME_DIR="$AUTHORIZED_KEYS_DIR/$USERNAME"

# Check if the user exists
if id "$USERNAME" &>/dev/null; then
  echo "Revoking access and terminating sessions for user: $USERNAME"

  # Kill all processes owned by the user
  sudo pkill -u $USERNAME

  # Wait a moment to ensure all processes are terminated
  sleep 1

  # Delete the user and their home directory
  sudo userdel -r $USERNAME

  # Remove the user's sudoers file if it exists
  SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
  if [ -f "$SUDOERS_FILE" ]; then
    sudo rm -f $SUDOERS_FILE
  fi

  # Clean up any remaining files or directories associated with the user
  if [ -d "$USER_HOME_DIR" ]; then
    sudo rm -rf $USER_HOME_DIR
  fi

  echo "Access revoked, sessions terminated, and user space cleaned for $USERNAME"
else
  echo "User $USERNAME does not exist"
fi
