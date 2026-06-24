#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "==> Updating apt packages..."
apt-get update -qq
apt-get upgrade -y -qq

echo "==> Installing Node.js and npm..."
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt-get install -y nodejs
fi

node --version
npm --version

echo "==> Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

claude --version || true

echo "==> Provisioning complete."
