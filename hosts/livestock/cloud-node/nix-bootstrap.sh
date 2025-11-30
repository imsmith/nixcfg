#!/usr/bin/env bash
set -euo pipefail

# Configuration
REPO_URL="https://github.com/yourusername/nixos-config.git"
CONFIG_DIR="/etc/nixos"

# Clone or pull configuration
if [ -d "$CONFIG_DIR/.git" ]; then
  echo "Updating existing configuration..."
  cd "$CONFIG_DIR"
  git pull
else
  echo "Cloning configuration repository..."
  git clone "$REPO_URL" "$CONFIG_DIR"
fi

# Build and switch to new configuration
echo "Building NixOS configuration..."
nixos-rebuild switch --flake "$CONFIG_DIR#net-node"

echo "Bootstrap complete!"