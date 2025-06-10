#!/bin/bash

###############################################################
# This script installs Nimble Streamer server on Ubuntu 20.04 #
# Run this script with sudo                                   #
###############################################################

set -e
set -o pipefail  # Exit if any command in a pipeline fails

# Define variables
URL="http://nimblestreamer.com/gpg.key"
REPO_LINE="deb http://nimblestreamer.com/ubuntu focal/"
REPO_FILE="/etc/apt/sources.list.d/nimblestreamer.list"
GPG_KEYRING="/usr/share/keyrings/nimblestreamer-archive-keyring.gpg"
CONF_FILE="/etc/nimble/nimble.conf"

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

# Add Nimble repository to sources.list.d
echo "📦 Adding Nimble repository..."
echo "$REPO_LINE" > "$REPO_FILE"

# Download and add GPG key securely
echo "🔐 Downloading and adding GPG key from $URL..."

if ! wget -q -O - "$URL" | gpg --dearmor -o "$GPG_KEYRING"; then
    echo "Error: Failed to download or convert GPG key from $URL" >&2
    exit 1
fi

# Link GPG key to repo (modern APT way)
echo "deb [signed-by=$GPG_KEYRING] http://nimblestreamer.com/ubuntu focal/" > "$REPO_FILE"

echo "✅ GPG key added and repository configured."

# Install Nimble Streamer
echo "Installing Nimble Streamer..."
apt-get update
apt-get install -y nimble nimble-srt

# Add setting to Nimble configuration
echo "⚙️ Configuring Nimble..."

if [ -f "$CONF_FILE" ]; then
    echo "srt_multipoint_listener_enabled = true" >> "$CONF_FILE"
else
    echo "Error: $CONF_FILE not found." >&2
    exit 1
fi

# Restart Nimble service
echo "🔁 Restarting Nimble service..."
service nimble restart

echo "Nimble Streamer installation and setup complete."
