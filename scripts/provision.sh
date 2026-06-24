#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

APT_OPTS=(-o DPkg::Lock::Timeout=300 -o APT::Acquire::Retries=3)

wait_for_apt() {
  local timeout=300
  local elapsed=0

  while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 \
     || fuser /var/lib/apt/lists/lock >/dev/null 2>&1 \
     || fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    if (( elapsed >= timeout )); then
      echo "Timed out waiting for apt/dpkg locks"
      exit 1
    fi
    echo "==> Waiting for apt/dpkg locks (${elapsed}s)..."
    sleep 5
    elapsed=$((elapsed + 5))
  done
}

if command -v cloud-init >/dev/null 2>&1; then
  echo "==> Waiting for cloud-init to finish..."
  cloud-init status --wait || true
fi

wait_for_apt

echo "==> Updating apt packages..."
apt-get "${APT_OPTS[@]}" update -qq
wait_for_apt
apt-get "${APT_OPTS[@]}" upgrade -y -qq

echo "==> Installing Node.js and npm..."
if ! command -v node >/dev/null 2>&1; then
  wait_for_apt
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  wait_for_apt
  apt-get "${APT_OPTS[@]}" install -y nodejs
fi

node --version
npm --version

echo "==> Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

claude --version || true

echo "==> Provisioning complete."
